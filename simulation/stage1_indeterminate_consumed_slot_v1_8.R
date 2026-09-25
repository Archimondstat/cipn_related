# ================================================================
# CIPN randomized Phase II - Cohort 1
# Stage 1 CP with permanent indeterminate endpoints
# Current method: available-case + consumed-slot
# Version 1.8
# Date: 2026-09-25
#
# Working design:
#   Final N = 50 per arm
#   Stage 1 cohort = first 54 randomized participants overall
#   Nominal equal allocation = 18/18/18
#   Project Go if max(CP_L, CP_H) >= 70%
#   No dose dropping
#
# Key distinction:
#   R_j = randomized/consumed slots by IA
#   E_j = endpoint-evaluable participants by IA
#   U_j = R_j - E_j = permanently indeterminate endpoints
#   F_j = N_j - R_j = future recruitment capacity
#
# Under available-case + consumed-slot:
#   future outcomes are generated ONLY for F_j.
#   Permanent indeterminate participants do not re-enter as future subjects.
#   Final available-case denominator is E_j + F_j = N_j - U_j.
#
# This is the confirmed Stage 1 method for permanently indeterminate endpoints.
# ================================================================

source("simulation/cp_futility_engine.R")

cp_available_case_consumed_slot <- function(
  xp, EP, RP,
  xt, ET, RT,
  NP = 50,
  NT = 50,
  delta_go = 0.10,
  qP = 0.45,
  qT = 0.30
) {
  cp <- cp_individual_consumed_slot_exact(
    xp = xp, EP = EP, RP = RP,
    xt = xt, ET = ET, RT = RT,
    NP = NP, NT = NT,
    delta_go = delta_go,
    qP = qP, qT = qT
  )

  data.frame(
    xp = xp,
    EP = EP,
    RP = RP,
    UP = RP - EP,
    FP = NP - RP,
    xt = xt,
    ET = ET,
    RT = RT,
    UT = RT - ET,
    FT = NT - RT,
    final_available_case_denominator_P =
      EP + (NP - RP),
    final_available_case_denominator_T =
      ET + (NT - RT),
    CP = cp
  )
}

cp_naive_replacement <- function(
  xp, EP,
  xt, ET,
  NP = 50,
  NT = 50,
  delta_go = 0.10,
  qP = 0.45,
  qT = 0.30
) {
  cp_individual_exact(
    xp = xp,
    np = EP,
    xt = xt,
    nt = ET,
    NP = NP,
    NT = NT,
    delta_go = delta_go,
    qP = qP,
    qT = qT
  )
}

example_grid <- data.frame(
  example = c(
    "No indeterminate: P 8/18 vs T 6/18",
    "1 P indeterminate: P 7/17 vs T 6/18",
    "1 P indeterminate: P 8/17 vs T 6/18",
    "1 T indeterminate: P 8/18 vs T 5/17",
    "1 T indeterminate: P 8/18 vs T 6/17",
    "1 each indeterminate: P 7/17 vs T 5/17",
    "2 P indeterminate: P 6/16 vs T 6/18",
    "2 P indeterminate: P 7/16 vs T 6/18",
    "2 P indeterminate: P 8/16 vs T 6/18",
    "2 T indeterminate: P 8/18 vs T 4/16",
    "2 T indeterminate: P 8/18 vs T 5/16",
    "2 T indeterminate: P 8/18 vs T 6/16",
    "2 each indeterminate: P 6/16 vs T 4/16",
    "2 each indeterminate: P 7/16 vs T 5/16",
    "2 each indeterminate: P 8/16 vs T 6/16"
  ),
  xp = c(8,7,8,8,8,7,6,7,8,8,8,8,6,7,8),
  EP = c(18,17,17,18,18,17,16,16,16,18,18,18,16,16,16),
  RP = rep(18,15),
  xt = c(6,6,6,5,6,5,6,6,6,4,5,6,4,5,6),
  ET = c(18,18,18,17,17,17,18,18,18,16,16,16,16,16,16),
  RT = rep(18,15)
)

rows <- vector("list", nrow(example_grid))

for (i in seq_len(nrow(example_grid))) {
  z <- example_grid[i, ]

  ac <- cp_available_case_consumed_slot(
    xp = z$xp,
    EP = z$EP,
    RP = z$RP,
    xt = z$xt,
    ET = z$ET,
    RT = z$RT
  )

  naive <- cp_naive_replacement(
    xp = z$xp,
    EP = z$EP,
    xt = z$xt,
    ET = z$ET
  )

  rows[[i]] <- data.frame(
    example = z$example,
    xp = z$xp,
    EP = z$EP,
    RP = z$RP,
    xt = z$xt,
    ET = z$ET,
    RT = z$RT,
    UP = z$RP - z$EP,
    UT = z$RT - z$ET,
    future_slots_P = 50 - z$RP,
    future_slots_T = 50 - z$RT,
    final_available_case_denominator_P =
      z$EP + (50 - z$RP),
    final_available_case_denominator_T =
      z$ET + (50 - z$RT),
    CP_available_case_consumed_slot = ac$CP,
    CP_naive_treat_missing_as_future = naive,
    naive_minus_slot_adjusted =
      naive - ac$CP,
    Go_CP70 =
      ac$CP >= 0.70
  )
}

out <- do.call(rbind, rows)

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  out,
  "simulation/results/stage1_indeterminate_consumed_slot_examples_v1_8.csv",
  row.names = FALSE
)

print(out)
