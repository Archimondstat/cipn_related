# ================================================================
# CIPN randomized Phase II - Cohort 1
# Observed interim effect -> individual CP mapping
# Version 0.7
# Date: 2026-09-25
#
# Candidate design space:
#   N per arm = 44, 48, 52
#   Stage 1 information fraction = 35%, 40%, 45%
#
# CP definition:
#   P(final observed treatment effect >= 10% |
#     interim data, future pP=0.45 and pT=0.30)
#
# Equal nominal interim n per arm is used only for design calibration.
# Because the endpoint is binary, observed effects are discrete.
# ================================================================

source("simulation/cp_futility_engine.R")

N_grid <- c(44, 48, 52)
info_grid <- c(0.35, 0.40, 0.45)
D_grid <- -1:4
target_effect_grid <- c(0, 0.05, 0.10, 0.15)
upper_cp_grid <- c(0.60, 0.70, 0.80)

round_half_up <- function(x) floor(x + 0.5)

cp_from_D <- function(N, n1, D) {
  if (D >= 0) {
    xp <- D
    xt <- 0
  } else {
    xp <- 0
    xt <- -D
  }

  cp_individual_exact(
    xp = xp,
    np = n1,
    xt = xt,
    nt = n1,
    NP = N,
    NT = N,
    delta_go = 0.10,
    qP = 0.45,
    qT = 0.30
  )
}

# ---------------------------------------------------------------
# 1. Event-count mapping
# ---------------------------------------------------------------

event_rows <- list()
k <- 1L

for (N in N_grid) {
  for (f1 in info_grid) {
    n1 <- round_half_up(N * f1)

    for (D in D_grid) {
      event_rows[[k]] <- data.frame(
        N_per_arm = N,
        IA_fraction = f1,
        n1_per_arm = n1,
        Event_count_difference_xP_minus_xT = D,
        Attainable_observed_effect = D / n1,
        Individual_CP = cp_from_D(N, n1, D)
      )
      k <- k + 1L
    }
  }
}

event_map <- do.call(rbind, event_rows)

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  event_map,
  "simulation/results/cp_observed_effect_event_map_v0_7.csv",
  row.names = FALSE
)

# ---------------------------------------------------------------
# 2. Requested 0%, 5%, 10%, 15% display values
#    Map each target display effect to the nearest attainable
#    event-count difference.
# ---------------------------------------------------------------

target_rows <- list()
k <- 1L

for (N in N_grid) {
  for (f1 in info_grid) {
    n1 <- round_half_up(N * f1)

    for (target_effect in target_effect_grid) {
      D <- round(target_effect * n1)

      target_rows[[k]] <- data.frame(
        N_per_arm = N,
        IA_fraction = f1,
        n1_per_arm = n1,
        Requested_effect = target_effect,
        Event_count_difference_xP_minus_xT = D,
        Attainable_observed_effect = D / n1,
        Individual_CP = cp_from_D(N, n1, D)
      )
      k <- k + 1L
    }
  }
}

target_map <- do.call(rbind, target_rows)

write.csv(
  target_map,
  "simulation/results/cp_observed_effect_target_map_v0_7.csv",
  row.names = FALSE
)

# ---------------------------------------------------------------
# 3. Upper favorable boundary screen
#    Project favorable if max(CP_L, CP_H) > c_upper.
# ---------------------------------------------------------------

prob_max_cp_gt <- function(
  N,
  n1,
  pP_true,
  pT_true,
  upper_boundary
) {
  lookup <- make_cp_lookup(
    nP = n1,
    nT = n1,
    NP = N,
    NT = N,
    delta_go = 0.10,
    qP = 0.45,
    qT = 0.30
  )

  cp_mat <- matrix(
    lookup$cp,
    nrow = n1 + 1,
    ncol = n1 + 1
  )

  p_xP <- dbinom(0:n1, size = n1, prob = pP_true)
  p_xT <- dbinom(0:n1, size = n1, prob = pT_true)

  ans <- 0

  for (xP in 0:n1) {
    p_one_not_high <- sum(
      p_xT[cp_mat[xP + 1, ] <= upper_boundary]
    )

    ans <- ans +
      p_xP[xP + 1] *
      (1 - p_one_not_high^2)
  }

  ans
}

upper_rows <- list()
k <- 1L

for (N in N_grid) {
  for (f1 in info_grid) {
    n1 <- round_half_up(N * f1)

    for (c_upper in upper_cp_grid) {
      upper_rows[[k]] <- data.frame(
        N_per_arm = N,
        IA_fraction = f1,
        n1_per_arm = n1,
        Upper_CP_boundary = c_upper,
        P_favorable_true_effect_0 =
          prob_max_cp_gt(
            N, n1, 0.45, 0.45, c_upper
          ),
        P_favorable_true_effect_15 =
          prob_max_cp_gt(
            N, n1, 0.45, 0.30, c_upper
          )
      )
      k <- k + 1L
    }
  }
}

upper_screen <- do.call(rbind, upper_rows)

write.csv(
  upper_screen,
  "simulation/results/cp_upper_boundary_screen_v0_7.csv",
  row.names = FALSE
)

print(event_map)
print(target_map)
print(upper_screen)
