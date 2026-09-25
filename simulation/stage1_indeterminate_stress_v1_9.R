# ================================================================
# CIPN randomized Phase II - Cohort 1
# Indeterminate endpoint stress test for Stage 1 CP
# Version 1.9
# Date: 2026-09-25
#
# Working design:
#   N = 50 per arm
#   Stage 1 nominal allocation = 18/18/18 (54 total)
#   Project Go if max(CP_L, CP_H) >= 70%
#   CP future assumptions: qP=0.45, qT=0.30
#   Final promising threshold: RD >= 10%
#
# Current Stage 1 missing-data method:
#   available-case + consumed-slot CP
#
# Stress-test assumptions:
#   - permanent indeterminate probability is 0%, 5%, or 10% per participant
#   - missingness is independent of the latent binary endpoint (MCAR)
#   - same missingness probability in all three arms
#   - the latent endpoint is retained only to quantify how often the
#     available-case decision differs from the decision that would have
#     been made if all Stage 1 endpoints had been observed
#
# Worst-case sensitivity:
#   placebo missing -> non-event
#   active-arm missing -> event
#
# Best-case sensitivity:
#   placebo missing -> event
#   active-arm missing -> non-event
#
# The calculation uses exact enumeration; no Monte Carlo.
# ================================================================

source("simulation/cp_futility_engine.R")

N <- 50
R <- 18
cp_cut <- 0.70
delta_go <- 0.10
qP <- 0.45
qT <- 0.30

# ------------------------------------------------
# Available-case + consumed-slot individual CP
# ------------------------------------------------
cp_ac_cs <- function(
  xp, EP, RP,
  xt, ET, RT
) {
  cp_individual_consumed_slot_exact(
    xp = xp, EP = EP, RP = RP,
    xt = xt, ET = ET, RT = RT,
    NP = N, NT = N,
    delta_go = delta_go,
    qP = qP, qT = qT
  )
}

# Standard no-missing CP lookup, used for:
#   complete-data decision;
#   worst-case assignment;
#   best-case assignment.
cp_standard <- matrix(
  NA_real_,
  nrow=R+1,
  ncol=R+1
)

for (xp in 0:R) {
  for (xt in 0:R) {
    cp_standard[xp+1, xt+1] <-
      cp_individual_exact(
        xp=xp, np=R,
        xt=xt, nt=R,
        NP=N, NT=N,
        delta_go=delta_go,
        qP=qP, qT=qT
      )
  }
}

# Cache available-case CP values because many exact-enumeration
# states share the same (uP,xP,uT,xT).
cp_cache <- new.env(parent=emptyenv())

get_ac_cp <- function(uP, xP, uT, xT) {
  key <- paste(uP,xP,uT,xT,sep="_")

  if (!exists(key,envir=cp_cache,inherits=FALSE)) {
    EP <- R-uP
    ET <- R-uT

    assign(
      key,
      cp_ac_cs(
        xp=xP, EP=EP, RP=R,
        xt=xT, ET=ET, RT=R
      ),
      envir=cp_cache
    )
  }

  get(key,envir=cp_cache,inherits=FALSE)
}

# ------------------------------------------------
# Exact latent-state distribution for one arm
# ------------------------------------------------
# Categories among the 18 randomized Stage 1 participants:
#   observed event
#   observed non-event
#   missing event (latent)
#   missing non-event (latent)
#
# Return:
#   u     = total indeterminate
#   xobs  = observed event count
#   zmiss = latent event count among indeterminate subjects
# ------------------------------------------------
make_arm_states <- function(p_event, p_missing) {
  pe_obs <- (1-p_missing)*p_event
  pn_obs <- (1-p_missing)*(1-p_event)
  pe_mis <- p_missing*p_event
  pn_mis <- p_missing*(1-p_event)

  rows <- list()
  k <- 1L

  for (xobs in 0:R) {
    for (zmiss in 0:(R-xobs)) {
      for (wmiss in 0:(R-xobs-zmiss)) {

        nobs <- R-xobs-zmiss-wmiss

        logcoef <-
          lgamma(R+1) -
          lgamma(xobs+1) -
          lgamma(nobs+1) -
          lgamma(zmiss+1) -
          lgamma(wmiss+1)

        pr <- exp(logcoef) *
          pe_obs^xobs *
          pn_obs^nobs *
          pe_mis^zmiss *
          pn_mis^wmiss

        if (pr > 0) {
          rows[[k]] <- data.frame(
            u=zmiss+wmiss,
            xobs=xobs,
            zmiss=zmiss,
            prob=pr
          )
          k <- k+1L
        }
      }
    }
  }

  do.call(rbind,rows)
}

# ------------------------------------------------
# Four decision indicators for one active-vs-placebo comparison
# ------------------------------------------------
comparison_flags <- function(P,T) {
  uP <- P$u
  xP <- P$xobs
  zP <- P$zmiss

  uT <- T$u
  xT <- T$xobs
  zT <- T$zmiss

  # Available-case + consumed-slot.
  go_ac <-
    get_ac_cp(uP,xP,uT,xT) >= cp_cut

  # Worst for AK135:
  # placebo missing = no event;
  # treatment missing = event.
  go_worst <-
    cp_standard[xP+1, xT+uT+1] >= cp_cut

  # Best for AK135:
  # placebo missing = event;
  # treatment missing = no event.
  go_best <-
    cp_standard[xP+uP+1, xT+1] >= cp_cut

  # Counterfactual complete-data decision using the latent endpoints.
  go_complete <-
    cp_standard[xP+zP+1, xT+zT+1] >= cp_cut

  c(
    AC=go_ac,
    WORST=go_worst,
    BEST=go_best,
    COMPLETE=go_complete
  )
}

# ------------------------------------------------
# Exact project-level probabilities
# ------------------------------------------------
# Shared placebo is handled by conditioning on each placebo state.
# Low and High are independent conditional on that state.
# ------------------------------------------------
project_oc_exact <- function(
  pP_true,
  pL_true,
  pH_true,
  p_missing
) {
  Ps <- make_arm_states(pP_true,p_missing)
  Ls <- make_arm_states(pL_true,p_missing)
  Hs <- make_arm_states(pH_true,p_missing)

  total <- numeric(16)
  names(total) <- sprintf("%04d",0:15)

  encode <- function(x) {
    sum(as.integer(x) * c(8,4,2,1))
  }

  for (ip in seq_len(nrow(Ps))) {
    P <- Ps[ip,]
    pp <- P$prob

    distL <- numeric(16)
    distH <- numeric(16)

    for (il in seq_len(nrow(Ls))) {
      fl <- comparison_flags(P,Ls[il,])
      distL[encode(fl)+1] <-
        distL[encode(fl)+1] +
        Ls$prob[il]
    }

    for (ih in seq_len(nrow(Hs))) {
      fh <- comparison_flags(P,Hs[ih,])
      distH[encode(fh)+1] <-
        distH[encode(fh)+1] +
        Hs$prob[ih]
    }

    for (a in 0:15) {
      if (distL[a+1]==0) next

      bitsL <- as.logical(
        intToBits(a)[4:1]
      )

      for (b in 0:15) {
        if (distH[b+1]==0) next

        bitsH <- as.logical(
          intToBits(b)[4:1]
        )

        project_bits <- bitsL | bitsH
        code <- encode(project_bits)

        total[code+1] <-
          total[code+1] +
          pp *
          distL[a+1] *
          distH[b+1]
      }
    }
  }

  # Decode project-level state.
  state <- data.frame(
    code=0:15,
    AC=FALSE,
    WORST=FALSE,
    BEST=FALSE,
    COMPLETE=FALSE,
    prob=total
  )

  for (i in seq_len(nrow(state))) {
    z <- as.logical(intToBits(state$code[i])[4:1])
    state[i,c("AC","WORST","BEST","COMPLETE")] <- z
  }

  data.frame(
    P_available_go =
      sum(state$prob[state$AC]),
    P_worst_go =
      sum(state$prob[state$WORST]),
    P_best_go =
      sum(state$prob[state$BEST]),
    P_complete_go =
      sum(state$prob[state$COMPLETE]),
    P_available_diff_complete =
      sum(state$prob[state$AC != state$COMPLETE]),
    P_available_go_complete_nogo =
      sum(state$prob[state$AC & !state$COMPLETE]),
    P_available_nogo_complete_go =
      sum(state$prob[!state$AC & state$COMPLETE]),
    P_worst_best_straddle =
      sum(state$prob[state$WORST != state$BEST]),
    P_available_diff_worst =
      sum(state$prob[state$AC != state$WORST]),
    P_available_diff_best =
      sum(state$prob[state$AC != state$BEST])
  )
}

scenario_grid <- data.frame(
  scenario=c(
    "null",
    "one_promising",
    "one_target",
    "both_target"
  ),
  pP=c(0.45,0.45,0.45,0.45),
  pL=c(0.45,0.45,0.45,0.30),
  pH=c(0.45,0.35,0.30,0.30)
)

rows <- list()
k <- 1L

for (pmiss in c(0,0.05,0.10)) {
  for (i in seq_len(nrow(scenario_grid))) {
    sc <- scenario_grid[i,]

    oc <- project_oc_exact(
      pP_true=sc$pP,
      pL_true=sc$pL,
      pH_true=sc$pH,
      p_missing=pmiss
    )

    rows[[k]] <- cbind(
      data.frame(
        missing_rate=pmiss,
        expected_indeterminate_total=54*pmiss,
        P_any_indeterminate=1-(1-pmiss)^54,
        scenario=sc$scenario
      ),
      oc
    )

    k <- k+1L
  }
}

out <- do.call(rbind,rows)

dir.create(
  "simulation/results",
  recursive=TRUE,
  showWarnings=FALSE
)

write.csv(
  out,
  "simulation/results/stage1_indeterminate_stress_v1_9.csv",
  row.names=FALSE
)

print(out)
