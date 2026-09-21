# CP boundary calibration by exact enumeration v0.3
# Project: CIPN-related randomized Phase II design
# Date: 2026-09-21
#
# Purpose:
#   Calibrate Stage 1 conditional-power boundaries for the two candidate
#   policies without Monte Carlo noise.
#
# Candidate policies:
#   Design A: arm-wise CP futility + dose dropping; overall No-Go if both futile.
#   Design B: project-level CP futility only; no dose dropping; overall No-Go
#             if both futile.
#
# IMPORTANT:
#   For a fixed CP calculation and cutoff, the two policies have identical
#   Stage 1 overall No-Go probability. They differ when exactly one dose is
#   futile: Design A drops that dose; Design B retains both doses.
#
# v0.3 assumptions:
#   - CRC working placebo event rate pP = 0.45
#   - maximum N = 44/arm
#   - design-alternative CP only in the primary calibration:
#         future placebo event rate = 0.45
#         future active event rate  = 0.30
#   - provisional final-Go rule: observed final ARR >= delta_go
#   - no overrun, accrual delay, safety override, missing data, or early endpoint
#
# delta_go remains a sensitivity parameter. It is NOT a frozen clinical cutoff.

# ============================================================
# 0. Utilities
# ============================================================

binom_pmf <- function(n, p) {
  dbinom(0:n, size = n, prob = p)
}


# ============================================================
# 1. Provisional final Go rule
# ============================================================

is_final_go <- function(
  xP_final,
  xT_final,
  NP,
  NT,
  delta_go
) {
  arr_hat <- (xP_final / NP) - (xT_final / NT)
  arr_hat >= delta_go
}


# ============================================================
# 2. CP lookup under design-alternative future assumption
# ============================================================

cp_lookup_design <- function(
  n1,
  N,
  delta_go,
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
    dimnames = list(
      xP = 0:n1,
      xT = 0:n1
    )
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


# ============================================================
# 3. Exact Stage 1 operating characteristics
# ============================================================
#
# Exact enumeration over:
#   xP = 0,...,n1
#   xL = 0,...,n1
#   xH = 0,...,n1
#
# This avoids Monte Carlo error for the boundary-calibration quantities.

exact_stage1_oc <- function(
  pP,
  pL,
  pH,
  N,
  n1,
  delta_go,
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

  # Design A:
  #   both futile -> stop after Stage 1
  #   exactly one futile -> keep placebo + one active in Stage 2
  #   neither futile -> all 3 arms continue
  EN_A <-
    p_no_go * (3 * n1) +
    p_one_fut * (3 * n1 + 2 * m) +
    p_both_continue * (3 * N)

  # Design B:
  #   both futile -> stop after Stage 1
  #   otherwise all 3 arms continue
  EN_B <-
    p_no_go * (3 * n1) +
    (1 - p_no_go) * (3 * N)

  data.frame(
    pP = pP,
    pL = pL,
    pH = pH,
    ARR_L = pP - pL,
    ARR_H = pP - pH,
    N = N,
    n1 = n1,
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


# ============================================================
# 4. Full true-effect scenario grid
# ============================================================

effect_grid <- c(
  0.00,
  0.05,
  0.10,
  0.15,
  0.20
)

scenarios <- expand.grid(
  ARR_L = effect_grid,
  ARR_H = effect_grid,
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)

scenarios$pP <- 0.45
scenarios$pL <- scenarios$pP - scenarios$ARR_L
scenarios$pH <- scenarios$pP - scenarios$ARR_H

scenarios$scenario <- paste0(
  "ARR_L_",
  sprintf("%02d", round(100 * scenarios$ARR_L)),
  "_H_",
  sprintf("%02d", round(100 * scenarios$ARR_H))
)


# ============================================================
# 5. Boundary grid
# ============================================================

design_grid <- expand.grid(
  n1 = c(18, 22, 26),
  delta_go = c(0.05, 0.075, 0.10),
  cF = c(0.05, 0.10, 0.15, 0.20),
  stringsAsFactors = FALSE
)


# ============================================================
# 6. Exact evaluation
# ============================================================

out <- vector(
  "list",
  nrow(design_grid) * nrow(scenarios)
)

index <- 1L

for (i in seq_len(nrow(design_grid))) {

  g <- design_grid[i, ]

  # CP lookup is internally deterministic; exact_stage1_oc() uses exact
  # enumeration. No random seed is required.

  for (j in seq_len(nrow(scenarios))) {

    s <- scenarios[j, ]

    ans <- exact_stage1_oc(
      pP = s$pP,
      pL = s$pL,
      pH = s$pH,
      N = 44,
      n1 = g$n1,
      delta_go = g$delta_go,
      cF = g$cF,
      p_future_p = 0.45,
      p_future_t = 0.30
    )

    ans$scenario <- s$scenario

    out[[index]] <- ans
    index <- index + 1L
  }
}

results <- do.call(rbind, out)


# ============================================================
# 7. Save full exact grid
# ============================================================

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  results,
  "simulation/results/cp_boundary_grid_v0_3_full.csv",
  row.names = FALSE
)


# ============================================================
# 8. Boundary-selection summary
# ============================================================
#
# The summary focuses on scenarios that are most useful for selecting a
# conservative futility boundary:
#
#   Null:
#       ARR_L = 0%, ARR_H = 0%
#
#   Weak both:
#       ARR_L = 5%, ARR_H = 5%
#
#   One target-effective dose:
#       ARR_L = 15%, ARR_H = 0%
#
#   Both target-effective:
#       ARR_L = 15%, ARR_H = 15%
#
#   One strong dose:
#       ARR_L = 20%, ARR_H = 0%

get_row <- function(
  dat,
  n1,
  delta_go,
  cF,
  ARR_L,
  ARR_H
) {
  dat[
    dat$n1 == n1 &
      abs(dat$delta_go - delta_go) < 1e-12 &
      abs(dat$cF - cF) < 1e-12 &
      abs(dat$ARR_L - ARR_L) < 1e-12 &
      abs(dat$ARR_H - ARR_H) < 1e-12,
  ]
}

summary_list <- vector(
  "list",
  nrow(design_grid)
)

for (i in seq_len(nrow(design_grid))) {

  g <- design_grid[i, ]

  r_null <- get_row(
    results, g$n1, g$delta_go, g$cF, 0.00, 0.00
  )

  r_weak <- get_row(
    results, g$n1, g$delta_go, g$cF, 0.05, 0.05
  )

  r_one15 <- get_row(
    results, g$n1, g$delta_go, g$cF, 0.15, 0.00
  )

  r_both15 <- get_row(
    results, g$n1, g$delta_go, g$cF, 0.15, 0.15
  )

  r_one20 <- get_row(
    results, g$n1, g$delta_go, g$cF, 0.20, 0.00
  )

  summary_list[[i]] <- data.frame(
    n1 = g$n1,
    delta_go = g$delta_go,
    cF = g$cF,

    P_NoGo_null = r_null$P_NoGo_S1,
    P_NoGo_weak_both_5 = r_weak$P_NoGo_S1,

    P_Drop_target15 =
      r_one15$P_Futility_L,

    P_NoGo_one_target15 =
      r_one15$P_NoGo_S1,

    P_NoGo_both_target15 =
      r_both15$P_NoGo_S1,

    P_Drop_target20 =
      r_one20$P_Futility_L,

    N_saved_A_vs_B_null =
      r_null$N_saved_A_vs_B,

    N_saved_A_vs_B_one_target15 =
      r_one15$N_saved_A_vs_B
  )
}

boundary_summary <- do.call(
  rbind,
  summary_list
)

write.csv(
  boundary_summary,
  "simulation/results/cp_boundary_grid_v0_3_summary.csv",
  row.names = FALSE
)

print(boundary_summary)


# ============================================================
# 9. Optional screening table
# ============================================================
#
# The following is NOT a design criterion; it is only a convenient view.
# It identifies settings with:
#
#   P(drop a truly ARR=15% dose) <= 5%
#   P(overall No-Go when one dose has ARR=15%) <= 3%
#
# These tolerances are illustrative and must NOT be treated as approved
# departmental thresholds.

screened <- subset(
  boundary_summary,
  P_Drop_target15 <= 0.05 &
    P_NoGo_one_target15 <= 0.03
)

screened <- screened[
  order(
    -screened$P_NoGo_null,
    -screened$N_saved_A_vs_B_one_target15
  ),
]

write.csv(
  screened,
  "simulation/results/cp_boundary_grid_v0_3_screened_example.csv",
  row.names = FALSE
)

print(screened)
