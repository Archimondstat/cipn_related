# CRC full operating-characteristic calibration v0.6
# Project: CIPN-related randomized Phase II design
# Date: 2026-09-21
#
# Purpose:
#   Extend v0.5 by calculating the exact probability of final program Go
#   for BOTH candidate policies across candidate N, Stage 1 information
#   fractions, and CP futility cutoffs.
#
# CRC efficacy assumptions are kept unchanged:
#   placebo event rate = 0.45
#   target active event rate = 0.30
#   target ARR = 0.15
#
# IMPORTANT:
#   The provisional final-Go rule remains observed final ARR >= 0.10.
#   Because the endpoint is binary, this produces an integer event-count
#   threshold and therefore visible lattice/discreteness effects across N.
#   Do not select N solely from final-Go probabilities under this working rule.

binom_pmf <- function(n, p) {
  dbinom(0:n, size = n, prob = p)
}

is_final_go <- function(
  xP_final,
  xT_final,
  NP,
  NT,
  delta_go = 0.10
) {
  (xP_final / NP) - (xT_final / NT) >= delta_go
}

final_event_difference_threshold <- function(
  N,
  delta_go = 0.10
) {
  ceiling(N * delta_go - 1e-12)
}

cp_lookup_design <- function(
  n1,
  N,
  delta_go = 0.10,
  p_future_p = 0.45,
  p_future_t = 0.30
) {
  stopifnot(n1 < N)

  m <- N - n1
  threshold <- final_event_difference_threshold(N, delta_go)

  pmf_p <- binom_pmf(m, p_future_p)

  out <- matrix(
    0,
    nrow = n1 + 1,
    ncol = n1 + 1,
    dimnames = list(xP = 0:n1, xT = 0:n1)
  )

  # Given future placebo count yP, final Go occurs when
  #
  #   (xP + yP) - (xT + yT) >= threshold
  #
  # or
  #
  #   yT <= xP + yP - xT - threshold.
  #
  # This avoids the inner yT loop.

  for (xP in 0:n1) {
    for (xT in 0:n1) {

      prob_go <- 0

      for (yP in 0:m) {

        max_yT <-
          xP + yP - xT - threshold

        prob_t_success <-
          pbinom(
            q = max_yT,
            size = m,
            prob = p_future_t
          )

        prob_go <-
          prob_go +
          pmf_p[yP + 1] * prob_t_success
      }

      out[xP + 1, xT + 1] <- prob_go
    }
  }

  out
}

exact_full_oc <- function(
  pP,
  pL,
  pH,
  N,
  n1,
  delta_go = 0.10,
  cF,
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

  probP1 <- binom_pmf(n1, pP)
  probL1 <- binom_pmf(n1, pL)
  probH1 <- binom_pmf(n1, pH)

  m <- N - n1
  probP2 <- binom_pmf(m, pP)

  threshold <-
    final_event_difference_threshold(
      N = N,
      delta_go = delta_go
    )

  p_no_go <- 0
  p_fut_L <- 0
  p_fut_H <- 0
  p_one_fut <- 0
  p_both_continue <- 0

  p_final_go_A <- 0
  p_final_go_B <- 0

  for (xP in 0:n1) {
    for (xL in 0:n1) {
      for (xH in 0:n1) {

        stage1_prob <-
          probP1[xP + 1] *
          probL1[xL + 1] *
          probH1[xH + 1]

        futileL <-
          cp_tab[xP + 1, xL + 1] < cF

        futileH <-
          cp_tab[xP + 1, xH + 1] < cF

        noGo <- futileL && futileH
        oneFut <- xor(futileL, futileH)
        bothContinue <- (!futileL) && (!futileH)

        p_no_go <-
          p_no_go +
          stage1_prob * noGo

        p_fut_L <-
          p_fut_L +
          stage1_prob * futileL

        p_fut_H <-
          p_fut_H +
          stage1_prob * futileH

        p_one_fut <-
          p_one_fut +
          stage1_prob * oneFut

        p_both_continue <-
          p_both_continue +
          stage1_prob * bothContinue

        if (noGo) {
          next
        }

        conditional_go_A <- 0
        conditional_go_B <- 0

        for (yP in 0:m) {

          max_yL <-
            xP + yP - xL - threshold

          max_yH <-
            xP + yP - xH - threshold

          qL <-
            pbinom(
              q = max_yL,
              size = m,
              prob = pL
            )

          qH <-
            pbinom(
              q = max_yH,
              size = m,
              prob = pH
            )

          # Design B retains both active doses unless both are futile.
          q_program_B <-
            qL + qH - qL * qH

          # Design A drops an individually futile dose.
          if (futileL && !futileH) {
            q_program_A <- qH
          } else if (!futileL && futileH) {
            q_program_A <- qL
          } else {
            q_program_A <- q_program_B
          }

          conditional_go_A <-
            conditional_go_A +
            probP2[yP + 1] * q_program_A

          conditional_go_B <-
            conditional_go_B +
            probP2[yP + 1] * q_program_B
        }

        p_final_go_A <-
          p_final_go_A +
          stage1_prob * conditional_go_A

        p_final_go_B <-
          p_final_go_B +
          stage1_prob * conditional_go_B
      }
    }
  }

  EN_A <-
    p_no_go * (3 * n1) +
    p_one_fut * (3 * n1 + 2 * m) +
    p_both_continue * (3 * N)

  EN_B <-
    p_no_go * (3 * n1) +
    (1 - p_no_go) * (3 * N)

  data.frame(
    pP = pP,
    pL = pL,
    pH = pH,
    ARR_L = pP - pL,
    ARR_H = pP - pH,
    N_per_arm = N,
    n1_per_arm = n1,
    information_fraction_actual = n1 / N,
    delta_go = delta_go,
    effective_final_ARR_threshold =
      final_event_difference_threshold(N, delta_go) / N,
    cF = cF,
    P_NoGo_S1 = p_no_go,
    P_Futility_L = p_fut_L,
    P_Futility_H = p_fut_H,
    P_ExactlyOneFutility = p_one_fut,
    P_BothContinue = p_both_continue,
    P_FinalProgramGo_A = p_final_go_A,
    P_FinalProgramGo_B = p_final_go_B,
    EN_A_no_overrun = EN_A,
    EN_B_no_overrun = EN_B,
    N_saved_A_vs_B = EN_B - EN_A
  )
}

arr_half_width_target <- function(
  N,
  pP = 0.45,
  pT = 0.30,
  z = qnorm(0.975)
) {
  z * sqrt(
    pP * (1 - pP) / N +
      pT * (1 - pT) / N
  )
}

# ============================================================
# Frozen CRC assumptions
# ============================================================

pP_crc <- 0.45
pT_crc <- 0.30
ARR_target_crc <- 0.15
delta_go_working <- 0.10

# ============================================================
# Key truth scenarios
# ============================================================

scenarios <- data.frame(
  scenario = c(
    "Null_0_0",
    "WeakBoth_5_5",
    "OneTarget15_OtherNull",
    "BothTarget15"
  ),
  pP = rep(0.45, 4),
  pL = c(0.45, 0.40, 0.30, 0.30),
  pH = c(0.45, 0.40, 0.45, 0.30),
  stringsAsFactors = FALSE
)

# ============================================================
# Candidate design grid
# ============================================================

design_grid <- expand.grid(
  N_per_arm = c(36, 40, 44, 48, 52),
  f1_target = c(0.40, 0.50, 0.60),
  cF = c(0.05, 0.10, 0.15, 0.20),
  stringsAsFactors = FALSE
)

design_grid$n1_per_arm <-
  floor(
    design_grid$N_per_arm *
      design_grid$f1_target +
      0.5
  )

# ============================================================
# Exact evaluation
# ============================================================

results <- vector(
  "list",
  nrow(design_grid) *
    nrow(scenarios)
)

idx <- 1L

for (i in seq_len(nrow(design_grid))) {

  g <- design_grid[i, ]

  for (j in seq_len(nrow(scenarios))) {

    s <- scenarios[j, ]

    ans <- exact_full_oc(
      pP = s$pP,
      pL = s$pL,
      pH = s$pH,
      N = g$N_per_arm,
      n1 = g$n1_per_arm,
      delta_go = delta_go_working,
      cF = g$cF,
      p_future_p = pP_crc,
      p_future_t = pT_crc
    )

    ans$f1_target <- g$f1_target
    ans$scenario <- s$scenario
    ans$ARR_half_width_95_target <-
      arr_half_width_target(
        N = g$N_per_arm,
        pP = pP_crc,
        pT = pT_crc
      )

    results[[idx]] <- ans
    idx <- idx + 1L
  }
}

results <- do.call(
  rbind,
  results
)

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  results,
  "simulation/results/cp_crc_full_OC_v0_6.csv",
  row.names = FALSE
)

# ============================================================
# Display the final-threshold lattice explicitly
# ============================================================

threshold_table <- data.frame(
  N_per_arm = c(36, 40, 44, 48, 52)
)

threshold_table$required_event_difference <-
  vapply(
    threshold_table$N_per_arm,
    final_event_difference_threshold,
    numeric(1),
    delta_go = delta_go_working
  )

threshold_table$effective_ARR_threshold <-
  threshold_table$required_event_difference /
  threshold_table$N_per_arm

threshold_table$ARR_half_width_95_target <-
  vapply(
    threshold_table$N_per_arm,
    arr_half_width_target,
    numeric(1)
  )

write.csv(
  threshold_table,
  "simulation/results/cp_crc_final_threshold_lattice_v0_6.csv",
  row.names = FALSE
)

print(threshold_table)
