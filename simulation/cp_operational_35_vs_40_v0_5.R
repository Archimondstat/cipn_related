# Operational comparison of 35% vs 40% Stage 1, v0.5
# Date: 2026-09-25
#
# Reads the exact analytic budget grid from v0.4 and derives:
# - maximum allowed post-Stage-1 absolute accrual rate;
# - retained fraction of ordinary accrual;
# - deterministic Go-case calendar penalty;
# - approximate calendar time of the interim decision.

x <- read.csv("simulation/results/cp_accrual_budget_multiN_v0_4.csv")

x <- subset(
  x,
  f1_target %in% c(0.35, 0.40)
)

x$Go_calendar_penalty_months <- with(
  x,
  pmax(
    0,
    endpoint_delay_months *
      (1 - max_post_stage1_rate_per_month / ordinary_rate_per_month)
  )
)

x$t_IA_months <- with(
  x,
  N1_total / ordinary_rate_per_month + endpoint_delay_months
)

x <- x[
  order(
    x$N_per_arm,
    x$f1_target,
    x$endpoint_delay_months,
    x$ordinary_rate_per_month
  ),
]

write.csv(
  x,
  "simulation/results/cp_operational_35_vs_40_v0_5.csv",
  row.names = FALSE
)

print(
  subset(
    x,
    endpoint_delay_months == 6
  )[
    ,
    c(
      "N_per_arm",
      "f1_target",
      "N1_total",
      "ordinary_rate_per_month",
      "max_post_stage1_rate_per_month",
      "max_slowdown_multiplier",
      "Go_calendar_penalty_months",
      "t_IA_months"
    )
  ],
  row.names = FALSE
)
