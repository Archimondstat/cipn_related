# CP design comparison v0.2
# Project: CIPN-related randomized Phase II design
# Date: 2026-09-21
#
# Compare two candidate Stage 1 conditional-power policies using the SAME
# simulated trial paths:
#
#   Design A = arm-wise futility + dose dropping
#   Design B = project-level futility only (no dose dropping)
#
# Both designs:
#   - start with Placebo / Low / High, equal allocation;
#   - use the same Stage 1 cohort;
#   - use the same CP calculation;
#   - trigger overall Stage 1 No-Go when BOTH active doses are futile;
#   - use the same provisional final Phase II Go rule.
#
# v0.2 deliberately excludes:
#   - accrual delay / overrun;
#   - safety override;
#   - earlier surrogate/intermediate endpoint;
#   - missing data.
#
# These will be added only after the statistical boundary is narrowed.

# ============================================================
# 0. Utilities
# ============================================================

binom_pmf <- function(n, p) {
  dbinom(0:n, size = n, prob = p)
}


# ============================================================
# 1. Provisional final Phase II Go rule
# ============================================================
#
# IMPORTANT:
# delta_go is a SENSITIVITY PARAMETER, not a frozen clinical threshold.
#
# Medical input currently suggests that an ARR of approximately 0-5%
# would likely have limited development value, but the medical team does
# not want a rigid single-value stopping rule.
#
# The final Go rule is therefore isolated here so that it can later be
# replaced (for example by ARR + confidence-bound evidence) without
# changing the CP engine.

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
# 2. Conditional-probability lookup tables
# ============================================================
#
# For every possible Stage 1 event-count pair (xP, xT), calculate:
#
#   P(final Go | Stage 1 data, future-data assumption)
#
# The endpoint is an unfavorable event:
#   CTCAE grade >=2 CIPN
#
# so benefit corresponds to p_P - p_T > 0.

cp_lookup_design <- function(
  n1,
  N,
  delta_go,
  p_future_p,
  p_future_t
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


cp_lookup_current <- function(
  n1,
  N,
  delta_go
) {
  stopifnot(n1 < N)

  m <- N - n1

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

    p_future_p <- xP / n1
    pmf_p <- binom_pmf(m, p_future_p)

    for (xT in 0:n1) {

      p_future_t <- xT / n1
      pmf_t <- binom_pmf(m, p_future_t)
      joint <- outer(pmf_p, pmf_t)

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


make_cp_lookup <- function(
  n1,
  N,
  delta_go,
  future_mode = c("design", "current"),
  p_future_p = NULL,
  p_future_t = NULL
) {
  future_mode <- match.arg(future_mode)

  if (future_mode == "design") {

    stopifnot(
      !is.null(p_future_p),
      !is.null(p_future_t)
    )

    return(
      cp_lookup_design(
        n1 = n1,
        N = N,
        delta_go = delta_go,
        p_future_p = p_future_p,
        p_future_t = p_future_t
      )
    )
  }

  cp_lookup_current(
    n1 = n1,
    N = N,
    delta_go = delta_go
  )
}


# ============================================================
# 3. Simulate BOTH policies on the same trial paths
# ============================================================

simulate_cp_policies <- function(
  pP,
  pL,
  pH,
  N = 44,
  n1 = 22,
  delta_go = 0.10,
  cF = 0.10,
  future_mode = c("design", "current"),
  p_future_p = 0.45,
  p_future_t = 0.30,
  nsim = 100000,
  seed = 20260921
) {
  future_mode <- match.arg(future_mode)

  set.seed(seed)

  cp_tab <- make_cp_lookup(
    n1 = n1,
    N = N,
    delta_go = delta_go,
    future_mode = future_mode,
    p_future_p = p_future_p,
    p_future_t = p_future_t
  )

  # ----------------------------------------------------------
  # Stage 1 data
  # ----------------------------------------------------------

  xP1 <- rbinom(nsim, n1, pP)
  xL1 <- rbinom(nsim, n1, pL)
  xH1 <- rbinom(nsim, n1, pH)

  cpL <- cp_tab[cbind(xP1 + 1, xL1 + 1)]
  cpH <- cp_tab[cbind(xP1 + 1, xH1 + 1)]

  futileL <- cpL < cF
  futileH <- cpH < cF

  overallNoGo <- futileL & futileH
  exactlyOneFutile <- xor(futileL, futileH)
  neitherFutile <- !futileL & !futileH

  # ----------------------------------------------------------
  # Potential Stage 2 outcomes
  #
  # Generate outcomes for all arms once. Design A simply ignores
  # Stage 2 data from a dose that would have been dropped.
  # This gives a clean common-random-number comparison.
  # ----------------------------------------------------------

  m <- N - n1

  yP <- rbinom(nsim, m, pP)
  yL <- rbinom(nsim, m, pL)
  yH <- rbinom(nsim, m, pH)

  finalGoL_potential <- is_final_go(
    xP_final = xP1 + yP,
    xT_final = xL1 + yL,
    NP = N,
    NT = N,
    delta_go = delta_go
  )

  finalGoH_potential <- is_final_go(
    xP_final = xP1 + yP,
    xT_final = xH1 + yH,
    NP = N,
    NT = N,
    delta_go = delta_go
  )

  # ==========================================================
  # Design A: arm-wise futility + dose dropping
  # ==========================================================

  dropL_A <- futileL
  dropH_A <- futileH

  finalGoL_A <-
    !overallNoGo &
    !dropL_A &
    finalGoL_potential

  finalGoH_A <-
    !overallNoGo &
    !dropH_A &
    finalGoH_potential

  finalProgramGo_A <- finalGoL_A | finalGoH_A

  totalN_A <- ifelse(
    overallNoGo,
    3 * n1,
    ifelse(
      exactlyOneFutile,
      3 * n1 + 2 * m,
      3 * N
    )
  )

  # ==========================================================
  # Design B: project-level futility only
  #
  # If only one dose has CP < cF, NO arm is dropped.
  # All three arms continue unless both are futile.
  # ==========================================================

  finalGoL_B <-
    !overallNoGo &
    finalGoL_potential

  finalGoH_B <-
    !overallNoGo &
    finalGoH_potential

  finalProgramGo_B <- finalGoL_B | finalGoH_B

  totalN_B <- ifelse(
    overallNoGo,
    3 * n1,
    3 * N
  )

  common <- list(
    pP = pP,
    pL = pL,
    pH = pH,
    N = N,
    n1 = n1,
    delta_go = delta_go,
    cF = cF,
    future_mode = future_mode,
    P_NoGo_S1 = mean(overallNoGo),
    P_L_FutilitySignal = mean(futileL),
    P_H_FutilitySignal = mean(futileH),
    P_ExactlyOneFutilitySignal = mean(exactlyOneFutile),
    Mean_CP_L = mean(cpL),
    Mean_CP_H = mean(cpH)
  )

  out_A <- data.frame(
    common,
    policy = "A_arm_drop",
    P_Drop_L = mean(dropL_A),
    P_Drop_H = mean(dropH_A),
    P_FinalGo_L = mean(finalGoL_A),
    P_FinalGo_H = mean(finalGoH_A),
    P_FinalProgramGo = mean(finalProgramGo_A),
    P_FinalProgramNoGo = mean(!finalProgramGo_A),
    EN_no_overrun = mean(totalN_A)
  )

  out_B <- data.frame(
    common,
    policy = "B_project_only",
    P_Drop_L = 0,
    P_Drop_H = 0,
    P_FinalGo_L = mean(finalGoL_B),
    P_FinalGo_H = mean(finalGoH_B),
    P_FinalProgramGo = mean(finalProgramGo_B),
    P_FinalProgramNoGo = mean(!finalProgramGo_B),
    EN_no_overrun = mean(totalN_B)
  )

  rbind(out_A, out_B)
}


# ============================================================
# 4. CRC base-case scenarios
# ============================================================
#
# Previous sample-size work:
#
#   placebo/control event rate = 45%
#   target active event rate   = 30% or 25%
#   target ARR                 = 15% or 20%
#
# N = 44/arm is retained as the initial working value from the
# prior precision-based sample-size calculation (~20% CI half-width).
#
# Weak 0-5% ARR is included because medical input suggests that
# this range would likely have limited development value.

scenarios_crc <- data.frame(
  scenario = c(
    "Null_0_0",
    "WeakBoth_5_5",
    "LowTarget15_HighNull",
    "LowNull_HighTarget15",
    "BothTarget15",
    "Low10_High15",
    "Low15_High20",
    "BothTarget20"
  ),
  pP = rep(0.45, 8),
  pL = c(
    0.45,
    0.40,
    0.30,
    0.45,
    0.30,
    0.35,
    0.30,
    0.25
  ),
  pH = c(
    0.45,
    0.40,
    0.45,
    0.30,
    0.30,
    0.30,
    0.25,
    0.25
  ),
  stringsAsFactors = FALSE
)


# ============================================================
# 5. First policy-comparison grid
# ============================================================
#
# First pass:
#   - design-alternative CP only;
#   - vary Stage 1 timing, final-Go ARR sensitivity, and CP cutoff.
#
# Current-trend CP is retained in the engine but not prioritized here
# because v0.1 showed materially higher false-futility behavior.

grid <- expand.grid(
  n1 = c(18, 22, 26),
  delta_go = c(0.05, 0.075, 0.10),
  cF = c(0.05, 0.10, 0.15, 0.20),
  scenario = scenarios_crc$scenario,
  stringsAsFactors = FALSE
)

results <- vector("list", nrow(grid))

for (i in seq_len(nrow(grid))) {

  g <- grid[i, ]

  s <- scenarios_crc[
    scenarios_crc$scenario == g$scenario,
  ]

  ans <- simulate_cp_policies(
    pP = s$pP,
    pL = s$pL,
    pH = s$pH,
    N = 44,
    n1 = g$n1,
    delta_go = g$delta_go,
    cF = g$cF,
    future_mode = "design",
    p_future_p = 0.45,
    p_future_t = 0.30,
    nsim = 100000,
    seed = 20260921 + i
  )

  ans$scenario <- g$scenario
  results[[i]] <- ans
}

results <- do.call(rbind, results)


# ============================================================
# 6. Save results
# ============================================================

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  results,
  "simulation/results/cp_policy_comparison_v0_2_full.csv",
  row.names = FALSE
)


# ============================================================
# 7. Compact first-look table
# ============================================================
#
# Provisional reference setting only:
#
#   n1       = 22/arm
#   delta_go = 10%
#   cF       = 10%
#
# These are NOT selected design parameters.

first_look <- subset(
  results,
  n1 == 22 &
    delta_go == 0.10 &
    cF == 0.10
)

write.csv(
  first_look,
  "simulation/results/cp_policy_comparison_v0_2_first_look.csv",
  row.names = FALSE
)

print(first_look)


# ============================================================
# 8. Direct A-vs-B contrast
# ============================================================

A <- subset(first_look, policy == "A_arm_drop")
B <- subset(first_look, policy == "B_project_only")

comparison <- merge(
  A,
  B,
  by = c(
    "scenario",
    "pP",
    "pL",
    "pH",
    "N",
    "n1",
    "delta_go",
    "cF",
    "future_mode"
  ),
  suffixes = c("_A", "_B")
)

comparison$FinalGo_gain_B_minus_A <-
  comparison$P_FinalProgramGo_B -
  comparison$P_FinalProgramGo_A

comparison$ExpectedN_saved_A_vs_B <-
  comparison$EN_no_overrun_B -
  comparison$EN_no_overrun_A

write.csv(
  comparison,
  "simulation/results/cp_policy_comparison_v0_2_A_vs_B.csv",
  row.names = FALSE
)

print(
  comparison[
    ,
    c(
      "scenario",
      "P_NoGo_S1_A",
      "P_ExactlyOneFutilitySignal_A",
      "P_FinalProgramGo_A",
      "P_FinalProgramGo_B",
      "FinalGo_gain_B_minus_A",
      "EN_no_overrun_A",
      "EN_no_overrun_B",
      "ExpectedN_saved_A_vs_B"
    )
  ]
)
