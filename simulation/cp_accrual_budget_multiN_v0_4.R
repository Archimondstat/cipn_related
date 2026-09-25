# CP accrual budget constraint across total sample sizes v0.4
# Date: 2026-09-25
#
# Operational target:
#   P(N randomized at IA >= 70% of Nmax) <= 5%
#
# Sample-size assumptions:
#   N per arm = 44, 48, 52
# Three-arm total N = 132, 144, 156
#
# Stage 1 nominal information fractions:
#   35%, 40%, 45%, 50%
#
# Stage 1 per-arm count follows the repository convention:
#   floor(N_per_arm * f1 + 0.5)

alpha_budget <- 0.05
budget_fraction <- 0.70

N_arm_grid <- c(44L, 48L, 52L)
f1_grid <- c(0.35, 0.40, 0.45, 0.50)
L_grid <- c(4, 5, 6)
r0_grid <- c(6, 9, 12)

tail_prob <- function(lambda, k) {
  ppois(k - 1L, lambda, lower.tail = FALSE)
}

lambda_limit <- function(k, alpha = 0.05) {
  uniroot(
    function(lambda) tail_prob(lambda, k) - alpha,
    interval = c(0, max(100, 4 * k))
  )$root
}

rows <- list()
ii <- 1L

for (N_arm in N_arm_grid) {
  N_total <- 3L * N_arm
  N_budget <- ceiling(budget_fraction * N_total)

  for (f1 in f1_grid) {
    n1_arm <- floor(N_arm * f1 + 0.5)
    N1 <- 3L * n1_arm
    f1_actual <- n1_arm / N_arm

    k <- N_budget - N1
    lambda_max <- lambda_limit(k, alpha_budget)

    for (L in L_grid) {
      rslow_max <- lambda_max / L

      for (r0 in r0_grid) {
        smax <- min(1, rslow_max / r0)

        rows[[ii]] <- data.frame(
          N_per_arm = N_arm,
          N_total = N_total,
          N_budget_70pct = N_budget,
          f1_target = f1,
          n1_per_arm = n1_arm,
          N1_total = N1,
          f1_actual = f1_actual,
          pipeline_count_to_cross_70pct = k,
          lambda_max_for_5pct = lambda_max,
          endpoint_delay_months = L,
          max_post_stage1_rate_per_month = rslow_max,
          ordinary_rate_per_month = r0,
          max_slowdown_multiplier = smax
        )
        ii <- ii + 1L
      }
    }
  }
}

out <- do.call(rbind, rows)
out <- out[
  order(
    out$N_per_arm,
    out$f1_target,
    out$endpoint_delay_months,
    out$ordinary_rate_per_month
  ),
]

dir.create("simulation/results", recursive = TRUE, showWarnings = FALSE)

write.csv(
  out,
  "simulation/results/cp_accrual_budget_multiN_v0_4.csv",
  row.names = FALSE
)

# Compact six-month table for review.
focus <- subset(out, endpoint_delay_months == 6)

print(
  focus[, c(
    "N_per_arm", "N_total", "N_budget_70pct",
    "f1_target", "n1_per_arm", "N1_total",
    "lambda_max_for_5pct", "max_post_stage1_rate_per_month",
    "ordinary_rate_per_month", "max_slowdown_multiplier"
  )],
  row.names = FALSE
)
