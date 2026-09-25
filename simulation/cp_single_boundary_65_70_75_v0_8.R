# ================================================================
# CIPN randomized Phase II - Cohort 1
# Single-boundary Stage 1 CP operating characteristics
# Version 0.8
# Date: 2026-09-25
#
# Candidate design space:
#   N per arm = 44, 48, 52
#   Stage 1 information fraction = 35%, 40%, 45%
#   CP Go boundary = 65%, 70%, 75%
#
# Project-level Stage 1 rule:
#   M = max(CP_L, CP_H)
#   Go if M >= c
#   No-Go if M < c
#
# CP uses the future-data assumptions:
#   pP_future = 0.45
#   pT_future = 0.30
# and final promising threshold:
#   final observed placebo - treatment event-rate difference >= 0.10
#
# Exact probabilities are used; no Monte Carlo is required.
# ================================================================

source("simulation/cp_futility_engine.R")

N_grid <- c(44, 48, 52)
info_grid <- c(0.35, 0.40, 0.45)
cp_boundary_grid <- c(0.65, 0.70, 0.75)
true_effect_grid <- c(0, 0.05, 0.10, 0.15, 0.20)

pP_true <- 0.45
qP <- 0.45
qT <- 0.30
promising_threshold <- 0.10

round_half_up <- function(x) floor(x + 0.5)

prob_go_exact <- function(
  N,
  n1,
  cp_boundary,
  pP_true,
  pT_true
) {
  lookup <- make_cp_lookup(
    nP = n1,
    nT = n1,
    NP = N,
    NT = N,
    delta_go = promising_threshold,
    qP = qP,
    qT = qT
  )

  cp_mat <- matrix(
    lookup$cp,
    nrow = n1 + 1,
    ncol = n1 + 1
  )

  p_xP <- dbinom(0:n1, size = n1, prob = pP_true)
  p_xT <- dbinom(0:n1, size = n1, prob = pT_true)

  ans <- 0

  for (xP in 0:n1) {
    p_one_below <- sum(
      p_xT[cp_mat[xP + 1, ] < cp_boundary]
    )

    ans <- ans +
      p_xP[xP + 1] *
      (1 - p_one_below^2)
  }

  ans
}

cp_from_D <- function(N, n1, D) {
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
    delta_go = promising_threshold,
    qP = qP,
    qT = qT
  )
}

rows <- list()
k <- 1L

for (N in N_grid) {
  for (f1 in info_grid) {
    n1 <- round_half_up(N * f1)

    for (c in cp_boundary_grid) {

      D_candidates <- (-n1):n1
      cp_candidates <- vapply(
        D_candidates,
        function(D) cp_from_D(N, n1, D),
        numeric(1)
      )

      min_D_go <- min(
        D_candidates[cp_candidates >= c]
      )

      cp_at_min_D <- cp_from_D(
        N,
        n1,
        min_D_go
      )

      go_probs <- vapply(
        true_effect_grid,
        function(delta_true) {
          prob_go_exact(
            N = N,
            n1 = n1,
            cp_boundary = c,
            pP_true = pP_true,
            pT_true = pP_true - delta_true
          )
        },
        numeric(1)
      )

      rows[[k]] <- data.frame(
        N_per_arm = N,
        IA_fraction = f1,
        n1_per_arm = n1,
        CP_Go_boundary = c,
        Minimum_event_difference_for_individual_Go = min_D_go,
        Corresponding_observed_effect = min_D_go / n1,
        CP_at_minimum_event_difference = cp_at_min_D,
        P_Go_true_effect_0 = go_probs[1],
        P_Go_true_effect_5 = go_probs[2],
        P_Go_true_effect_10 = go_probs[3],
        P_Go_true_effect_15 = go_probs[4],
        P_Go_true_effect_20 = go_probs[5]
      )

      k <- k + 1L
    }
  }
}

out <- do.call(rbind, rows)

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  out,
  "simulation/results/cp_single_boundary_65_70_75_v0_8.csv",
  row.names = FALSE
)

print(out)
