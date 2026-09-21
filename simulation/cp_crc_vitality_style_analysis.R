# VITALITY-style CRC reference-effect analysis v1.2
# Date: 2026-09-22
#
# Purpose:
#   Recast the CRC Stage 1 calibration in the same structure used in
#   VITALITY-HFpEF Table 4-2:
#
#     1) equivalent interim treatment-effect boundary;
#     2) individual conditional power at that boundary;
#     3) joint conditional power for the two active doses;
#     4) probability of meeting the futility criterion under selected
#        true-effect scenarios;
#     5) joint probability of observing selected final treatment effects
#        on at least one dose.
#
# Frozen CRC efficacy assumptions:
#   placebo event rate = 0.45
#   target active event rate = 0.30
#   target ARR = 0.15
#
# Prespecified Phase II promising criterion used to define CP:
#   observed final treatment effect >= 0.10
#
# 0.05 = weak-effect boundary; 0.10 = promising threshold;
# 0.15 = target treatment effect.
#
# Binary endpoint note:
#   Unlike VITALITY's continuous KCCQ endpoint, the interim effect is
#   discrete. Therefore the table is indexed by an integer event-count
#   boundary D:
#
#       d1 = xP1 - xT1
#
#   The displayed reference observed effect is D / n1.
#   d1 <= D defines a reference region for calibration only; it is not
#   an automatic stopping rule.
#
# The code supports all candidate N and Stage 1 timing choices.

binom_pmf <- function(n, p) {
  dbinom(0:n, size = n, prob = p)
}

final_diff_threshold <- function(N, arr) {
  ceiling(N * arr - 1e-12)
}

# ------------------------------------------------------------
# Individual CP at an exact Stage 1 event-count difference D
# ------------------------------------------------------------

individual_cp_at_D <- function(
  D,
  N,
  n1,
  delta_go = 0.10,
  p_future_p = 0.45,
  p_future_t = 0.30
) {
  m <- N - n1
  threshold <- final_diff_threshold(N, delta_go)

  pmf_p <- binom_pmf(m, p_future_p)

  ans <- 0

  for (yP in 0:m) {

    max_yT <- D + yP - threshold

    qT <- pbinom(
      q = max_yT,
      size = m,
      prob = p_future_t
    )

    ans <- ans + pmf_p[yP + 1] * qT
  }

  ans
}

# ------------------------------------------------------------
# Joint probability that at least one dose reaches a final ARR
# threshold, conditional on BOTH active doses being exactly at
# the same Stage 1 boundary D.
#
# Shared future placebo data are handled exactly.
# ------------------------------------------------------------

joint_final_effect_at_D <- function(
  D,
  N,
  n1,
  final_arr_threshold,
  p_future_p = 0.45,
  p_future_t = 0.30
) {
  m <- N - n1
  threshold <- final_diff_threshold(
    N,
    final_arr_threshold
  )

  pmf_p <- binom_pmf(m, p_future_p)

  ans <- 0

  for (yP in 0:m) {

    max_yT <- D + yP - threshold

    q_single <- pbinom(
      q = max_yT,
      size = m,
      prob = p_future_t
    )

    # Two active doses are conditionally independent given future yP,
    # but share the same placebo arm.
    q_any <-
      1 - (1 - q_single)^2

    ans <-
      ans +
      pmf_p[yP + 1] * q_any
  }

  ans
}

joint_cp_at_D <- function(
  D,
  N,
  n1,
  delta_go = 0.10,
  p_future_p = 0.45,
  p_future_t = 0.30
) {
  joint_final_effect_at_D(
    D = D,
    N = N,
    n1 = n1,
    final_arr_threshold = delta_go,
    p_future_p = p_future_p,
    p_future_t = p_future_t
  )
}

# ------------------------------------------------------------
# Probability that BOTH active doses are at or below the Stage 1
# reference region d1 <= D under a specified true effect.
# ------------------------------------------------------------

prob_both_at_or_below_reference <- function(
  D,
  n1,
  pP_true,
  pT_true
) {
  pmf_p <- binom_pmf(n1, pP_true)
  pmf_t <- binom_pmf(n1, pT_true)

  ans <- 0

  for (xP in 0:n1) {

    # d1 = xP - xT <= D
    # => xT >= xP - D
    min_xT <- xP - D

    q_single <- 1 - pbinom(
      q = min_xT - 1,
      size = n1,
      prob = pT_true
    )

    ans <-
      ans +
      pmf_p[xP + 1] *
      q_single^2
  }

  ans
}

# Backward-compatible alias for historical scripts. Do not use this
# name in new reporting.
prob_meet_futility_both <- prob_both_at_or_below_reference

# ------------------------------------------------------------
# Build one VITALITY-style table
# ------------------------------------------------------------

make_vitality_style_table <- function(
  N,
  f1,
  D_grid = -4:2,
  pP_design = 0.45,
  pT_design = 0.30,
  delta_go = 0.10
) {
  n1 <- floor(N * f1 + 0.5)

  out <- vector(
    "list",
    length(D_grid)
  )

  for (i in seq_along(D_grid)) {

    D <- D_grid[i]

    out[[i]] <- data.frame(
      N_per_arm = N,
      Stage1_target_fraction = f1,
      n1_nominal = n1,

      # VITALITY column 1 analogue: reference/calibration value
      Event_difference_reference_D = D,
      Reference_interim_observed_effect =
        D / n1,

      # VITALITY columns 2-3 analogues
      Conditional_power_individual =
        individual_cp_at_D(
          D = D,
          N = N,
          n1 = n1,
          delta_go = delta_go,
          p_future_p = pP_design,
          p_future_t = pT_design
        ),

      Joint_conditional_power =
        joint_cp_at_D(
          D = D,
          N = N,
          n1 = n1,
          delta_go = delta_go,
          p_future_p = pP_design,
          p_future_t = pT_design
        ),

      # Probability both doses are at/below the displayed reference region
      P_both_at_or_below_reference_true_effect_0 =
        prob_both_at_or_below_reference(
          D = D,
          n1 = n1,
          pP_true = 0.45,
          pT_true = 0.45
        ),

      P_both_at_or_below_reference_true_effect_15 =
        prob_both_at_or_below_reference(
          D = D,
          n1 = n1,
          pP_true = 0.45,
          pT_true = 0.30
        ),

      # VITALITY final-effect-probability analogue.
      # Ordered from larger to smaller effect, analogous to >7/5/3 points.
      P_any_final_ARR_ge_15 =
        joint_final_effect_at_D(
          D = D,
          N = N,
          n1 = n1,
          final_arr_threshold = 0.15,
          p_future_p = pP_design,
          p_future_t = pT_design
        ),

      P_any_final_ARR_ge_10 =
        joint_final_effect_at_D(
          D = D,
          N = N,
          n1 = n1,
          final_arr_threshold = 0.10,
          p_future_p = pP_design,
          p_future_t = pT_design
        ),

      P_any_final_ARR_ge_05 =
        joint_final_effect_at_D(
          D = D,
          N = N,
          n1 = n1,
          final_arr_threshold = 0.05,
          p_future_p = pP_design,
          p_future_t = pT_design
        )
    )
  }

  do.call(rbind, out)
}

# ------------------------------------------------------------
# Generate all candidate N x Stage 1 timing tables
# ------------------------------------------------------------

N_grid <- c(36, 40, 44, 48, 52)
f1_grid <- c(0.40, 0.50, 0.60)

all_tables <- list()
idx <- 1L

for (N in N_grid) {
  for (f1 in f1_grid) {

    all_tables[[idx]] <-
      make_vitality_style_table(
        N = N,
        f1 = f1,
        D_grid = -4:2
      )

    idx <- idx + 1L
  }
}

results <- do.call(
  rbind,
  all_tables
)

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  results,
  "simulation/results/cp_crc_vitality_style_allN_allTiming_v1_2.csv",
  row.names = FALSE
)

# N=44 anchor tables for direct review.
for (f1 in f1_grid) {

  tmp <- subset(
    results,
    N_per_arm == 44 &
      abs(Stage1_target_fraction - f1) < 1e-12
  )

  outfile <- sprintf(
    "simulation/results/cp_crc_vitality_style_N44_f1_%02d_v1_2.csv",
    round(100 * f1)
  )

  write.csv(
    tmp,
    outfile,
    row.names = FALSE
  )
}

print(
  subset(
    results,
    N_per_arm == 44 &
      abs(Stage1_target_fraction - 0.50) < 1e-12
  )
)
