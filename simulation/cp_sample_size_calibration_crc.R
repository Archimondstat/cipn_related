# CRC sample-size / Stage 1 calibration v0.5
# Project: CIPN-related randomized Phase II design
# Date: 2026-09-21
#
# Purpose:
#   Expand the CP calibration from a fixed N=44/arm to a grid of candidate
#   maximum sample sizes while KEEPING the CRC efficacy assumptions unchanged.
#
# Frozen CRC efficacy assumptions:
#   Placebo event rate pP = 0.45
#   Target active event rate pT = 0.30
#   Target ARR = 0.15
#
# IMPORTANT:
#   The provisional final-Go criterion (observed final ARR >= 0.10) is a
#   decision-rule sensitivity setting, not the assumed treatment effect.
#
# Candidate design dimensions:
#   N per arm          = 36, 40, 44, 48, 52
#   Stage 1 fraction   = 40%, 50%, 60%
#   CP futility cutoff = 5%, 10%, 15%, 20%
#
# This script focuses on exact Stage 1 operating characteristics and
# expected sample size. Operational overrun is still excluded.

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
  arr_hat <- (xP_final / NP) - (xT_final / NT)
  arr_hat >= delta_go
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

  pmf_p <- binom_pmf(m, p_future_p)
  pmf_t <- binom_pmf(m, p_future_t)
  joint <- outer(pmf_p, pmf_t)

  out <- matrix(
    0,
    nrow = n1 + 1,
    ncol = n1 + 1,
    dimnames = list(xP = 0:n1, xT = 0:n1)
  )

  for (xP in 0:n1) {
    for (xT in 0:n1) {

      prob_go <- 0

      for (yP in 0:m) {
        for (yT in 0:m) {

          if (is_final_go(
            xP_final = xP + yP,
            xT_final = xT + yT,
            NP = N,
            NT = N,
            delta_go = delta_go
          )) {
            prob_go <- prob_go +
              joint[yP + 1, yT + 1]
          }
        }
      }

      out[xP + 1, xT + 1] <- prob_go
    }
  }

  out
}

exact_stage1_oc <- function(
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

  probP <- dbinom(0:n1, n1, pP)
  probL <- dbinom(0:n1, n1, pL)
  probH <- dbinom(0:n1, n1, pH)

  p_no_go <- 0
  p_fut_L <- 0
  p_fut_H <- 0
  p_one_fut <- 0
  p_both_continue <- 0

  for (xP in 0:n1) {
    for (xL in 0:n1) {
      for (xH in 0:n1) {

        pr <- probP[xP + 1] *
          probL[xL + 1] *
          probH[xH + 1]

        futileL <- cp_tab[xP + 1, xL + 1] < cF
        futileH <- cp_tab[xP + 1, xH + 1] < cF

        noGo <- futileL && futileH
        oneFut <- xor(futileL, futileH)
        bothContinue <- (!futileL) && (!futileH)

        p_no_go <- p_no_go + pr * noGo
        p_fut_L <- p_fut_L + pr * futileL
        p_fut_H <- p_fut_H + pr * futileH
        p_one_fut <- p_one_fut + pr * oneFut
        p_both_continue <- p_both_continue + pr * bothContinue
      }
    }
  }

  m <- N - n1

  # Design A: individual arm dropping
  EN_A <-
    p_no_go * (3 * n1) +
    p_one_fut * (3 * n1 + 2 * m) +
    p_both_continue * (3 * N)

  # Design B: project-level futility only
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
    cF = cF,
    P_NoGo_S1 = p_no_go,
    P_Futility_L = p_fut_L,
    P_Futility_H = p_fut_H,
    P_ExactlyOneFutility = p_one_fut,
    P_BothContinue = p_both_continue,
    EN_A_no_overrun = EN_A,
    EN_B_no_overrun = EN_B,
    N_saved_A_vs_B = EN_B - EN_A
  )
}

# Approximate 95% CI half-width for an ARR at the frozen target rates.
# This is retained only as a precision descriptor; it no longer determines N.
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

# ------------------------------------------------------------
# Frozen CRC efficacy assumptions
# ------------------------------------------------------------

pP_crc <- 0.45
pT_crc <- 0.30
ARR_target_crc <- pP_crc - pT_crc

stopifnot(abs(ARR_target_crc - 0.15) < 1e-12)

# ------------------------------------------------------------
# Candidate scenarios
# ------------------------------------------------------------

scenarios <- data.frame(
  scenario = c(
    "Null_0_0",
    "WeakBoth_5_5",
    "OneTarget15_OtherNull",
    "BothTarget15",
    "Target15_Strong20",
    "BothStrong20"
  ),
  pP = rep(0.45, 6),
  pL = c(0.45, 0.40, 0.30, 0.30, 0.30, 0.25),
  pH = c(0.45, 0.40, 0.45, 0.30, 0.25, 0.25),
  stringsAsFactors = FALSE
)

# ------------------------------------------------------------
# Candidate design grid
# ------------------------------------------------------------

design_grid <- expand.grid(
  N_per_arm = c(36, 40, 44, 48, 52),
  f1_target = c(0.40, 0.50, 0.60),
  cF = c(0.05, 0.10, 0.15, 0.20),
  stringsAsFactors = FALSE
)

# Nearest integer nominal mature-subject count per arm.
# Actual interim implementation will use actual n by arm; this is only
# the design-calibration representation.
design_grid$n1_per_arm <- floor(
  design_grid$N_per_arm * design_grid$f1_target + 0.5
)

design_grid$information_fraction_actual <-
  design_grid$n1_per_arm / design_grid$N_per_arm

# Keep the current provisional final-Go working rule fixed while calibrating N.
delta_go_working <- 0.10

# ------------------------------------------------------------
# Exact evaluation
# ------------------------------------------------------------

results <- vector(
  "list",
  nrow(design_grid) * nrow(scenarios)
)

idx <- 1L

for (i in seq_len(nrow(design_grid))) {

  g <- design_grid[i, ]

  for (j in seq_len(nrow(scenarios))) {

    s <- scenarios[j, ]

    ans <- exact_stage1_oc(
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

results <- do.call(rbind, results)

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  results,
  "simulation/results/cp_crc_N_f1_cF_grid_v0_5_full.csv",
  row.names = FALSE
)

# ------------------------------------------------------------
# Compact design-selection table
# ------------------------------------------------------------

pick <- function(dat, scenario_name) {
  dat[
    dat$scenario == scenario_name,
  ]
}

r_null <- pick(results, "Null_0_0")
r_one15 <- pick(results, "OneTarget15_OtherNull")
r_both15 <- pick(results, "BothTarget15")

key <- c(
  "N_per_arm",
  "n1_per_arm",
  "f1_target",
  "information_fraction_actual",
  "delta_go",
  "cF"
)

summary <- merge(
  r_null[
    ,
    c(
      key,
      "P_NoGo_S1",
      "EN_A_no_overrun",
      "EN_B_no_overrun",
      "N_saved_A_vs_B",
      "ARR_half_width_95_target"
    )
  ],
  r_one15[
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

summary <- merge(
  summary,
  r_both15[
    ,
    c(
      key,
      "P_NoGo_S1"
    )
  ],
  by = key
)

names(summary)[names(summary) == "P_NoGo_S1"] <-
  "P_NoGo_both15"

names(summary)[names(summary) == "P_Futility_L"] <-
  "P_Futility_target15"

names(summary)[names(summary) == "P_NoGo_S1_null"] <-
  "P_NoGo_null"

names(summary)[names(summary) == "P_NoGo_S1_one15"] <-
  "P_NoGo_one_target15"

write.csv(
  summary,
  "simulation/results/cp_crc_N_f1_cF_grid_v0_5_summary.csv",
  row.names = FALSE
)

print(summary)
