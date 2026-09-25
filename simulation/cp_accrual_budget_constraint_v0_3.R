# CP accrual slowdown budget constraint v0.3
# Date: 2026-09-25
#
# Budget-oriented operational target:
#   P(N randomized at IA >= 70% of Nmax) <= 5%
#
# Stage 1 cohort is fixed. After Stage 1 accrual completes, pipeline accrual
# over the endpoint-maturation period is Poisson(s * r0 * L).

N_total <- 132L
risk_target <- 0.05
budget_fraction <- 0.70
N_budget <- ceiling(budget_fraction * N_total)  # 93

stage1_grid <- data.frame(
  info_fraction = c(0.35, 0.40),
  N1 = c(45L, 54L)
)

r0_grid <- c(6, 9, 12)
L_grid <- c(4, 5, 6)
candidate_s <- c(1.00, 0.75, 0.50, 0.25)

tail_prob <- function(lambda, need_pipeline) {
  if (need_pipeline <= 0) return(1)
  ppois(need_pipeline - 1L, lambda, lower.tail = FALSE)
}

lambda_limit <- function(need_pipeline, alpha = 0.05) {
  f <- function(lambda) tail_prob(lambda, need_pipeline) - alpha
  uniroot(f, interval = c(0, max(100, 4 * need_pipeline)))$root
}

rows <- list()
ii <- 1L

for (i in seq_len(nrow(stage1_grid))) {
  f1 <- stage1_grid$info_fraction[i]
  N1 <- stage1_grid$N1[i]
  need <- N_budget - N1
  lam_max <- lambda_limit(need, risk_target)

  for (L in L_grid) {
    for (r0 in r0_grid) {
      s_max <- min(1, lam_max / (r0 * L))

      probs <- sapply(candidate_s, function(s) {
        tail_prob(s * r0 * L, need)
      })

      feasible <- candidate_s[probs <= risk_target]
      # least restrictive candidate = largest slowdown multiplier satisfying target
      chosen <- if (length(feasible)) max(feasible) else NA_real_
      chosen_prob <- if (is.na(chosen)) NA_real_ else
        tail_prob(chosen * r0 * L, need)

      rows[[ii]] <- data.frame(
        info_fraction = f1,
        N1 = N1,
        r0 = r0,
        L = L,
        N_budget = N_budget,
        need_pipeline_for_70pct = need,
        lambda_max_for_5pct = lam_max,
        max_slowdown_multiplier = s_max,
        candidate_selected = chosen,
        selected_tail_probability = chosen_prob,
        P70_no_slow = probs[candidate_s == 1.00],
        P70_s075 = probs[candidate_s == 0.75],
        P70_s050 = probs[candidate_s == 0.50],
        P70_s025 = probs[candidate_s == 0.25]
      )
      ii <- ii + 1L
    }
  }
}

out <- do.call(rbind, rows)
out <- out[order(out$info_fraction, out$L, out$r0), ]

dir.create("simulation/results", recursive = TRUE, showWarnings = FALSE)
write.csv(
  out,
  "simulation/results/cp_accrual_budget_constraint_v0_3.csv",
  row.names = FALSE
)

print(out, row.names = FALSE)
