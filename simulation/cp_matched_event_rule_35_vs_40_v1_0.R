# ================================================================
# CIPN randomized Phase II - Cohort 1
# Matched event-count comparison: 35% vs 40% Stage 1
# Version 1.0
# Date: 2026-09-25
#
# Purpose:
# Compare 35% vs 40% IA at the same attainable Stage 1 signal:
# at least one active dose has >=2 fewer CIPN events than placebo.
#
# This avoids comparing nominal CP percentages that map to different
# integer event-count rules because of discreteness.
# ================================================================

source("simulation/cp_futility_engine.R")

N_grid <- c(44, 48, 52)
info_grid <- c(0.35, 0.40)
true_effect_grid <- c(0, 0.05, 0.10, 0.15, 0.20)

pP_true <- 0.45
D_go <- 2

round_half_up <- function(x) floor(x + 0.5)

prob_go_D_exact <- function(n1, D_go, pP_true, pT_true) {
  p_xP <- dbinom(0:n1, size = n1, prob = pP_true)
  p_xT <- dbinom(0:n1, size = n1, prob = pT_true)

  ans <- 0

  for (xP in 0:n1) {
    p_one_go <- sum(
      p_xT[(xP - (0:n1)) >= D_go]
    )

    ans <- ans +
      p_xP[xP + 1] *
      (1 - (1 - p_one_go)^2)
  }

  ans
}

cp_at_D <- function(N, n1, D) {
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
    delta_go = 0.10,
    qP = 0.45,
    qT = 0.30
  )
}

rows <- list()
k <- 1L

for (N in N_grid) {
  for (f1 in info_grid) {
    n1 <- round_half_up(N * f1)

    go_probs <- vapply(
      true_effect_grid,
      function(delta) {
        prob_go_D_exact(
          n1 = n1,
          D_go = D_go,
          pP_true = pP_true,
          pT_true = pP_true - delta
        )
      },
      numeric(1)
    )

    rows[[k]] <- data.frame(
      N_per_arm = N,
      IA_fraction = f1,
      n1_per_arm = n1,
      Event_difference_rule = D_go,
      Observed_effect_at_boundary = D_go / n1,
      CP_at_D1 = cp_at_D(N, n1, 1),
      CP_at_D2 = cp_at_D(N, n1, 2),
      CP_interval_for_exact_D2_rule_lower_exclusive =
        cp_at_D(N, n1, 1),
      CP_interval_for_exact_D2_rule_upper_inclusive =
        cp_at_D(N, n1, 2),
      P_Go_true_effect_0 = go_probs[1],
      P_Go_true_effect_5 = go_probs[2],
      P_Go_true_effect_10 = go_probs[3],
      P_Go_true_effect_15 = go_probs[4],
      P_Go_true_effect_20 = go_probs[5]
    )

    k <- k + 1L
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
  "simulation/results/cp_matched_D2_35_vs_40_v1_0.csv",
  row.names = FALSE
)

print(out)
