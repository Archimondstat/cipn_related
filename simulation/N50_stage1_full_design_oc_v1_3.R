# ================================================================
# CIPN randomized Phase II - Cohort 1
# N=50 per arm: integrated Stage 1 + final operating characteristics
# Version 1.3
# Date: 2026-09-25
#
# Final N anchor:
#   50 per arm, total N=150
#
# Stage 1 candidates:
#   IA fraction = 35%, 40%, 45%
#   CP Go threshold = 65%, 70%, 75%
#
# Project-level Stage 1 rule used for this calibration:
#   Go if max(CP_L, CP_H) >= threshold
#   otherwise stop for insufficient efficacy.
#
# This script treats the Stage 1 rule as BINDING only for OC calibration,
# so that the full design consequence can be quantified.
#
# Exact binomial calculations; no Monte Carlo.
# ================================================================

source("simulation/cp_futility_engine.R")

N <- 50
pP_true <- 0.45
qP <- 0.45
qT <- 0.30
final_promising_threshold <- 0.10

info_grid <- c(0.35, 0.40, 0.45)
cp_grid <- c(0.65, 0.70, 0.75)

scenario_grid <- data.frame(
  scenario = c("0_0", "0_15", "5_15", "10_15", "15_15"),
  delta_L = c(0, 0, 0.05, 0.10, 0.15),
  delta_H = c(0, 0.15, 0.15, 0.15, 0.15)
)

round_half_up <- function(x) floor(x + 0.5)

cp_from_D <- function(n1, D) {
  if (D >= 0) {
    xp <- D
    xt <- 0
  } else {
    xp <- 0
    xt <- -D
  }

  cp_individual_exact(
    xp = xp,
    np = n1,
    xt = xt,
    nt = n1,
    NP = N,
    NT = N,
    delta_go = final_promising_threshold,
    qP = qP,
    qT = qT
  )
}

future_final_go_prob <- function(
  xp, xL, xH, n1,
  pP, pL, pH
) {
  m <- N - n1

  yP <- 0:m
  p_yP <- dbinom(yP, size = m, prob = pP)

  ans <- 0

  for (i in seq_along(yP)) {
    yp <- yP[i]

    max_yL <- floor(
      N * ((xp + yp) / N - final_promising_threshold) -
        xL + 1e-12
    )

    max_yH <- floor(
      N * ((xp + yp) / N - final_promising_threshold) -
        xH + 1e-12
    )

    pL_success <- pbinom(
      q = max_yL,
      size = m,
      prob = pL
    )

    pH_success <- pbinom(
      q = max_yH,
      size = m,
      prob = pH
    )

    ans <- ans +
      p_yP[i] *
      (1 - (1 - pL_success) * (1 - pH_success))
  }

  ans
}

full_design_oc_exact <- function(
  n1,
  cp_cutoff,
  pP,
  pL,
  pH
) {
  lookup <- make_cp_lookup(
    nP = n1,
    nT = n1,
    NP = N,
    NT = N,
    delta_go = final_promising_threshold,
    qP = qP,
    qT = qT
  )

  cp_mat <- matrix(
    lookup$cp,
    nrow = n1 + 1,
    ncol = n1 + 1
  )

  p_xP <- dbinom(0:n1, size = n1, prob = pP)
  p_xL <- dbinom(0:n1, size = n1, prob = pL)
  p_xH <- dbinom(0:n1, size = n1, prob = pH)

  p_stage1_go <- 0
  p_stage1_go_final_go <- 0

  for (xP in 0:n1) {
    for (xL in 0:n1) {
      for (xH in 0:n1) {

        pr <-
          p_xP[xP + 1] *
          p_xL[xL + 1] *
          p_xH[xH + 1]

        stage1_go <-
          cp_mat[xP + 1, xL + 1] >= cp_cutoff ||
          cp_mat[xP + 1, xH + 1] >= cp_cutoff

        if (stage1_go) {
          p_stage1_go <- p_stage1_go + pr

          p_stage1_go_final_go <-
            p_stage1_go_final_go +
            pr *
            future_final_go_prob(
              xp = xP,
              xL = xL,
              xH = xH,
              n1 = n1,
              pP = pP,
              pL = pL,
              pH = pH
            )
        }
      }
    }
  }

  final_no_ia <- final_classification_prob_exact(
    N = N,
    pP_true = pP,
    pL_true = pL,
    pH_true = pH,
    weak_effect_boundary = 0.05,
    promising_threshold = final_promising_threshold
  )$P_Go_leaning

  data.frame(
    P_Stage1_Go = p_stage1_go,
    P_Stage1_NoGo = 1 - p_stage1_go,
    P_Stage1_Go_and_Final_Go = p_stage1_go_final_go,
    P_Final_Go_without_binding_IA = final_no_ia,
    Final_Go_probability_lost_to_IA =
      final_no_ia - p_stage1_go_final_go
  )
}

rows <- list()
k <- 1L

for (f1 in info_grid) {
  n1 <- round_half_up(N * f1)

  for (c in cp_grid) {

    D_candidates <- (-n1):n1
    cp_candidates <- vapply(
      D_candidates,
      function(D) cp_from_D(n1, D),
      numeric(1)
    )

    min_D_go <- min(
      D_candidates[cp_candidates >= c]
    )

    for (i in seq_len(nrow(scenario_grid))) {
      sc <- scenario_grid[i, ]

      oc <- full_design_oc_exact(
        n1 = n1,
        cp_cutoff = c,
        pP = pP_true,
        pL = pP_true - sc$delta_L,
        pH = pP_true - sc$delta_H
      )

      rows[[k]] <- cbind(
        data.frame(
          N_per_arm = N,
          IA_fraction = f1,
          n1_per_arm = n1,
          CP_Go_threshold = c,
          Minimum_event_difference_for_individual_Go = min_D_go,
          Observed_RD_at_boundary = min_D_go / n1,
          Scenario = sc$scenario,
          true_effect_L = sc$delta_L,
          true_effect_H = sc$delta_H
        ),
        oc
      )

      k <- k + 1L
    }
  }
}

out <- do.call(rbind, rows)

dir.create("simulation/results", recursive = TRUE, showWarnings = FALSE)

write.csv(
  out,
  "simulation/results/N50_stage1_full_design_oc_v1_3.csv",
  row.names = FALSE
)

print(out)
