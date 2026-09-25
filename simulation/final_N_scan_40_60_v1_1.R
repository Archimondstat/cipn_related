# ================================================================
# CIPN randomized Phase II - Cohort 1
# Final sample-size scan, N = 40 to 60 per arm
# Version 1.1
# Date: 2026-09-25
#
# Purpose:
# Select a final-N region before re-introducing IA timing and CP.
#
# Final efficacy rule used for this screen:
#   Delta_max = max(Delta_L, Delta_H)
#   Final promising if Delta_max >= 0.10
#
# Scenarios:
#   (0,0), (0,15), (5,15), (10,15), (15,15)
# where entries are true treatment effects for Low and High.
#
# Exact binomial probabilities are used, conditioning on shared placebo.
# Precision is a simple Wald-style half-width under the target
# pP=0.45, pT=0.30 scenario, included only as a rough planning metric.
# ================================================================

source("simulation/cp_futility_engine.R")

N_grid <- 40:60
pP_true <- 0.45

scenario_grid <- data.frame(
  scenario = c("0_0","0_15","5_15","10_15","15_15"),
  delta_L = c(0,0,0.05,0.10,0.15),
  delta_H = c(0,0.15,0.15,0.15,0.15)
)

rows <- list()
k <- 1L

for (N in N_grid) {

  k_event <- ceiling(0.10 * N - 1e-12)
  attainable_threshold <- k_event / N

  probs <- list()

  for (i in seq_len(nrow(scenario_grid))) {
    sc <- scenario_grid[i, ]

    oc <- final_classification_prob_exact(
      N = N,
      pP_true = pP_true,
      pL_true = pP_true - sc$delta_L,
      pH_true = pP_true - sc$delta_H,
      weak_effect_boundary = 0.05,
      promising_threshold = 0.10
    )

    probs[[sc$scenario]] <- oc$P_Go_leaning
  }

  se_target <- sqrt(
    (
      0.45 * 0.55 +
      0.30 * 0.70
    ) / N
  )

  rows[[k]] <- data.frame(
    N_per_arm = N,
    N_total = 3 * N,
    min_event_diff_for_final_promising = k_event,
    attainable_final_promising_threshold = attainable_threshold,
    P_Go_0_0 = probs[["0_0"]],
    P_Go_0_15 = probs[["0_15"]],
    P_Go_5_15 = probs[["5_15"]],
    P_Go_10_15 = probs[["10_15"]],
    P_Go_15_15 = probs[["15_15"]],
    SE_RD_target = se_target,
    CI95_halfwidth_target = 1.96 * se_target
  )

  k <- k + 1L
}

out <- do.call(rbind, rows)

dir.create("simulation/results", recursive = TRUE, showWarnings = FALSE)

write.csv(
  out,
  "simulation/results/final_N_scan_40_60_v1_1.csv",
  row.names = FALSE
)

print(out)
