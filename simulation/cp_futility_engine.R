# ================================================================
# CIPN randomized Phase II
# Conditional-power engine and calibration utilities
# Version 1.1
# Date: 2026-09-22
#
# Endpoint:
#   Y = 1 if CTCAE grade >=2 CIPN (unfavorable event)
#
# Unified treatment-effect definition:
#   Delta = p_placebo - p_treatment
#   Positive Delta favors treatment.
#
# Current CRC design assumptions:
#   p_placebo = 0.45
#   p_treatment = 0.30
#   target treatment effect = 0.15
#   weak-effect boundary    = 0.05
#   promising threshold     = 0.10
#
# Phase II efficacy classification (program level):
#   max observed effect < 0.05          : No-Go leaning
#   0.05 <= max observed effect < 0.10  : Consider
#   max observed effect >= 0.10         : Go leaning
#
# IMPORTANT:
#   CP is used as NON-BINDING decision support.
#   The reference treatment-effect values generated below are calibration
#   values, not automatic stopping boundaries.
#
# This file contains:
#   1) exact individual CP using actual interim sample sizes;
#   2) exact joint CP for Low/High sharing one placebo arm;
#   3) lookup-table construction for efficient simulation;
#   4) exact VITALITY-style calibration tables for equal nominal n;
#   5) optional Monte Carlo validation.
#
# No external R packages are required.
# ================================================================


# ----------------------------------------------------------------
# 0. Basic validation
# ----------------------------------------------------------------

.check_count <- function(x, n, name = "x") {
  if (length(x) != 1L || length(n) != 1L ||
      x < 0 || n < 0 || x > n ||
      abs(x - round(x)) > 1e-12 ||
      abs(n - round(n)) > 1e-12) {
    stop(sprintf("%s must be an integer count between 0 and n.", name))
  }
}

.check_prob <- function(p, name = "p") {
  if (length(p) != 1L || is.na(p) || p < 0 || p > 1) {
    stop(sprintf("%s must be in [0, 1].", name))
  }
}


# ----------------------------------------------------------------
# 1. Observed treatment effect
# ----------------------------------------------------------------
#
# Treatment effect = placebo event rate - treatment event rate.
#
# Positive value = fewer CTCAE >=2 CIPN events in treatment.

observed_treatment_effect <- function(
  x_placebo,
  n_placebo,
  x_treatment,
  n_treatment
) {
  .check_count(x_placebo, n_placebo, "x_placebo")
  .check_count(x_treatment, n_treatment, "x_treatment")

  x_placebo / n_placebo -
    x_treatment / n_treatment
}


# ----------------------------------------------------------------
# 2. Final Phase II promising event used inside CP
# ----------------------------------------------------------------
#
# Prespecified Phase II promising criterion for CP:
#
#   final observed treatment effect >= 0.10
#
# The 10% threshold is the PROMISING THRESHOLD, not the assumed true
# treatment effect. The CRC target treatment effect remains 15%.
#
# Parameter name delta_go is retained for backward compatibility with
# earlier project scripts; operationally it means promising_threshold.

is_final_go <- function(
  x_placebo_final,
  n_placebo_final,
  x_treatment_final,
  n_treatment_final,
  delta_go = 0.10
) {
  observed_treatment_effect(
    x_placebo = x_placebo_final,
    n_placebo = n_placebo_final,
    x_treatment = x_treatment_final,
    n_treatment = n_treatment_final
  ) >= delta_go
}


# Preferred explicit alias.
is_final_promising <- is_final_go


# ----------------------------------------------------------------
# 2a. Final Phase II efficacy classification
# ----------------------------------------------------------------
#
# Program-level classification uses the better observed treatment effect
# across Low and High:
#
#   delta_max = max(delta_L, delta_H)
#
#   delta_max < 5%          -> No-Go leaning
#   5% <= delta_max < 10%   -> Consider
#   delta_max >= 10%        -> Go leaning
#
# These are efficacy classifications, not automatic development decisions.

classify_phase2_efficacy <- function(
  delta_low,
  delta_high,
  weak_effect_boundary = 0.05,
  promising_threshold = 0.10
) {
  delta_max <- max(delta_low, delta_high)

  if (delta_max < weak_effect_boundary) {
    return("No-Go leaning")
  }

  if (delta_max < promising_threshold) {
    return("Consider")
  }

  "Go leaning"
}


# ----------------------------------------------------------------
# 2b. Exact final efficacy-classification probabilities
# ----------------------------------------------------------------
#
# Equal final N per arm is used for the current design grid.
# Shared placebo is handled exactly by conditioning on X_P.
#
# IMPORTANT:
# Because the Stage 1 review is non-binding and no mechanical interim
# stop rule has been specified, these FINAL classification probabilities
# depend on final N and true event rates, but NOT on Stage 1 information
# fraction. A full design OC that includes early termination would require
# an explicit operational decision rule.

final_classification_prob_exact <- function(
  N,
  pP_true,
  pL_true,
  pH_true,
  weak_effect_boundary = 0.05,
  promising_threshold = 0.10
) {
  .check_prob(pP_true, "pP_true")
  .check_prob(pL_true, "pL_true")
  .check_prob(pH_true, "pH_true")

  x <- 0:N
  pP <- dbinom(x, size = N, prob = pP_true)
  pL <- dbinom(x, size = N, prob = pL_true)
  pH <- dbinom(x, size = N, prob = pH_true)

  p_nogo <- 0
  p_consider <- 0
  p_go <- 0

  for (xP in x) {
    for (xL in x) {
      delta_L <- (xP - xL) / N

      for (xH in x) {
        delta_H <- (xP - xH) / N
        pr <- pP[xP + 1] * pL[xL + 1] * pH[xH + 1]

        cls <- classify_phase2_efficacy(
          delta_low = delta_L,
          delta_high = delta_H,
          weak_effect_boundary = weak_effect_boundary,
          promising_threshold = promising_threshold
        )

        if (cls == "No-Go leaning") {
          p_nogo <- p_nogo + pr
        } else if (cls == "Consider") {
          p_consider <- p_consider + pr
        } else {
          p_go <- p_go + pr
        }
      }
    }
  }

  data.frame(
    N_per_arm = N,
    pP_true = pP_true,
    pL_true = pL_true,
    pH_true = pH_true,
    true_effect_low = pP_true - pL_true,
    true_effect_high = pP_true - pH_true,
    P_NoGo_leaning = p_nogo,
    P_Consider = p_consider,
    P_Go_leaning = p_go
  )
}


make_final_classification_grid <- function(
  N_grid = c(36, 40, 44, 48, 52),
  true_effect_grid = c(0, 0.05, 0.10, 0.15, 0.20),
  pP_true = 0.45,
  weak_effect_boundary = 0.05,
  promising_threshold = 0.10
) {
  rows <- list()
  k <- 1L

  for (N in N_grid) {
    for (delta_true in true_effect_grid) {
      pT_true <- pP_true - delta_true

      rows[[k]] <- final_classification_prob_exact(
        N = N,
        pP_true = pP_true,
        pL_true = pT_true,
        pH_true = pT_true,
        weak_effect_boundary = weak_effect_boundary,
        promising_threshold = promising_threshold
      )

      k <- k + 1L
    }
  }

  do.call(rbind, rows)
}


# ----------------------------------------------------------------
# 3. Exact individual conditional power
# ----------------------------------------------------------------
#
# Inputs:
#   xp, np : observed placebo events and mature placebo n at interim
#   xt, nt : observed treatment events and mature treatment n at interim
#   NP, NT : planned final evaluable sample sizes
#   qP, qT : future-data event-rate assumptions
#
# Future counts:
#   YP ~ Bin(NP - np, qP)
#   YT ~ Bin(NT - nt, qT)
#
# CP = P(final treatment effect reaches the Phase II promising threshold
#        | interim data, future-data assumption)

cp_individual_exact <- function(
  xp,
  np,
  xt,
  nt,
  NP,
  NT,
  delta_go = 0.10,
  qP = 0.45,
  qT = 0.30
) {
  .check_count(xp, np, "xp")
  .check_count(xt, nt, "xt")
  .check_prob(qP, "qP")
  .check_prob(qT, "qT")

  if (NP < np || NT < nt) {
    stop("Final planned sample size must be >= mature interim sample size.")
  }

  mP <- NP - np
  mT <- NT - nt

  yP <- 0:mP
  p_yP <- dbinom(yP, size = mP, prob = qP)

  # Final success:
  #
  #   (xp + yP)/NP - (xt + yT)/NT >= delta_go
  #
  # Therefore:
  #
  #   yT <= NT * ((xp + yP)/NP - delta_go) - xt
  #
  # Because yT is integer, use floor().

  max_yT <- floor(
    NT * ((xp + yP) / NP - delta_go) -
      xt +
      1e-12
  )

  p_treatment_success <- pbinom(
    q = max_yT,
    size = mT,
    prob = qT
  )

  sum(p_yP * p_treatment_success)
}


# ----------------------------------------------------------------
# 4. Exact joint conditional power for Low + High vs shared placebo
# ----------------------------------------------------------------
#
# Joint CP is defined here as:
#
#   P(at least one active dose reaches the final promising event
#     | actual interim data, future-data assumptions)
#
# The two active arms share the same future placebo count YP.
# Conditional on YP, future Low and High counts are independent.

cp_joint_exact <- function(
  xp,
  np,
  xL,
  nL,
  xH,
  nH,
  NP,
  NL,
  NH,
  delta_go = 0.10,
  qP = 0.45,
  qL = 0.30,
  qH = 0.30
) {
  .check_count(xp, np, "xp")
  .check_count(xL, nL, "xL")
  .check_count(xH, nH, "xH")

  .check_prob(qP, "qP")
  .check_prob(qL, "qL")
  .check_prob(qH, "qH")

  if (NP < np || NL < nL || NH < nH) {
    stop("Final planned sample size must be >= mature interim sample size.")
  }

  mP <- NP - np
  mL <- NL - nL
  mH <- NH - nH

  yP <- 0:mP
  p_yP <- dbinom(yP, size = mP, prob = qP)

  max_yL <- floor(
    NL * ((xp + yP) / NP - delta_go) -
      xL +
      1e-12
  )

  max_yH <- floor(
    NH * ((xp + yP) / NP - delta_go) -
      xH +
      1e-12
  )

  pL_success <- pbinom(
    q = max_yL,
    size = mL,
    prob = qL
  )

  pH_success <- pbinom(
    q = max_yH,
    size = mH,
    prob = qH
  )

  p_any_success_given_yP <-
    1 - (1 - pL_success) * (1 - pH_success)

  sum(
    p_yP *
      p_any_success_given_yP
  )
}


# ----------------------------------------------------------------
# 5. CP lookup table for efficient Monte Carlo simulation
# ----------------------------------------------------------------
#
# This supports unequal mature interim n and unequal final N.
# A separate lookup can be built for Low and High if needed.

make_cp_lookup <- function(
  nP,
  nT,
  NP,
  NT,
  delta_go = 0.10,
  qP = 0.45,
  qT = 0.30
) {
  out <- expand.grid(
    xp = 0:nP,
    xt = 0:nT,
    KEEP.OUT.ATTRS = FALSE
  )

  out$cp <- mapply(
    FUN = cp_individual_exact,
    xp = out$xp,
    xt = out$xt,
    MoreArgs = list(
      np = nP,
      nt = nT,
      NP = NP,
      NT = NT,
      delta_go = delta_go,
      qP = qP,
      qT = qT
    )
  )

  out
}


# ----------------------------------------------------------------
# 6. Exact probability that BOTH active doses fall at or below a
#    displayed interim reference treatment effect
# ----------------------------------------------------------------
#
# Equal nominal Stage 1 n is used only for the design-calibration table.
#
# Let:
#   D = xP - xT
#
# and display:
#   reference treatment effect = D / n1.
#
# "Both doses meet the reference region" means:
#   xP - xL <= D  AND  xP - xH <= D.
#
# This is a calibration probability, NOT automatically P(stop).

prob_both_below_reference_equal_n <- function(
  D,
  n1,
  pP_true,
  pL_true,
  pH_true
) {
  .check_prob(pP_true, "pP_true")
  .check_prob(pL_true, "pL_true")
  .check_prob(pH_true, "pH_true")

  p_xP <- dbinom(
    0:n1,
    size = n1,
    prob = pP_true
  )

  ans <- 0

  for (xP in 0:n1) {

    # xP - xT <= D
    # <=> xT >= xP - D

    min_xT <- xP - D

    pL_region <- 1 - pbinom(
      q = min_xT - 1,
      size = n1,
      prob = pL_true
    )

    pH_region <- 1 - pbinom(
      q = min_xT - 1,
      size = n1,
      prob = pH_true
    )

    ans <-
      ans +
      p_xP[xP + 1] *
      pL_region *
      pH_region
  }

  ans
}


# ----------------------------------------------------------------
# 7. VITALITY-style calibration table
# ----------------------------------------------------------------
#
# The displayed reference treatment-effect values are rounded to the
# nearest attainable event-count difference for equal nominal n.
#
# Default displayed values:
#   approximately -5%, 0%, +5%, +10%
#
# Columns:
#   - reference observed treatment effect;
#   - event-count difference xP-xT;
#   - individual CP;
#   - joint CP;
#   - probability both doses fall in the reference region if true
#     effect = 0%, 5%, or 15%;
#   - probability at least one dose ultimately reaches selected final
#     observed-effect thresholds (15%, 10%, 5%) under the future assumption.
#
# Here 10% is the prespecified Phase II promising threshold; 5% is the
# weak-effect boundary; 15% is the target treatment effect.

make_reference_table <- function(
  N = 44,
  f1 = 0.50,
  reference_effects = c(-0.05, 0, 0.05, 0.10),
  delta_go = 0.10,
  qP = 0.45,
  qT = 0.30
) {
  n1 <- floor(N * f1 + 0.5)

  D_values <- unique(
    round(
      reference_effects * n1
    )
  )

  rows <- vector(
    "list",
    length(D_values)
  )

  for (i in seq_along(D_values)) {

    D <- D_values[i]

    # Any valid interim count pair with difference D gives the same
    # individual CP under equal n, equal final N, and fixed qP/qT.
    if (D >= 0) {
      xp0 <- D
      xt0 <- 0
    } else {
      xp0 <- 0
      xt0 <- -D
    }

    cp_ind <- cp_individual_exact(
      xp = xp0,
      np = n1,
      xt = xt0,
      nt = n1,
      NP = N,
      NT = N,
      delta_go = delta_go,
      qP = qP,
      qT = qT
    )

    cp_joint <- cp_joint_exact(
      xp = xp0,
      np = n1,
      xL = xt0,
      nL = n1,
      xH = xt0,
      nH = n1,
      NP = N,
      NL = N,
      NH = N,
      delta_go = delta_go,
      qP = qP,
      qL = qT,
      qH = qT
    )

    p_ref_true0 <-
      prob_both_below_reference_equal_n(
        D = D,
        n1 = n1,
        pP_true = 0.45,
        pL_true = 0.45,
        pH_true = 0.45
      )

    p_ref_true5 <-
      prob_both_below_reference_equal_n(
        D = D,
        n1 = n1,
        pP_true = 0.45,
        pL_true = 0.40,
        pH_true = 0.40
      )

    p_ref_true15 <-
      prob_both_below_reference_equal_n(
        D = D,
        n1 = n1,
        pP_true = 0.45,
        pL_true = 0.30,
        pH_true = 0.30
      )

    # Conditional probability of at least one final dose showing
    # selected observed treatment effects.
    p_final15 <- cp_joint_exact(
      xp = xp0,
      np = n1,
      xL = xt0,
      nL = n1,
      xH = xt0,
      nH = n1,
      NP = N,
      NL = N,
      NH = N,
      delta_go = 0.15,
      qP = qP,
      qL = qT,
      qH = qT
    )

    p_final10 <- cp_joint

    p_final05 <- cp_joint_exact(
      xp = xp0,
      np = n1,
      xL = xt0,
      nL = n1,
      xH = xt0,
      nH = n1,
      NP = N,
      NL = N,
      NH = N,
      delta_go = 0.05,
      qP = qP,
      qL = qT,
      qH = qT
    )

    rows[[i]] <- data.frame(
      N_per_arm = N,
      Stage1_target_fraction = f1,
      n1_nominal = n1,
      Event_count_difference_xP_minus_xT = D,
      Reference_observed_treatment_effect =
        D / n1,
      Individual_CP = cp_ind,
      Joint_CP = cp_joint,
      P_both_below_reference_true_effect_0 =
        p_ref_true0,
      P_both_below_reference_true_effect_5 =
        p_ref_true5,
      P_both_below_reference_true_effect_15 =
        p_ref_true15,
      P_any_final_effect_ge_15 =
        p_final15,
      P_any_final_effect_ge_10 =
        p_final10,
      P_any_final_effect_ge_05 =
        p_final05
    )
  }

  do.call(
    rbind,
    rows
  )
}


# ----------------------------------------------------------------
# 8. Optional Monte Carlo validation using fixed actual mature n
# ----------------------------------------------------------------
#
# This simulation does NOT apply an automatic Go/No-Go decision.
# It returns the distribution of observed effects and CP values.
#
# To evaluate a displayed reference region, set reference_effect to a
# value such as 0, 0.05, or 0.10.

simulate_interim_cp <- function(
  nsim = 100000,
  pP_true = 0.45,
  pL_true = 0.30,
  pH_true = 0.30,
  nP = 22,
  nL = 22,
  nH = 22,
  NP = 44,
  NL = 44,
  NH = 44,
  delta_go = 0.10,
  qP = 0.45,
  qL = 0.30,
  qH = 0.30,
  reference_effect = NULL,
  seed = 20260921
) {
  set.seed(seed)

  lookup_L <- make_cp_lookup(
    nP = nP,
    nT = nL,
    NP = NP,
    NT = NL,
    delta_go = delta_go,
    qP = qP,
    qT = qL
  )

  lookup_H <- make_cp_lookup(
    nP = nP,
    nT = nH,
    NP = NP,
    NT = NH,
    delta_go = delta_go,
    qP = qP,
    qT = qH
  )

  cp_mat_L <- matrix(
    lookup_L$cp,
    nrow = nP + 1,
    ncol = nL + 1
  )

  cp_mat_H <- matrix(
    lookup_H$cp,
    nrow = nP + 1,
    ncol = nH + 1
  )

  xP <- rbinom(
    nsim,
    size = nP,
    prob = pP_true
  )

  xL <- rbinom(
    nsim,
    size = nL,
    prob = pL_true
  )

  xH <- rbinom(
    nsim,
    size = nH,
    prob = pH_true
  )

  effect_L <-
    xP / nP -
    xL / nL

  effect_H <-
    xP / nP -
    xH / nH

  cpL <- cp_mat_L[
    cbind(
      xP + 1,
      xL + 1
    )
  ]

  cpH <- cp_mat_H[
    cbind(
      xP + 1,
      xH + 1
    )
  ]

  out <- data.frame(
    sim = seq_len(nsim),
    xP = xP,
    xL = xL,
    xH = xH,
    effect_L = effect_L,
    effect_H = effect_H,
    cpL = cpL,
    cpH = cpH
  )

  if (!is.null(reference_effect)) {
    out$both_below_reference <-
      effect_L <= reference_effect &
      effect_H <= reference_effect
  }

  out
}


# ----------------------------------------------------------------
# 9. Reproduce the current N=44 reference tables and final F-framework OCs
# ----------------------------------------------------------------

if (sys.nframe() == 0L) {

  dir.create(
    "simulation/results",
    recursive = TRUE,
    showWarnings = FALSE
  )

  all_reference <- do.call(
    rbind,
    lapply(
      c(0.40, 0.50, 0.60),
      function(f1) {
        make_reference_table(
          N = 44,
          f1 = f1
        )
      }
    )
  )

  write.csv(
    all_reference,
    "simulation/results/cp_reference_table_R_v1_0.csv",
    row.names = FALSE
  )

  print(all_reference)

  final_classification_grid <- make_final_classification_grid()

  write.csv(
    final_classification_grid,
    "simulation/results/cp_final_classification_grid_R_v1_1.csv",
    row.names = FALSE
  )

  print(final_classification_grid)

  # Example using actual unequal mature sample sizes:
  #
  # cp_individual_exact(
  #   xp = 10, np = 23,
  #   xt = 8,  nt = 21,
  #   NP = 44, NT = 44,
  #   delta_go = 0.10,
  #   qP = 0.45, qT = 0.30
  # )
}
