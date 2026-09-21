# CRC N x Stage 1 information fraction x CP boundary table v0.8
# Date: 2026-09-21
#
# Purpose:
#   Present the design grid in the way the study will actually be discussed:
#
#       maximum N per arm
#       x nominal Stage 1 information fraction (40%, 50%, 60%)
#       x CP futility cutoff
#
# CRC efficacy assumptions remain frozen:
#   placebo event rate = 0.45
#   target active event rate = 0.30
#   target ARR = 0.15
#
# The Stage 1 sample size shown here is a NOMINAL design-calibration value:
#
#   n1_nominal = round(N * f1)
#
# The eventual interim implementation must use the actual mature/evaluable
# sample size in each arm and does not require nP = nL = nH.

source("simulation/cp_sample_size_calibration_crc.R")

# ------------------------------------------------------------
# Helper: actual Stage 1 event-count boundary implied by CP cutoff
# ------------------------------------------------------------

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

# ------------------------------------------------------------
# Pull key scenarios
# ------------------------------------------------------------

null_dat <- subset(
  results,
  scenario == "Null_0_0"
)

one15_dat <- subset(
  results,
  scenario == "OneTarget15_OtherNull"
)

both15_dat <- subset(
  results,
  scenario == "BothTarget15"
)

weak_dat <- subset(
  results,
  scenario == "WeakBoth_5_5"
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
  null_dat[
    ,
    c(
      key,
      "P_NoGo_S1",
      "EN_A_no_overrun",
      "EN_B_no_overrun",
      "ARR_half_width_95_target"
    )
  ],
  one15_dat[
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
  both15_dat[
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

tab <- merge(
  tab,
  weak_dat[
    ,
    c(
      key,
      "P_NoGo_S1"
    )
  ],
  by = key
)

names(tab)[names(tab) == "P_NoGo_S1"] <-
  "P_NoGo_weak_both5"

names(tab)[names(tab) == "P_Futility_L"] <-
  "P_Futility_target15"

names(tab)[names(tab) == "P_NoGo_S1_null"] <-
  "P_NoGo_null"

names(tab)[names(tab) == "P_NoGo_S1_one15"] <-
  "P_NoGo_one_target15"

# Actual integer event-count boundary corresponding to the nominal CP cutoff.
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

# Presentation labels.
tab$Stage1_target_pct <- 100 * tab$f1_target
tab$Stage1_actual_pct <- 100 * tab$information_fraction_actual
tab$CP_cutoff_pct <- 100 * tab$cF

tab <- tab[
  order(
    tab$N_per_arm,
    tab$f1_target,
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
  "simulation/results/cp_crc_N_f1_cF_tradeoff_v0_8.csv",
  row.names = FALSE
)

# Separate views for easier review.
for (f in c(0.40, 0.50, 0.60)) {

  tmp <- subset(
    tab,
    abs(f1_target - f) < 1e-12
  )

  outfile <- sprintf(
    "simulation/results/cp_crc_f1_%02d_tradeoff_v0_8.csv",
    round(100 * f)
  )

  write.csv(
    tmp,
    outfile,
    row.names = FALSE
  )
}

print(
  tab[
    ,
    c(
      "N_per_arm",
      "n1_per_arm",
      "Stage1_target_pct",
      "Stage1_actual_pct",
      "CP_cutoff_pct",
      "actual_d_boundary",
      "P_NoGo_null",
      "P_NoGo_weak_both5",
      "P_Futility_target15",
      "P_NoGo_one_target15",
      "P_NoGo_both15",
      "EN_A_no_overrun",
      "EN_B_no_overrun",
      "N_saved_A_vs_B_one15",
      "ARR_half_width_95_target"
    )
  ]
)
