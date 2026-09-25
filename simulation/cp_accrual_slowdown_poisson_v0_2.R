# CP accrual slowdown Poisson screen v0.2
# Date: 2026-09-25
#
# Exact stochastic screen under a homogeneous Poisson accrual model.
# The Stage 1 decision cohort is fixed. Slowdown starts immediately after
# Stage 1 accrual is complete and lasts until the delayed endpoint matures.

N_total <- 132L

stage1_grid <- data.frame(
  info_fraction = c(0.35, 0.40),
  N1 = c(45L, 54L)
)

r0_grid <- c(6, 9, 12)
L_grid  <- c(4, 5, 6)
s_grid  <- c(1.00, 0.75, 0.50, 0.25)

expected_min_pois <- function(lambda, cap) {
  k <- 0:(cap - 1L)
  sum(k * dpois(k, lambda)) + cap * ppois(cap - 1L, lambda, lower.tail = FALSE)
}

prob_nfrac_ge <- function(N1, lambda, frac, N_total = 132L) {
  needed <- ceiling(frac * N_total - N1)
  if (needed <= 0) return(1)
  if (needed > N_total - N1) return(0)
  ppois(needed - 1L, lambda, lower.tail = FALSE)
}

rows <- list()
ii <- 1L

for (i in seq_len(nrow(stage1_grid))) {
  N1 <- stage1_grid$N1[i]
  f1 <- stage1_grid$info_fraction[i]
  cap <- N_total - N1

  for (r0 in r0_grid) {
    for (L in L_grid) {
      for (s in s_grid) {
        lambda <- s * r0 * L

        e_pipeline <- expected_min_pois(lambda, cap)
        e_n_IA <- N1 + e_pipeline
        p_full <- ppois(cap - 1L, lambda, lower.tail = FALSE)

        rows[[ii]] <- data.frame(
          info_fraction = f1,
          N1 = N1,
          r0 = r0,
          L = L,
          slowdown = s,
          lambda_pipeline = lambda,
          E_pipeline = e_pipeline,
          E_n_at_IA = e_n_IA,
          E_fraction_at_IA = e_n_IA / N_total,
          E_avoidable_if_NoGo = N_total - e_n_IA,
          P_full_accrual_before_IA = p_full,
          P_at_least_70pct_randomized_at_IA = prob_nfrac_ge(N1, lambda, 0.70, N_total),
          P_at_least_80pct_randomized_at_IA = prob_nfrac_ge(N1, lambda, 0.80, N_total),
          P_at_least_90pct_randomized_at_IA = prob_nfrac_ge(N1, lambda, 0.90, N_total)
        )
        ii <- ii + 1L
      }
    }
  }
}

out <- do.call(rbind, rows)

# Existing exact Stage 1 global-null stopping probabilities from
# stage1_information_cp_cutoff_grid_v0_1.md.
# These are appended only to show expected sample size under the global null.
stop_lookup <- data.frame(
  info_fraction = c(0.35, 0.35, 0.40, 0.40),
  cp_cutoff = c(0.30, 0.35, 0.30, 0.35),
  Stop0 = c(0.1499, 0.1499, 0.1626, 0.2700)
)

out2 <- merge(out, stop_lookup, by = "info_fraction", all.x = TRUE)
out2$E_N_global_null <- N_total - out2$Stop0 * (N_total - out2$E_n_at_IA)

out2 <- out2[
  order(out2$info_fraction, out2$L, out2$r0, -out2$slowdown, out2$cp_cutoff),
]

dir.create("simulation/results", recursive = TRUE, showWarnings = FALSE)
write.csv(
  out2,
  "simulation/results/cp_accrual_slowdown_poisson_v0_2.csv",
  row.names = FALSE
)

focus <- subset(
  out2,
  info_fraction == 0.40 & L == 6 & cp_cutoff == 0.30
)

print(
  focus[, c(
    "r0", "slowdown", "E_n_at_IA",
    "P_at_least_80pct_randomized_at_IA",
    "P_full_accrual_before_IA",
    "E_avoidable_if_NoGo", "E_N_global_null"
  )],
  row.names = FALSE
)
