# ================================================================
# CIPN randomized Phase II - Cohort 1
# N=50/arm: 35% vs 40% IA robustness to mild arm imbalance
# Version 1.4
# Date: 2026-09-25
#
# Stage 1 project-level rule:
#   Go if max(CP_L, CP_H) >= 70%
#
# Final promising rule:
#   max(observed RD_L, observed RD_H) >= 10%
#
# This analysis does NOT assume a probability distribution for the
# imbalance. Instead, it evaluates deterministic envelopes around
# the nominal equal-allocation Stage 1 counts:
#   35% IA: total 54, nominal 18/18/18
#   40% IA: total 60, nominal 20/20/20
#
# Primary robustness envelope: +/-1 participant per arm.
# Stress envelope: +/-2 participants per arm.
#
# Exact binomial calculations; shared placebo handled explicitly.
# ================================================================

source("simulation/cp_futility_engine.R")

N <- 50
cp_cut <- 0.70
final_thr <- 0.10
qP <- 0.45
qT <- 0.30

make_allocations <- function(total_n, nominal_n, dev) {
  out <- list()
  k <- 1L

  for (nP in (nominal_n-dev):(nominal_n+dev)) {
    for (nL in (nominal_n-dev):(nominal_n+dev)) {
      nH <- total_n - nP - nL

      if (nH >= nominal_n-dev &&
          nH <= nominal_n+dev) {
        out[[k]] <- data.frame(
          nP = nP,
          nL = nL,
          nH = nH
        )
        k <- k + 1L
      }
    }
  }

  do.call(rbind, out)
}

stage1_go_prob_exact <- function(
  nP, nL, nH,
  pP, pL, pH
) {
  cpL <- matrix(
    make_cp_lookup(
      nP=nP, nT=nL, NP=N, NT=N,
      delta_go=final_thr, qP=qP, qT=qT
    )$cp,
    nrow=nP+1, ncol=nL+1
  )

  cpH <- matrix(
    make_cp_lookup(
      nP=nP, nT=nH, NP=N, NT=N,
      delta_go=final_thr, qP=qP, qT=qT
    )$cp,
    nrow=nP+1, ncol=nH+1
  )

  p_xP <- dbinom(0:nP, nP, pP)
  p_xL <- dbinom(0:nL, nL, pL)
  p_xH <- dbinom(0:nH, nH, pH)

  ans <- 0

  for (xP in 0:nP) {
    pL_go <- sum(
      p_xL[cpL[xP+1, ] >= cp_cut]
    )

    pH_go <- sum(
      p_xH[cpH[xP+1, ] >= cp_cut]
    )

    ans <- ans +
      p_xP[xP+1] *
      (1 - (1-pL_go)*(1-pH_go))
  }

  ans
}

future_final_go_prob <- function(
  xp, xL, xH,
  nP, nL, nH,
  pP, pL, pH
) {
  mP <- N-nP
  mL <- N-nL
  mH <- N-nH

  yP <- 0:mP
  p_yP <- dbinom(yP, mP, pP)

  ans <- 0

  for (i in seq_along(yP)) {
    yp <- yP[i]

    max_yL <- floor(
      N*((xp+yp)/N-final_thr)-xL+1e-12
    )

    max_yH <- floor(
      N*((xp+yp)/N-final_thr)-xH+1e-12
    )

    pL_success <- pbinom(max_yL, mL, pL)
    pH_success <- pbinom(max_yH, mH, pH)

    ans <- ans +
      p_yP[i] *
      (1-(1-pL_success)*(1-pH_success))
  }

  ans
}

full_design_oc_exact <- function(
  nP, nL, nH,
  pP, pL, pH
) {
  cpL <- matrix(
    make_cp_lookup(
      nP=nP, nT=nL, NP=N, NT=N,
      delta_go=final_thr, qP=qP, qT=qT
    )$cp,
    nrow=nP+1, ncol=nL+1
  )

  cpH <- matrix(
    make_cp_lookup(
      nP=nP, nT=nH, NP=N, NT=N,
      delta_go=final_thr, qP=qP, qT=qT
    )$cp,
    nrow=nP+1, ncol=nH+1
  )

  p_xP <- dbinom(0:nP, nP, pP)
  p_xL <- dbinom(0:nL, nL, pL)
  p_xH <- dbinom(0:nH, nH, pH)

  p_s1_go <- 0
  p_s1_go_final_go <- 0

  for (xP in 0:nP) {
    for (xL in 0:nL) {
      for (xH in 0:nH) {

        pr <-
          p_xP[xP+1] *
          p_xL[xL+1] *
          p_xH[xH+1]

        stage1_go <-
          cpL[xP+1, xL+1] >= cp_cut ||
          cpH[xP+1, xH+1] >= cp_cut

        if (stage1_go) {
          p_s1_go <- p_s1_go + pr

          p_s1_go_final_go <-
            p_s1_go_final_go +
            pr *
            future_final_go_prob(
              xp=xP, xL=xL, xH=xH,
              nP=nP, nL=nL, nH=nH,
              pP=pP, pL=pL, pH=pH
            )
        }
      }
    }
  }

  c(
    P_Stage1_Go = p_s1_go,
    P_Stage1_Go_and_Final_Go = p_s1_go_final_go
  )
}

scenario_list <- list(
  null = c(0, 0),
  low_only_target = c(0.15, 0),
  high_only_target = c(0, 0.15),
  both_target = c(0.15, 0.15)
)

rows <- list()
k <- 1L

for (dev in c(1,2)) {
  for (cfg in list(
    list(IA=0.35, total=54, nominal=18),
    list(IA=0.40, total=60, nominal=20)
  )) {

    alloc <- make_allocations(
      total_n=cfg$total,
      nominal_n=cfg$nominal,
      dev=dev
    )

    for (i in seq_len(nrow(alloc))) {
      a <- alloc[i,]

      for (sc_name in names(scenario_list)) {
        d <- scenario_list[[sc_name]]

        oc <- full_design_oc_exact(
          nP=a$nP,
          nL=a$nL,
          nH=a$nH,
          pP=0.45,
          pL=0.45-d[1],
          pH=0.45-d[2]
        )

        rows[[k]] <- data.frame(
          imbalance_envelope=dev,
          IA_fraction=cfg$IA,
          nP=a$nP,
          nL=a$nL,
          nH=a$nH,
          scenario=sc_name,
          P_Stage1_Go=oc["P_Stage1_Go"],
          P_Stage1_Go_and_Final_Go=
            oc["P_Stage1_Go_and_Final_Go"]
        )
        k <- k+1L
      }
    }
  }
}

out <- do.call(rbind, rows)

dir.create(
  "simulation/results",
  recursive=TRUE,
  showWarnings=FALSE
)

write.csv(
  out,
  "simulation/results/N50_IA35_40_imbalance_robustness_v1_4.csv",
  row.names=FALSE
)

print(out)
