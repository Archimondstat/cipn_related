# ================================================================
# CIPN randomized Phase II - Cohort 1
# Planning anchor: ~75% at N=50 and sample size required for 80%
# Version 1.2
# Date: 2026-09-25
#
# Key scenario for final-N planning:
#   Low true effect = 0%
#   High true effect = 15%
#   Placebo event rate = 45%
#
# Final promising rule:
#   max(observed RD Low, observed RD High) >= 10%
#
# Exact binomial probabilities with shared placebo.
# ================================================================

source("simulation/cp_futility_engine.R")

pP_true <- 0.45
delta_L <- 0
delta_H <- 0.15
target_prob <- 0.80

calc_row <- function(N) {
  oc <- final_classification_prob_exact(
    N = N,
    pP_true = pP_true,
    pL_true = pP_true - delta_L,
    pH_true = pP_true - delta_H,
    weak_effect_boundary = 0.05,
    promising_threshold = 0.10
  )

  k_event <- ceiling(0.10 * N - 1e-12)

  se_target <- sqrt(
    (0.45 * 0.55 + 0.30 * 0.70) / N
  )

  data.frame(
    N_per_arm = N,
    N_total = 3 * N,
    min_event_diff_for_final_promising = k_event,
    attainable_threshold = k_event / N,
    P_Go_0_15 = oc$P_Go_leaning,
    CI95_halfwidth_target = 1.96 * se_target
  )
}

scan <- do.call(
  rbind,
  lapply(40:150, calc_row)
)

first_80 <- scan[
  which(scan$P_Go_0_15 >= target_prob)[1],
  ,
  drop = FALSE
]

selected <- scan[
  scan$N_per_arm %in% c(50, 60, 70, 80, 90, 100, 101, 109, 110),
  ,
  drop = FALSE
]

dir.create("simulation/results", recursive = TRUE, showWarnings = FALSE)

write.csv(
  scan,
  "simulation/results/final_N_80pct_scan_v1_2.csv",
  row.names = FALSE
)

write.csv(
  selected,
  "simulation/results/final_N_80pct_selected_v1_2.csv",
  row.names = FALSE
)

print(first_80)
print(selected)
