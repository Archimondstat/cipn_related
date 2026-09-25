# ================================================================
# AK135 CIPN randomized Phase II - Cohort 1
# Current conditional-power and descriptive-efficacy engine
# Version 2.0
# Date: 2026-09-25
#
# CURRENT WORKING DESIGN
#   Final N = 50 per arm; total N = 150
#   Stage 1 cohort = first 54 randomized participants overall
#   Nominal equal Stage 1 allocation = 18/18/18
#   Endpoint: CTCAE grade >=2 CIPN (unfavorable event)
#   Effect: Delta = p_placebo - p_treatment; positive favors AK135
#
# Planning rates used for CP projection:
#   p_placebo_design = 0.45
#   p_treatment_design = 0.30
#   implied design-alternative RD = 0.15
#
# IMPORTANT:
#   The 0.15 RD is implied by the central planning rates. It is NOT
#   assumed to be an invariant drug effect across placebo rates.
#
# Final descriptive efficacy framework:
#   Delta_max < 0.05          -> No-Go leaning
#   0.05 <= Delta_max < 0.10  -> Consider
#   Delta_max >= 0.10         -> Go leaning
#
# Stage 1 binding rule:
#   M = max(CP_L, CP_H)
#   M >= 0.70 -> Project Go
#   M <  0.70 -> Project No-Go
#
# No Stage 1 dose dropping. Both doses continue after Project Go.
# No formal efficacy hypothesis testing is part of the Phase II
# descriptive framework.
#
# Permanently indeterminate Stage 1 endpoints use:
#   available-case + consumed-slot CP.
# ================================================================


# ----------------------------------------------------------------
# 0. Current design specification
# ----------------------------------------------------------------

cipn_design_spec <- function() {
  list(
    N_per_arm = 50L,
    N_total = 150L,
    stage1_total = 54L,
    stage1_nominal_per_arm = 18L,
    p_placebo_design = 0.45,
    p_treatment_design = 0.30,
    design_alternative_rd = 0.15,
    weak_effect_boundary = 0.05,
    promising_threshold = 0.10,
    stage1_cp_cutoff = 0.70
  )
}


# ----------------------------------------------------------------
# 1. Validation helpers
# ----------------------------------------------------------------

.check_count <- function(x, n, name = "x") {
  if (length(x) != 1L || length(n) != 1L ||
      is.na(x) || is.na(n) ||
      x < 0 || n < 0 || x > n ||
      abs(x - round(x)) > 1e-12 ||
      abs(n - round(n)) > 1e-12) {
    stop(sprintf("%s must be an integer count between 0 and n.", name))
  }
}

.check_nonnegative_integer <- function(x, name = "x") {
  if (length(x) != 1L || is.na(x) || x < 0 ||
      abs(x - round(x)) > 1e-12) {
    stop(sprintf("%s must be a non-negative integer.", name))
  }
}

.check_prob <- function(p, name = "p") {
  if (length(p) != 1L || is.na(p) || p < 0 || p > 1) {
    stop(sprintf("%s must be in [0, 1].", name))
  }
}


# ----------------------------------------------------------------
# 2. Observed treatment effect
# ----------------------------------------------------------------

observed_treatment_effect <- function(
  x_placebo,
  n_placebo,
  x_treatment,
  n_treatment
) {
  .check_count(x_placebo, n_placebo, "x_placebo")
  .check_count(x_treatment, n_treatment, "x_treatment")

  if (n_placebo == 0 || n_treatment == 0) {
    stop("Observed treatment effect requires positive evaluable denominators.")
  }

  x_placebo / n_placebo -
    x_treatment / n_treatment
}


# ----------------------------------------------------------------
# 3. Final descriptive efficacy classification
# ----------------------------------------------------------------

classify_phase2_efficacy <- function(
  delta_low,
  delta_high,
  weak_effect_boundary = 0.05,
  promising_threshold = 0.10
) {
  delta_max <- max(delta_low, delta_high)

  if (delta_max < weak_effect_boundary) {
    return("No-Go leaning")
  }

  if (delta_max < promising_threshold) {
    return("Consider")
  }

  "Go leaning"
}


final_descriptive_summary <- function(
  xP, EP,
  xL, EL,
  xH, EH,
  weak_effect_boundary = 0.05,
  promising_threshold = 0.10
) {
  .check_count(xP, EP, "xP")
  .check_count(xL, EL, "xL")
  .check_count(xH, EH, "xH")

  if (EP == 0 || EL == 0 || EH == 0) {
    stop("Final descriptive summary requires positive evaluable denominators.")
  }

  pP <- xP / EP
  pL <- xL / EL
  pH <- xH / EH

  dL <- pP - pL
  dH <- pP - pH

  data.frame(
    p_placebo = pP,
    p_low = pL,
    p_high = pH,
    delta_low = dL,
    delta_high = dH,
    delta_max = max(dL, dH),
    classification = classify_phase2_efficacy(
      delta_low = dL,
      delta_high = dH,
      weak_effect_boundary = weak_effect_boundary,
      promising_threshold = promising_threshold
    ),
    stringsAsFactors = FALSE
  )
}


# ----------------------------------------------------------------
# 4. Exact individual CP when all already-randomized outcomes are
#    determinate
# ----------------------------------------------------------------
#
# Final promising event:
#
#   (xp + YP)/NP - (xt + YT)/NT >= promising_threshold
#
# Future assumptions:
#   YP ~ Bin(NP - np, qP)
#   YT ~ Bin(NT - nt, qT)
#
# This is the no-indeterminate special case of the consumed-slot CP.

cp_individual_exact <- function(
  xp,
  np,
  xt,
  nt,
  NP = 50,
  NT = 50,
  delta_go = 0.10,
  qP = 0.45,
  qT = 0.30
) {
  .check_count(xp, np, "xp")
  .check_count(xt, nt, "xt")
  .check_nonnegative_integer(NP, "NP")
  .check_nonnegative_integer(NT, "NT")
  .check_prob(qP, "qP")
  .check_prob(qT, "qT")

  if (NP < np || NT < nt) {
    stop("Final planned sample size must be >= interim sample size.")
  }

  mP <- NP - np
  mT <- NT - nt

  yP <- 0:mP
  p_yP <- dbinom(yP, size = mP, prob = qP)

  max_yT <- floor(
    NT * ((xp + yP) / NP - delta_go) -
      xt +
      1e-12
  )

  p_treatment_success <- pbinom(
    q = max_yT,
    size = mT,
    prob = qT
  )

  sum(p_yP * p_treatment_success)
}


# ----------------------------------------------------------------
# 5. Exact available-case + consumed-slot CP
# ----------------------------------------------------------------
#
# R = randomized / final-N slots already consumed
# E = endpoint-evaluable participants among R
# U = R - E = permanently indeterminate endpoints
# F = N - R = future recruitment capacity
#
# Indeterminate participants are not assigned an artificial binary
# endpoint and are not counted as future replaceable participants.
#
# Final available-case denominator under the projection:
#   E + F = N - U

cp_individual_consumed_slot_exact <- function(
  xp,
  EP,
  RP,
  xt,
  ET,
  RT,
  NP = 50,
  NT = 50,
  delta_go = 0.10,
  qP = 0.45,
  qT = 0.30
) {
  .check_count(xp, EP, "xp")
  .check_count(xt, ET, "xt")
  .check_nonnegative_integer(RP, "RP")
  .check_nonnegative_integer(RT, "RT")
  .check_nonnegative_integer(NP, "NP")
  .check_nonnegative_integer(NT, "NT")
  .check_prob(qP, "qP")
  .check_prob(qT, "qT")

  if (EP > RP || ET > RT) {
    stop("Evaluable count cannot exceed randomized/consumed count.")
  }

  if (RP > NP || RT > NT) {
    stop("Randomized/consumed count cannot exceed final planned N.")
  }

  FP <- NP - RP
  FT <- NT - RT

  final_eval_P <- EP + FP
  final_eval_T <- ET + FT

  if (final_eval_P <= 0 || final_eval_T <= 0) {
    stop("Projected final available-case denominators must be positive.")
  }

  yP <- 0:FP
  p_yP <- dbinom(yP, size = FP, prob = qP)

  max_yT <- floor(
    final_eval_T *
      ((xp + yP) / final_eval_P - delta_go) -
      xt +
      1e-12
  )

  p_treatment_success <- pbinom(
    q = max_yT,
    size = FT,
    prob = qT
  )

  sum(p_yP * p_treatment_success)
}


# ----------------------------------------------------------------
# 6. Current Stage 1 project-level decision
# ----------------------------------------------------------------
#
# The current decision statistic is NOT joint CP.
#
#   M = max(CP_L, CP_H)
#
# Project Go if M >= 0.70; otherwise Project No-Go.
#
# Each individual CP uses available-case + consumed-slot handling.

stage1_project_decision <- function(
  xp, EP, RP,
  xL, EL, RL,
  xH, EH, RH,
  NP = 50,
  NL = 50,
  NH = 50,
  promising_threshold = 0.10,
  qP = 0.45,
  qL = 0.30,
  qH = 0.30,
  cp_cutoff = 0.70
) {
  cpL <- cp_individual_consumed_slot_exact(
    xp = xp, EP = EP, RP = RP,
    xt = xL, ET = EL, RT = RL,
    NP = NP, NT = NL,
    delta_go = promising_threshold,
    qP = qP, qT = qL
  )

  cpH <- cp_individual_consumed_slot_exact(
    xp = xp, EP = EP, RP = RP,
    xt = xH, ET = EH, RT = RH,
    NP = NP, NT = NH,
    delta_go = promising_threshold,
    qP = qP, qT = qH
  )

  M <- max(cpL, cpH)

  data.frame(
    CP_L = cpL,
    CP_H = cpH,
    M = M,
    CP_cutoff = cp_cutoff,
    Project_Decision = ifelse(
      M >= cp_cutoff,
      "Go",
      "No-Go"
    ),
    stringsAsFactors = FALSE
  )
}


# ----------------------------------------------------------------
# 7. Exact joint CP utility
# ----------------------------------------------------------------
#
# Retained for historical/sensitivity work only.
# It is NOT the current Stage 1 project decision statistic.

cp_joint_exact <- function(
  xp,
  np,
  xL,
  nL,
  xH,
  nH,
  NP = 50,
  NL = 50,
  NH = 50,
  delta_go = 0.10,
  qP = 0.45,
  qL = 0.30,
  qH = 0.30
) {
  .check_count(xp, np, "xp")
  .check_count(xL, nL, "xL")
  .check_count(xH, nH, "xH")

  .check_prob(qP, "qP")
  .check_prob(qL, "qL")
  .check_prob(qH, "qH")

  if (NP < np || NL < nL || NH < nH) {
    stop("Final planned sample size must be >= interim sample size.")
  }

  mP <- NP - np
  mL <- NL - nL
  mH <- NH - nH

  yP <- 0:mP
  p_yP <- dbinom(yP, size = mP, prob = qP)

  max_yL <- floor(
    NL * ((xp + yP) / NP - delta_go) -
      xL +
      1e-12
  )

  max_yH <- floor(
    NH * ((xp + yP) / NP - delta_go) -
      xH +
      1e-12
  )

  pL_success <- pbinom(
    q = max_yL,
    size = mL,
    prob = qL
  )

  pH_success <- pbinom(
    q = max_yH,
    size = mH,
    prob = qH
  )

  p_any_success_given_yP <-
    1 - (1 - pL_success) * (1 - pH_success)

  sum(p_yP * p_any_success_given_yP)
}


# ----------------------------------------------------------------
# 8. CP lookup for no-indeterminate simulations
# ----------------------------------------------------------------

make_cp_lookup <- function(
  nP,
  nT,
  NP = 50,
  NT = 50,
  delta_go = 0.10,
  qP = 0.45,
  qT = 0.30
) {
  out <- expand.grid(
    xp = 0:nP,
    xt = 0:nT,
    KEEP.OUT.ATTRS = FALSE
  )

  out$cp <- mapply(
    FUN = cp_individual_exact,
    xp = out$xp,
    xt = out$xt,
    MoreArgs = list(
      np = nP,
      nt = nT,
      NP = NP,
      NT = NT,
      delta_go = delta_go,
      qP = qP,
      qT = qT
    )
  )

  out
}


# ----------------------------------------------------------------
# 9. Exact final descriptive-classification operating characteristics
# ----------------------------------------------------------------
#
# This is a design OC utility. It is not a formal hypothesis test.

final_classification_prob_exact <- function(
  N = 50,
  pP_true,
  pL_true,
  pH_true,
  weak_effect_boundary = 0.05,
  promising_threshold = 0.10
) {
  .check_prob(pP_true, "pP_true")
  .check_prob(pL_true, "pL_true")
  .check_prob(pH_true, "pH_true")

  x <- 0:N
  pP <- dbinom(x, size = N, prob = pP_true)
  pL <- dbinom(x, size = N, prob = pL_true)
  pH <- dbinom(x, size = N, prob = pH_true)

  p_nogo <- 0
  p_consider <- 0
  p_go <- 0

  for (xP in x) {
    for (xL in x) {
      delta_L <- (xP - xL) / N

      for (xH in x) {
        delta_H <- (xP - xH) / N
        pr <- pP[xP + 1] * pL[xL + 1] * pH[xH + 1]

        cls <- classify_phase2_efficacy(
          delta_low = delta_L,
          delta_high = delta_H,
          weak_effect_boundary = weak_effect_boundary,
          promising_threshold = promising_threshold
        )

        if (cls == "No-Go leaning") {
          p_nogo <- p_nogo + pr
        } else if (cls == "Consider") {
          p_consider <- p_consider + pr
        } else {
          p_go <- p_go + pr
        }
      }
    }
  }

  data.frame(
    N_per_arm = N,
    pP_true = pP_true,
    pL_true = pL_true,
    pH_true = pH_true,
    true_effect_low = pP_true - pL_true,
    true_effect_high = pP_true - pH_true,
    P_NoGo_leaning = p_nogo,
    P_Consider = p_consider,
    P_Go_leaning = p_go
  )
}


make_final_classification_grid <- function(
  N = 50,
  scenarios = data.frame(
    scenario = c(
      "null",
      "one_weak",
      "one_promising",
      "one_design_alternative",
      "both_design_alternative"
    ),
    pP = c(0.45, 0.45, 0.45, 0.45, 0.45),
    pL = c(0.45, 0.45, 0.45, 0.45, 0.30),
    pH = c(0.45, 0.40, 0.35, 0.30, 0.30)
  ),
  weak_effect_boundary = 0.05,
  promising_threshold = 0.10
) {
  rows <- vector("list", nrow(scenarios))

  for (i in seq_len(nrow(scenarios))) {
    z <- final_classification_prob_exact(
      N = N,
      pP_true = scenarios$pP[i],
      pL_true = scenarios$pL[i],
      pH_true = scenarios$pH[i],
      weak_effect_boundary = weak_effect_boundary,
      promising_threshold = promising_threshold
    )

    rows[[i]] <- cbind(
      data.frame(
        scenario = scenarios$scenario[i],
        stringsAsFactors = FALSE
      ),
      z
    )
  }

  do.call(rbind, rows)
}


# ----------------------------------------------------------------
# 10. Current nominal Stage 1 reference table
# ----------------------------------------------------------------
#
# Equal 18/18/18 allocation is for calibration only.
# Operational Stage 1 uses actual realized R/E counts.

make_current_stage1_reference_table <- function(
  event_differences = 0:4,
  N = 50,
  n1 = 18,
  promising_threshold = 0.10,
  qP = 0.45,
  qT = 0.30,
  cp_cutoff = 0.70
) {
  rows <- vector("list", length(event_differences))

  for (i in seq_along(event_differences)) {
    D <- event_differences[i]

    xp0 <- D
    xt0 <- 0

    cp <- cp_individual_exact(
      xp = xp0,
      np = n1,
      xt = xt0,
      nt = n1,
      NP = N,
      NT = N,
      delta_go = promising_threshold,
      qP = qP,
      qT = qT
    )

    rows[[i]] <- data.frame(
      N_per_arm = N,
      Stage1_nominal_n_per_arm = n1,
      Event_count_difference_xP_minus_xT = D,
      Nominal_observed_RD = D / n1,
      Individual_CP = cp,
      Meets_CP70 = cp >= cp_cutoff
    )
  }

  do.call(rbind, rows)
}


# ----------------------------------------------------------------
# 11. Monte Carlo utility for current complete-case Stage 1 design
# ----------------------------------------------------------------
#
# This assumes all nominal Stage 1 outcomes are determinate.
# Use the indeterminate-endpoint stress-test script when U > 0.

simulate_current_stage1 <- function(
  nsim = 100000,
  pP_true = 0.45,
  pL_true = 0.30,
  pH_true = 0.30,
  nP = 18,
  nL = 18,
  nH = 18,
  NP = 50,
  NL = 50,
  NH = 50,
  promising_threshold = 0.10,
  qP = 0.45,
  qL = 0.30,
  qH = 0.30,
  cp_cutoff = 0.70,
  seed = 20260925
) {
  set.seed(seed)

  lookup_L <- make_cp_lookup(
    nP = nP,
    nT = nL,
    NP = NP,
    NT = NL,
    delta_go = promising_threshold,
    qP = qP,
    qT = qL
  )

  lookup_H <- make_cp_lookup(
    nP = nP,
    nT = nH,
    NP = NP,
    NT = NH,
    delta_go = promising_threshold,
    qP = qP,
    qT = qH
  )

  cp_mat_L <- matrix(
    lookup_L$cp,
    nrow = nP + 1,
    ncol = nL + 1
  )

  cp_mat_H <- matrix(
    lookup_H$cp,
    nrow = nP + 1,
    ncol = nH + 1
  )

  xP <- rbinom(nsim, size = nP, prob = pP_true)
  xL <- rbinom(nsim, size = nL, prob = pL_true)
  xH <- rbinom(nsim, size = nH, prob = pH_true)

  cpL <- cp_mat_L[cbind(xP + 1, xL + 1)]
  cpH <- cp_mat_H[cbind(xP + 1, xH + 1)]
  M <- pmax(cpL, cpH)

  data.frame(
    sim = seq_len(nsim),
    xP = xP,
    xL = xL,
    xH = xH,
    effect_L = xP / nP - xL / nL,
    effect_H = xP / nP - xH / nH,
    cpL = cpL,
    cpH = cpH,
    M = M,
    Project_Go = M >= cp_cutoff
  )
}


# ----------------------------------------------------------------
# 12. Current-design outputs when executed directly
# ----------------------------------------------------------------

if (sys.nframe() == 0L) {
  dir.create(
    "simulation/results",
    recursive = TRUE,
    showWarnings = FALSE
  )

  spec <- cipn_design_spec()
  print(spec)

  stage1_reference <- make_current_stage1_reference_table()

  write.csv(
    stage1_reference,
    "simulation/results/current_stage1_reference_v2_0.csv",
    row.names = FALSE
  )

  print(stage1_reference)

  final_oc <- make_final_classification_grid(
    N = spec$N_per_arm
  )

  write.csv(
    final_oc,
    "simulation/results/current_final_classification_oc_v2_0.csv",
    row.names = FALSE
  )

  print(final_oc)

  # Example:
  # stage1_project_decision(
  #   xp = 8, EP = 18, RP = 18,
  #   xL = 6, EL = 18, RL = 18,
  #   xH = 7, EH = 18, RH = 18
  # )
}
