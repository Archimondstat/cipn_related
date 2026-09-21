# Focused VITALITY-style CRC boundary table v1.3
# Date: 2026-09-21
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
# Main interim boundaries shown:
#   approximately -5%, 0%, +5%, +10%
#
# The single negative row is retained only as a conservative reference.

source("simulation/cp_crc_vitality_style_analysis.R")

make_focused_table <- function(
  N = 44,
  f1
) {
  n1 <- floor(N * f1 + 0.5)

  target_effect_boundaries <- c(
    -0.05,
    0.00,
    0.05,
    0.10
  )

  D_values <- unique(
    round(
      target_effect_boundaries * n1
    )
  )

  base <- make_vitality_style_table(
    N = N,
    f1 = f1,
    D_grid = D_values
  )

  # Event-count interpretation of the displayed treatment-effect boundary.
  #
  # D = x_placebo - x_treatment
  #
  # Positive D means placebo has more CTCAE >=2 CIPN events than treatment,
  # which favors treatment.  The futility rule is D_observed <= D_boundary.
  base$Event_count_difference_boundary <-
    base$Event_difference_boundary_D

  base$Event_count_boundary_meaning <-
    vapply(
      base$Event_count_difference_boundary,
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

  base$P_meet_futility_true_effect_05 <-
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

  base[
    ,
    c(
      "N_per_arm",
      "Stage1_target_fraction",
      "n1_nominal",
      "Equivalent_interim_ARR_boundary",
      "Event_count_difference_boundary",
      "Event_count_boundary_meaning",
      "Conditional_power_individual",
      "Joint_conditional_power",
      "P_meet_futility_true_ARR_0",
      "P_meet_futility_true_effect_05",
      "P_meet_futility_true_ARR_15",
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
  "simulation/results/cp_crc_vitality_style_focused_N44_v1_4.csv",
  row.names = FALSE
)

print(focused)
