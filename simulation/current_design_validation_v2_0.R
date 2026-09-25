# ================================================================
# AK135 CIPN Cohort 1
# Current-design validation / regression checks
# Version 2.0
# Date: 2026-09-25
#
# Run from repository root:
#   Rscript simulation/current_design_validation_v2_0.R
# ================================================================

source("simulation/cp_futility_engine.R")

spec <- cipn_design_spec()

stopifnot(
  spec$N_per_arm == 50L,
  spec$N_total == 150L,
  spec$stage1_total == 54L,
  spec$stage1_nominal_per_arm == 18L,
  abs(spec$p_placebo_design - 0.45) < 1e-12,
  abs(spec$p_treatment_design - 0.30) < 1e-12,
  abs(spec$promising_threshold - 0.10) < 1e-12,
  abs(spec$stage1_cp_cutoff - 0.70) < 1e-12
)

# 1. No-indeterminate equivalence.
cp_plain <- cp_individual_exact(
  xp = 8,
  np = 18,
  xt = 6,
  nt = 18
)

cp_slot <- cp_individual_consumed_slot_exact(
  xp = 8,
  EP = 18,
  RP = 18,
  xt = 6,
  ET = 18,
  RT = 18
)

stopifnot(abs(cp_plain - cp_slot) < 1e-12)
stopifnot(abs(cp_plain - 0.7273) < 5e-4)


# 2. One permanent placebo indeterminate.
cp_one_missing <- cp_individual_consumed_slot_exact(
  xp = 7,
  EP = 17,
  RP = 18,
  xt = 6,
  ET = 18,
  RT = 18
)

stopifnot(abs(cp_one_missing - 0.6348) < 5e-4)


# 3. Project rule uses max(CP_L, CP_H), not joint CP.
decision <- stage1_project_decision(
  xp = 8,
  EP = 18,
  RP = 18,
  xL = 6,
  EL = 18,
  RL = 18,
  xH = 7,
  EH = 18,
  RH = 18
)

stopifnot(
  abs(decision$M - max(decision$CP_L, decision$CP_H)) < 1e-12,
  decision$Project_Decision == "Go"
)


# 4. Final analysis is descriptive and uses evaluable denominators.
final_example <- final_descriptive_summary(
  xP = 23, EP = 50,
  xL = 20, EL = 50,
  xH = 15, EH = 50
)

stopifnot(
  abs(final_example$delta_low - 0.06) < 1e-12,
  abs(final_example$delta_high - 0.16) < 1e-12,
  final_example$classification == "Go leaning"
)


# 5. Current nominal Stage 1 calibration:
# at n=18, a 2-event placebo-minus-treatment difference meets CP70.
ref <- make_current_stage1_reference_table(
  event_differences = 1:3
)

stopifnot(
  ref$Meets_CP70[1] == FALSE,
  ref$Meets_CP70[2] == TRUE,
  ref$Meets_CP70[3] == TRUE
)

cat("All current-design regression checks passed.\n")
print(spec)
print(ref)
print(decision)
print(final_example)
