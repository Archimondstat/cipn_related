# Focused VITALITY-style CRC reference table v1.5
# Date: 2026-09-22
#
# Purpose:
#   Present only the clinically relevant interim treatment-effect region
#   for internal discussion, instead of spending excessive space on
#   strongly negative boundaries.
#
# Unified treatment-effect definition:
#
#   Treatment effect = p_placebo - p_treatment
#
# Positive values favor treatment.
#
# Frozen CRC efficacy assumptions:
#   p_placebo = 0.45
#   p_treatment = 0.30
#   target treatment effect = 0.15
#
# Main interim REFERENCE observed effects shown:
#   approximately -5%, 0%, +5%, +10%
#
# These are calibration/reference values, not automatic futility boundaries.
# The single negative row is retained only as a conservative reference.

source("simulation/cp_crc_vitality_style_analysis.R")

make_focused_table <- function(
  N = 44,
  f1
) {
  n1 <- floor(N * f1 + 0.5)

  target_reference_effects <- c(
    -0.05,
    0.00,
    0.05,
    0.10
  )

  D_values <- unique(
    round(
      target_reference_effects * n1
    )
  )

  base <- make_vitality_style_table(
    N = N,
    f1 = f1,
    D_grid = D_values
  )

  # Event-count interpretation of the displayed reference treatment effect.
  #
  # D = x_placebo - x_treatment
  #
  # Positive D means placebo has more CTCAE >=2 CIPN events than treatment,
  # which favors treatment.  D is used for interpretation/calibration only;
  # it is not an automatic stopping boundary.
  base$Event_count_difference_reference <-
    base$Event_difference_boundary_D

  base$Event_count_reference_meaning <-
    vapply(
      base$Event_count_difference_reference,
      function(D) {
        if (D < 0) {
          sprintf(
            "Treatment has %d more event(s) than placebo",
            abs(D)
          )
        } else if (D == 0) {
          "Same number of events"
        } else {
          sprintf(
            "Placebo has %d more event(s) than treatment",
            D
          )
        }
      },
      character(1)
    )

  base$P_both_at_or_below_reference_true_effect_05 <-
    vapply(
      base$Event_difference_boundary_D,
      function(D) {
        prob_meet_futility_both(
          D = D,
          n1 = n1,
          pP_true = 0.45,
          pT_true = 0.40
        )
      },
      numeric(1)
    )

  base$Reference_interim_observed_effect <-
    base$Equivalent_interim_ARR_boundary

  base$P_both_at_or_below_reference_true_effect_0 <-
    base$P_meet_futility_true_ARR_0

  base$P_both_at_or_below_reference_true_effect_15 <-
    base$P_meet_futility_true_ARR_15

  base[
    ,
    c(
      "N_per_arm",
      "Stage1_target_fraction",
      "n1_nominal",
      "Reference_interim_observed_effect",
      "Event_count_difference_reference",
      "Event_count_reference_meaning",
      "Conditional_power_individual",
      "Joint_conditional_power",
      "P_both_at_or_below_reference_true_effect_0",
      "P_both_at_or_below_reference_true_effect_05",
      "P_both_at_or_below_reference_true_effect_15",
      "P_any_final_ARR_ge_15",
      "P_any_final_ARR_ge_10",
      "P_any_final_ARR_ge_05"
    )
  ]
}

focused <- do.call(
  rbind,
  lapply(
    c(0.40, 0.50, 0.60),
    function(f1) {
      make_focused_table(
        N = 44,
        f1 = f1
      )
    }
  )
)

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  focused,
  "simulation/results/cp_crc_vitality_style_focused_N44_v1_5.csv",
  row.names = FALSE
)

print(focused)
