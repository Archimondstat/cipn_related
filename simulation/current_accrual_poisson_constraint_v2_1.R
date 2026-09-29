# ================================================================
# AK135 CIPN Cohort 1
# Current Poisson accrual constraint after Stage 1 cohort enrollment
# Version 2.1
# Date: 2026-09-29
#
# Operational target:
#   P(N_IA >= ceiling(0.70 * N_total)) <= 0.05
#
# Current design:
#   N_total = 150
#   Stage 1 cohort N1 = 54
#
# Model:
#   X ~ Poisson(r_slow * L)
#   N_IA = N1 + min(X, N_total - N1)
#
# This is an operational budget/commitment constraint, not an
# inferential error-rate constraint.
# ================================================================

N_total <- 150L
N1 <- 54L
budget_fraction <- 0.70
tail_target <- 0.05

B <- ceiling(budget_fraction * N_total)
k <- B - N1

poisson_tail <- function(lambda) {
  ppois(
    q = k - 1L,
    lambda = lambda,
    lower.tail = FALSE
  )
}

lambda_max <- uniroot(
  function(lambda) poisson_tail(lambda) - tail_target,
  interval = c(0, 200)
)$root

max_post_stage1_rate <- function(L) {
  lambda_max / L
}

make_operational_grid <- function(
  L_values = c(4, 5, 6),
  ordinary_rates = c(6, 9, 12)
) {
  out <- expand.grid(
    endpoint_maturation_months = L_values,
    ordinary_rate_per_month = ordinary_rates,
    KEEP.OUT.ATTRS = FALSE
  )

  out$boundary_total_randomized <- B
  out$additional_randomized_to_boundary <- k
  out$lambda_max <- lambda_max

  out$max_post_stage1_rate_per_month <-
    lambda_max / out$endpoint_maturation_months

  out$retained_fraction <-
    pmin(
      1,
      out$max_post_stage1_rate_per_month /
        out$ordinary_rate_per_month
    )

  out$operational_rate_per_month <-
    out$ordinary_rate_per_month *
    out$retained_fraction

  out$tail_probability <-
    mapply(
      function(rate, L) {
        ppois(
          q = k - 1L,
          lambda = rate * L,
          lower.tail = FALSE
        )
      },
      out$operational_rate_per_month,
      out$endpoint_maturation_months
    )

  out$approx_go_calendar_penalty_months <-
    out$endpoint_maturation_months *
    pmax(0, 1 - out$retained_fraction)

  out$approx_IA_decision_month <-
    N1 / out$ordinary_rate_per_month +
    out$endpoint_maturation_months

  out
}

grid <- make_operational_grid()

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  grid,
  "simulation/results/current_accrual_poisson_constraint_v2_1.csv",
  row.names = FALSE
)

cat("Current design operational constraint\n")
cat("N_total =", N_total, "\n")
cat("Stage 1 N1 =", N1, "\n")
cat("70% boundary =", B, "\n")
cat("Pipeline crossing threshold X >=", k, "\n")
cat("lambda_max =", sprintf("%.6f", lambda_max), "\n")
cat("For L=6 months, max rate =",
    sprintf("%.4f", max_post_stage1_rate(6)),
    "participants/month\n\n")

print(grid)
