# CRC Stage 1 risk-efficiency / precision table v0.7
# Date: 2026-09-21
#
# This is a presentation-layer script built on v0.5.
# It does NOT change the frozen CRC efficacy assumptions:
#
#   pP = 0.45
#   pT = 0.30
#   target ARR = 0.15
#
# Goal:
#   Compare candidate maximum N values at the SAME nominal Stage 1
#   information fraction (50%), while showing the actual discrete
#   event-count futility boundary implied by each nominal CP cutoff.
#
# Run from the repository root.

source("simulation/cp_sample_size_calibration_crc.R")

# ------------------------------------------------------------------
# Helper: actual Stage 1 event-count boundary implied by CP cutoff
# ------------------------------------------------------------------
#
# d1 = xP1 - xT1
#
# For this unfavorable endpoint, a negative d1 means MORE events in
# the active arm than placebo.
#
# The function returns the largest integer d1 for which CP < cF.
# Thus, for example, -3 means:
#
#   xP1 - xT1 <= -3  => futility
#
# i.e. the active arm has at least 3 more events than placebo.

actual_d_boundary <- function(
  n1,
  N,
  cF,
  delta_go = 0.10,
  p_future_p = 0.45,
  p_future_t = 0.30
) {
  cp_tab <- cp_lookup_design(
    n1 = n1,
    N = N,
    delta_go = delta_go,
    p_future_p = p_future_p,
    p_future_t = p_future_t
  )

  ind <- which(
    cp_tab < cF,
    arr.ind = TRUE
  )

  if (nrow(ind) == 0L) {
    return(NA_integer_)
  }

  d <- (ind[, "row"] - 1L) -
    (ind[, "col"] - 1L)

  max(d)
}

# ------------------------------------------------------------------
# Build the 50% information slice
# ------------------------------------------------------------------

null50 <- subset(
  results,
  scenario == "Null_0_0" &
    abs(f1_target - 0.50) < 1e-12
)

one15_50 <- subset(
  results,
  scenario == "OneTarget15_OtherNull" &
    abs(f1_target - 0.50) < 1e-12
)

both15_50 <- subset(
  results,
  scenario == "BothTarget15" &
    abs(f1_target - 0.50) < 1e-12
)

key <- c(
  "N_per_arm",
  "n1_per_arm",
  "f1_target",
  "information_fraction_actual",
  "delta_go",
  "cF"
)

tab <- merge(
  null50[
    ,
    c(
      key,
      "P_NoGo_S1",
      "EN_A_no_overrun",
      "EN_B_no_overrun",
      "ARR_half_width_95_target"
    )
  ],
  one15_50[
    ,
    c(
      key,
      "P_Futility_L",
      "P_NoGo_S1",
      "N_saved_A_vs_B"
    )
  ],
  by = key,
  suffixes = c("_null", "_one15")
)

tab <- merge(
  tab,
  both15_50[
    ,
    c(
      key,
      "P_NoGo_S1"
    )
  ],
  by = key
)

names(tab)[names(tab) == "P_NoGo_S1"] <-
  "P_NoGo_both15"

names(tab)[names(tab) == "P_Futility_L"] <-
  "P_Futility_target15"

names(tab)[names(tab) == "P_NoGo_S1_null"] <-
  "P_NoGo_null"

names(tab)[names(tab) == "P_NoGo_S1_one15"] <-
  "P_NoGo_one_target15"

tab$actual_d_boundary <- mapply(
  FUN = actual_d_boundary,
  n1 = tab$n1_per_arm,
  N = tab$N_per_arm,
  cF = tab$cF,
  MoreArgs = list(
    delta_go = 0.10,
    p_future_p = 0.45,
    p_future_t = 0.30
  )
)

tab <- tab[
  order(
    tab$N_per_arm,
    tab$cF
  ),
]

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  tab,
  "simulation/results/cp_crc_50pct_info_tradeoff_v0_7.csv",
  row.names = FALSE
)

# ------------------------------------------------------------------
# Matched-boundary comparison across N
# ------------------------------------------------------------------
#
# d1 <= -3 is used ONLY as a common reference boundary for comparing
# sample sizes at 50% information. It is not selected as the final rule.
#
# This removes much of the nominal-CP discreteness when comparing N.

matched <- subset(
  tab,
  actual_d_boundary == -3
)

matched <- matched[
  order(matched$N_per_arm),
]

write.csv(
  matched,
  "simulation/results/cp_crc_50pct_matched_dminus3_v0_7.csv",
  row.names = FALSE
)

print(tab)
print(matched)
