# CRC Stage 1 timing x boundary screening v0.9
# Date: 2026-09-21
#
# Purpose:
#   Compare Stage 1 timing at 40%, 50%, and 60% while separating
#   "when to look" from the discreteness of the nominal CP cutoff.
#
# Frozen CRC efficacy assumptions:
#   pP = 0.45
#   pT = 0.30
#   target ARR = 0.15
#
# Candidate maximum N/arm:
#   36, 40, 44, 48, 52
#
# Candidate nominal Stage 1 information fractions:
#   40%, 50%, 60%
#
# Reference actual Stage 1 event-count futility boundaries:
#
#   d1 = xP1 - xT1
#
#   d1 <= -4
#   d1 <= -3
#   d1 <= -2
#
# A negative d1 means the active arm has MORE CTCAE grade >=2 events
# than placebo. These three boundaries are reference levels only; none
# is selected.
#
# Why use actual event-count boundaries here?
# Conditional power is discrete for a binary endpoint. The same nominal
# CP cutoff can map to different integer decision boundaries when N or
# the Stage 1 information fraction changes. Matching the actual d1
# boundary gives a cleaner comparison of 40% vs 50% vs 60%.
#
# The script also reports the interval of nominal CP cutoffs that would
# produce each actual d1 boundary.

source("simulation/cp_sample_size_calibration_crc.R")

# ============================================================
# 1. Exact OC under a directly specified d1 boundary
# ============================================================

exact_oc_by_d_boundary <- function(
  pP,
  pL,
  pH,
  N,
  n1,
  d_boundary
) {
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

        futileL <- (xP - xL) <= d_boundary
        futileH <- (xP - xH) <= d_boundary

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

  # Design A: drop a single futile dose.
  EN_A <-
    p_no_go * (3 * n1) +
    p_one_fut * (3 * n1 + 2 * m) +
    p_both_continue * (3 * N)

  # Design B: no single-dose dropping.
  EN_B <-
    p_no_go * (3 * n1) +
    (1 - p_no_go) * (3 * N)

  data.frame(
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
# 2. CP cutoff interval corresponding to a d1 boundary
# ============================================================
#
# Futility is defined as CP < cF.
#
# To make the actual boundary exactly
#
#   d1 <= D,
#
# the nominal cutoff must satisfy
#
#   CP(D) < cF <= CP(D + 1).
#
# Under the design-alternative future assumption, CP depends only on
# the current Stage 1 event-count difference d1.

cp_value_at_difference <- function(
  cp_tab,
  n1,
  d
) {
  xP_values <- 0:n1
  xT_values <- xP_values - d

  keep <-
    xT_values >= 0 &
    xT_values <= n1

  vals <- cp_tab[
    cbind(
      xP_values[keep] + 1,
      xT_values[keep] + 1
    )
  ]

  # Under the current design-alternative CP construction these values
  # should be identical for a fixed d.
  if (max(vals) - min(vals) > 1e-12) {
    stop("CP is not constant for fixed d1 under the current setup.")
  }

  vals[1]
}


cp_cutoff_interval <- function(
  N,
  n1,
  d_boundary,
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

  lower <- cp_value_at_difference(
    cp_tab = cp_tab,
    n1 = n1,
    d = d_boundary
  )

  upper <- cp_value_at_difference(
    cp_tab = cp_tab,
    n1 = n1,
    d = d_boundary + 1
  )

  c(
    lower_exclusive = lower,
    upper_inclusive = upper
  )
}


# ============================================================
# 3. Frozen CRC assumptions and grid
# ============================================================

pP_crc <- 0.45
pT_crc <- 0.30

N_grid <- c(36, 40, 44, 48, 52)
f1_grid <- c(0.40, 0.50, 0.60)
d_grid <- c(-4, -3, -2)

scenarios <- list(
  null = c(pL = 0.45, pH = 0.45),
  weak_both5 = c(pL = 0.40, pH = 0.40),
  one_target15 = c(pL = 0.30, pH = 0.45),
  both_target15 = c(pL = 0.30, pH = 0.30)
)

# ============================================================
# 4. Exact timing x boundary evaluation
# ============================================================

out <- list()
idx <- 1L

for (N in N_grid) {
  for (f1 in f1_grid) {

    n1 <- floor(N * f1 + 0.5)

    for (D in d_grid) {

      cp_interval <- cp_cutoff_interval(
        N = N,
        n1 = n1,
        d_boundary = D,
        delta_go = 0.10,
        p_future_p = pP_crc,
        p_future_t = pT_crc
      )

      r_null <- exact_oc_by_d_boundary(
        pP = pP_crc,
        pL = scenarios$null["pL"],
        pH = scenarios$null["pH"],
        N = N,
        n1 = n1,
        d_boundary = D
      )

      r_weak <- exact_oc_by_d_boundary(
        pP = pP_crc,
        pL = scenarios$weak_both5["pL"],
        pH = scenarios$weak_both5["pH"],
        N = N,
        n1 = n1,
        d_boundary = D
      )

      r_one15 <- exact_oc_by_d_boundary(
        pP = pP_crc,
        pL = scenarios$one_target15["pL"],
        pH = scenarios$one_target15["pH"],
        N = N,
        n1 = n1,
        d_boundary = D
      )

      r_both15 <- exact_oc_by_d_boundary(
        pP = pP_crc,
        pL = scenarios$both_target15["pL"],
        pH = scenarios$both_target15["pH"],
        N = N,
        n1 = n1,
        d_boundary = D
      )

      out[[idx]] <- data.frame(
        N_per_arm = N,
        f1_target = f1,
        n1_nominal = n1,
        information_fraction_actual = n1 / N,
        d_boundary = D,
        CP_cutoff_lower_exclusive =
          cp_interval["lower_exclusive"],
        CP_cutoff_upper_inclusive =
          cp_interval["upper_inclusive"],
        P_NoGo_null =
          r_null$P_NoGo_S1,
        P_NoGo_weak_both5 =
          r_weak$P_NoGo_S1,
        P_Futility_target15 =
          r_one15$P_Futility_L,
        P_NoGo_one_target15 =
          r_one15$P_NoGo_S1,
        P_NoGo_both_target15 =
          r_both15$P_NoGo_S1,
        EN_A_null =
          r_null$EN_A_no_overrun,
        EN_B_null =
          r_null$EN_B_no_overrun,
        N_saved_A_vs_B_one_target15 =
          r_one15$N_saved_A_vs_B,
        ARR_halfwidth_95_target =
          arr_half_width_target(
            N = N,
            pP = 0.45,
            pT = 0.30
          )
      )

      idx <- idx + 1L
    }
  }
}

timing_boundary <- do.call(
  rbind,
  out
)

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  timing_boundary,
  "simulation/results/cp_crc_timing_boundary_screen_v0_9.csv",
  row.names = FALSE
)

# N=44 anchor view for easy review; N=44 is NOT fixed.
N44 <- subset(
  timing_boundary,
  N_per_arm == 44
)

write.csv(
  N44,
  "simulation/results/cp_crc_N44_timing_boundary_v0_9.csv",
  row.names = FALSE
)

# Matched d1 <= -3 across all N and timing choices.
matched_d3 <- subset(
  timing_boundary,
  d_boundary == -3
)

write.csv(
  matched_d3,
  "simulation/results/cp_crc_matched_dminus3_allN_v0_9.csv",
  row.names = FALSE
)

print(N44)
print(matched_d3)
