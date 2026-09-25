# CP accrual slowdown screen v0.1
# Date: 2026-09-25
#
# Purpose:
#   Quantify the operational trade-off created by slowing recruitment
#   after the prespecified Stage 1 cohort is fully randomized but before
#   its delayed primary endpoint has matured.
#
# This script does NOT change the Stage 1 CP decision rule.
# It treats the Stage 1 decision cohort as fixed and evaluates only the
# calendar-time / pre-decision accrual consequences of slowdown.

N_total <- 132L

stage1_grid <- data.frame(
  info_fraction = c(0.35, 0.40, 0.45, 0.50),
  N1 = c(45L, 54L, 60L, 66L)
)

r0_grid <- c(3, 6, 9, 12)          # total participants/month
L_grid  <- c(4, 5, 6)              # months to primary-endpoint maturity
s_grid  <- c(1.00, 0.75, 0.50, 0.25)

grid <- merge(
  stage1_grid,
  expand.grid(
    r0 = r0_grid,
    L = L_grid,
    slowdown = s_grid,
    KEEP.OUT.ATTRS = FALSE,
    stringsAsFactors = FALSE
  )
)

calc_row <- function(info_fraction, N1, r0, L, slowdown) {
  t_stage1_accrual <- N1 / r0
  t_IA <- t_stage1_accrual + L

  # Continuous expected-count approximation.
  n_IA_unrestricted <- min(N_total, N1 + r0 * L)
  n_IA_slow <- min(N_total, N1 + slowdown * r0 * L)

  # Full-accrual time if Stage 1 continues and ordinary recruitment rate
  # is restored immediately after the interim decision.
  if (N1 + slowdown * r0 * L >= N_total) {
    t_full_if_go <- t_stage1_accrual + (N_total - N1) / (slowdown * r0)
  } else {
    t_full_if_go <- t_IA + (N_total - n_IA_slow) / r0
  }

  t_full_no_slow <- N_total / r0

  data.frame(
    info_fraction = info_fraction,
    N1 = N1,
    r0 = r0,
    L = L,
    slowdown = slowdown,
    t_stage1_accrual = t_stage1_accrual,
    t_IA = t_IA,
    n_IA_unrestricted = n_IA_unrestricted,
    n_IA_slow = n_IA_slow,
    frac_randomized_at_IA = n_IA_slow / N_total,
    avoidable_if_NoGo = N_total - n_IA_slow,
    protected_vs_no_slow = n_IA_unrestricted - n_IA_slow,
    t_full_no_slow = t_full_no_slow,
    t_full_if_Go = t_full_if_go,
    Go_calendar_penalty = t_full_if_go - t_full_no_slow,
    full_accrual_before_IA = as.integer(n_IA_slow >= N_total)
  )
}

out <- do.call(
  rbind,
  Map(
    calc_row,
    grid$info_fraction,
    grid$N1,
    grid$r0,
    grid$L,
    grid$slowdown
  )
)

out <- out[
  order(out$info_fraction, out$L, out$r0, -out$slowdown),
]

dir.create("simulation/results", recursive = TRUE, showWarnings = FALSE)
write.csv(
  out,
  "simulation/results/cp_accrual_slowdown_screen_v0_1.csv",
  row.names = FALSE
)

# Focused display: current 40% Stage 1 anchor, 6-month endpoint.
focus <- subset(out, info_fraction == 0.40 & L == 6)
print(
  focus[, c(
    "r0", "slowdown", "n_IA_slow", "frac_randomized_at_IA",
    "avoidable_if_NoGo", "protected_vs_no_slow", "Go_calendar_penalty"
  )],
  row.names = FALSE
)

# Algebraic check in the unsaturated region:
# protected_vs_no_slow = (1 - slowdown) * r0 * L
# Go_calendar_penalty  = (1 - slowdown) * L
# Therefore protected patients per added month under Go = r0.
