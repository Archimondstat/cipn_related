# ================================================================
# CIPN randomized Phase II - Cohort 1
# Stage 1 information-fraction x CP-cutoff calibration
# Version 0.1
# Date: 2026-09-23
#
# Working rule used ONLY for calibration:
#   project-level futility stop if BOTH individual dose CP values
#   are below the candidate cutoff.
#
# The current final-N anchor is 44 per arm.
# No external R packages are required.
# ================================================================

source("simulation/cp_futility_engine.R")

N <- 44
info_grid <- c(0.35, 0.40, 0.45, 0.50)
cp_cutoff_grid <- seq(0.25, 0.50, by = 0.05)
true_effect_grid <- c(0, 0.05, 0.10, 0.15, 0.20)

pP_true <- 0.45
qP <- 0.45
qT <- 0.30
promising_threshold <- 0.10
nsim <- 400000
seed <- 20260923

round_half_up <- function(x) {
  floor(x + 0.5)
}

# ---------------------------------------------------------------
# Exact early-stop probability for equal nominal interim n
# ---------------------------------------------------------------

prob_early_stop_exact <- function(
  n1,
  cp_cutoff,
  pP_true,
  pT_true,
  N = 44,
  qP = 0.45,
  qT = 0.30,
  promising_threshold = 0.10
) {

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

  p_xP <- dbinom(
    0:n1,
    size = n1,
    prob = pP_true
  )

  p_xT <- dbinom(
    0:n1,
    size = n1,
    prob = pT_true
  )

  ans <- 0

  for (xP in 0:n1) {

    p_one_active_below <-
      sum(
        p_xT[
          cp_mat[xP + 1, ] < cp_cutoff
        ]
      )

    ans <-
      ans +
      p_xP[xP + 1] *
      p_one_active_below^2
  }

  ans
}

# ---------------------------------------------------------------
# Monte Carlo operating characteristics
# ---------------------------------------------------------------

simulate_design <- function(
  info_fraction,
  cp_cutoff,
  true_effect,
  N = 44,
  nsim = 400000,
  seed = 20260923
) {

  n1 <- round_half_up(
    N * info_fraction
  )

  m <- N - n1

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

  # Keep random streams identical across cutoffs for a given
  # information fraction / true-effect scenario.
  set.seed(
    seed +
      1000L * round(100 * info_fraction) +
      round(100 * true_effect)
  )

  xP1 <- rbinom(
    nsim,
    size = n1,
    prob = pP_true
  )

  xL1 <- rbinom(
    nsim,
    size = n1,
    prob = pT_true
  )

  xH1 <- rbinom(
    nsim,
    size = n1,
    prob = pT_true
  )

  cpL <- cp_mat[
    cbind(
      xP1 + 1,
      xL1 + 1
    )
  ]

  cpH <- cp_mat[
    cbind(
      xP1 + 1,
      xH1 + 1
    )
  ]

  stop <- 
    cpL < cp_cutoff &
    cpH < cp_cutoff

  yP <- rbinom(
    nsim,
    size = m,
    prob = pP_true
  )

  yL <- rbinom(
    nsim,
    size = m,
    prob = pT_true
  )

  yH <- rbinom(
    nsim,
    size = m,
    prob = pT_true
  )

  xP_final <- xP1 + yP
  xL_final <- xL1 + yL
  xH_final <- xH1 + yH

  delta_L <-
    (xP_final - xL_final) / N

  delta_H <-
    (xP_final - xH_final) / N

  delta_max <-
    pmax(
      delta_L,
      delta_H
    )

  final_nogo <-
    delta_max < 0.05

  final_consider <-
    delta_max >= 0.05 &
    delta_max < 0.10

  final_go <-
    delta_max >= 0.10

  p_stop_exact <- prob_early_stop_exact(
    n1 = n1,
    cp_cutoff = cp_cutoff,
    pP_true = pP_true,
    pT_true = pT_true,
    N = N,
    qP = qP,
    qT = qT,
    promising_threshold = promising_threshold
  )

  expected_total_N_no_overrun <-
    3 * (
      n1 * p_stop_exact +
      N * (1 - p_stop_exact)
    )

  data.frame(
    N_per_arm = N,
    info_fraction = info_fraction,
    n1_nominal_per_arm = n1,
    cp_cutoff = cp_cutoff,
    true_effect = true_effect,
    pP_true = pP_true,
    pT_true = pT_true,
    P_early_stop_exact = p_stop_exact,
    P_early_stop_sim = mean(stop),
    P_continue_exact = 1 - p_stop_exact,
    Expected_total_N_no_overrun =
      expected_total_N_no_overrun,
    P_reach_final_and_NoGo =
      mean(!stop & final_nogo),
    P_reach_final_and_Consider =
      mean(!stop & final_consider),
    P_reach_final_and_Go =
      mean(!stop & final_go),
    P_final_Go_if_no_interim_rule =
      mean(final_go),
    Mean_individual_CP_L =
      mean(cpL),
    Mean_max_individual_CP =
      mean(
        pmax(
          cpL,
          cpH
        )
      )
  )
}

# ---------------------------------------------------------------
# Run full grid
# ---------------------------------------------------------------

rows <- list()
k <- 1L

for (info_fraction in info_grid) {
  for (true_effect in true_effect_grid) {
    for (cp_cutoff in cp_cutoff_grid) {

      rows[[k]] <- simulate_design(
        info_fraction = info_fraction,
        cp_cutoff = cp_cutoff,
        true_effect = true_effect,
        N = N,
        nsim = nsim,
        seed = seed
      )

      k <- k + 1L
    }
  }
}

full_grid <- do.call(
  rbind,
  rows
)

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  full_grid,
  "simulation/results/stage1_info_cp_grid_full_v0_1.csv",
  row.names = FALSE
)

# ---------------------------------------------------------------
# Key comparison table
#   null effect = 0%
#   intermediate = 10%
#   target effect = 15%
# ---------------------------------------------------------------

key_rows <- list()
k <- 1L

for (info_fraction in info_grid) {
  for (cp_cutoff in cp_cutoff_grid) {

    r0 <- full_grid[
      full_grid$info_fraction == info_fraction &
      full_grid$cp_cutoff == cp_cutoff &
      full_grid$true_effect == 0,
      ,
      drop = FALSE
    ]

    r10 <- full_grid[
      full_grid$info_fraction == info_fraction &
      full_grid$cp_cutoff == cp_cutoff &
      full_grid$true_effect == 0.10,
      ,
      drop = FALSE
    ]

    r15 <- full_grid[
      full_grid$info_fraction == info_fraction &
      full_grid$cp_cutoff == cp_cutoff &
      full_grid$true_effect == 0.15,
      ,
      drop = FALSE
    ]

    key_rows[[k]] <- data.frame(
      info_fraction = info_fraction,
      n1_nominal_per_arm =
        r0$n1_nominal_per_arm,
      cp_cutoff = cp_cutoff,
      P_stop_true_effect_0 =
        r0$P_early_stop_exact,
      P_stop_true_effect_10 =
        r10$P_early_stop_exact,
      P_stop_true_effect_15 =
        r15$P_early_stop_exact,
      Expected_total_N_true_effect_0 =
        r0$Expected_total_N_no_overrun,
      P_reach_final_Go_true_effect_15 =
        r15$P_reach_final_and_Go,
      Go_probability_loss_true_effect_15 =
        r15$P_final_Go_if_no_interim_rule -
        r15$P_reach_final_and_Go
    )

    k <- k + 1L
  }
}

key_grid <- do.call(
  rbind,
  key_rows
)

write.csv(
  key_grid,
  "simulation/results/stage1_info_cp_grid_key_v0_1.csv",
  row.names = FALSE
)

print(
  key_grid
)
