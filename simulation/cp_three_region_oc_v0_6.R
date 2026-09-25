# ================================================================
# CIPN randomized Phase II - Cohort 1
# Three-region Stage 1 CP operating characteristics
# Version 0.6
# Date: 2026-09-25
#
# Current candidate design space:
#   N per arm = 44, 48, 52
#   Stage 1 information fraction = 35%, 40%
#   lower CP boundary = 25%, 30%, 35%
#   upper favorable CP boundary = 50%
#
# Project-level Stage 1 statistic:
#   M = max(CP_L, CP_H)
#
# Regions:
#   Low/futility        : M < c_low
#   Intermediate/gray  : c_low <= M <= 0.50
#   Favorable          : M > 0.50
#
# CP is the conditional probability of achieving a final observed
# treatment effect >= 10%, under the design-alternative future-data
# assumption pP_future=0.45, pT_future=0.30.
#
# These are NON-BINDING decision-support regions.
# No external R packages are required.
# ================================================================

source("simulation/cp_futility_engine.R")

N_grid <- c(44, 48, 52)
info_grid <- c(0.35, 0.40)
cp_low_grid <- c(0.25, 0.30, 0.35)
true_effect_grid <- c(0, 0.05, 0.10, 0.15, 0.20)

pP_true <- 0.45
qP <- 0.45
qT <- 0.30
promising_threshold <- 0.10
cp_high_boundary <- 0.50

round_half_up <- function(x) {
  floor(x + 0.5)
}

three_region_prob_exact <- function(
  N,
  info_fraction,
  cp_low_boundary,
  true_effect,
  pP_true = 0.45,
  qP = 0.45,
  qT = 0.30,
  promising_threshold = 0.10,
  cp_high_boundary = 0.50
) {
  n1 <- round_half_up(N * info_fraction)
  pT_true <- pP_true - true_effect

  lookup <- make_cp_lookup(
    nP = n1,
    nT = n1,
    NP = N,
    NT = N,
    delta_go = promising_threshold,
    qP = qP,
    qT = qT
  )

  cp_mat <- matrix(
    lookup$cp,
    nrow = n1 + 1,
    ncol = n1 + 1
  )

  p_xP <- dbinom(0:n1, size = n1, prob = pP_true)
  p_xT <- dbinom(0:n1, size = n1, prob = pT_true)

  P_low <- 0
  P_high <- 0
  P_both_high <- 0

  for (xP in 0:n1) {
    cp_row <- cp_mat[xP + 1, ]

    p_one_low <- sum(
      p_xT[cp_row < cp_low_boundary]
    )

    p_one_not_high <- sum(
      p_xT[cp_row <= cp_high_boundary]
    )

    p_one_high <- sum(
      p_xT[cp_row > cp_high_boundary]
    )

    # M=max(CP_L,CP_H)
    # Low iff both active-arm CP values are below the lower boundary.
    P_low <- P_low +
      p_xP[xP + 1] * p_one_low^2

    # High iff at least one active-arm CP exceeds 50%.
    P_high <- P_high +
      p_xP[xP + 1] * (1 - p_one_not_high^2)

    # Supplementary diagnostic: both doses >50%.
    P_both_high <- P_both_high +
      p_xP[xP + 1] * p_one_high^2
  }

  P_intermediate <- 1 - P_low - P_high

  data.frame(
    N_per_arm = N,
    IA_fraction = info_fraction,
    n1_per_arm = n1,
    CP_low_boundary = cp_low_boundary,
    CP_high_boundary = cp_high_boundary,
    true_effect = true_effect,
    pP_true = pP_true,
    pT_true = pT_true,
    P_low = P_low,
    P_intermediate = P_intermediate,
    P_high = P_high,
    P_both_CP_gt50 = P_both_high
  )
}

rows <- list()
k <- 1L

for (N in N_grid) {
  for (f1 in info_grid) {
    for (c_low in cp_low_grid) {
      for (delta_true in true_effect_grid) {
        rows[[k]] <- three_region_prob_exact(
          N = N,
          info_fraction = f1,
          cp_low_boundary = c_low,
          true_effect = delta_true
        )
        k <- k + 1L
      }
    }
  }
}

out <- do.call(rbind, rows)

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  out,
  "simulation/results/cp_three_region_oc_v0_6.csv",
  row.names = FALSE
)

# Event-count interpretation around the 50% upper boundary.
# D=xP-xT; positive D favors AK135.
event_count_rows <- list()
k <- 1L

for (N in N_grid) {
  for (f1 in info_grid) {
    n1 <- round_half_up(N * f1)

    D_grid <- -n1:n1
    cp_D <- sapply(
      D_grid,
      function(D) {
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
          delta_go = promising_threshold,
          qP = qP,
          qT = qT
        )
      }
    )

    D_min_high <- min(
      D_grid[cp_D > cp_high_boundary]
    )

    event_count_rows[[k]] <- data.frame(
      N_per_arm = N,
      IA_fraction = f1,
      n1_per_arm = n1,
      D_min_for_CP_gt50 = D_min_high,
      CP_at_D_minus1 = cp_D[D_grid == -1],
      CP_at_D_0 = cp_D[D_grid == 0],
      CP_at_D_plus1 = cp_D[D_grid == 1]
    )

    k <- k + 1L
  }
}

event_count_map <- do.call(rbind, event_count_rows)

write.csv(
  event_count_map,
  "simulation/results/cp_three_region_event_count_map_v0_6.csv",
  row.names = FALSE
)

print(out)
print(event_count_map)
