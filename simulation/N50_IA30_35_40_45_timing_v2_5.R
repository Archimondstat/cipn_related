# ================================================================
# AK135 CIPN randomized Phase II - Cohort 1
# IA timing comparison: 30%, 35%, 40%, 45%
# Version 2.5
# Date: 2026-09-29
#
# Design constants:
#   Final N = 50 per arm; total N = 150
#   Stage 1 project rule: max(CP_L, CP_H) >= 0.70 -> Project Go
#   Final promising threshold: RD >= 0.10
#   CP projection assumptions: qP = 0.45, qT = 0.30
#
# IA fractions are mapped to nominal equal-allocation arm sizes using
# round-half-up:
#   30% -> 15/arm (45 total)
#   35% -> 18/arm (54 total)
#   40% -> 20/arm (60 total)
#   45% -> 23/arm (69 total; 46% realized per arm)
#
# The current comparison is for timing calibration only. It does not
# freeze the IA timing. Dose-level futility/drop-dose remains under
# discussion and is NOT included in the binding rule below.
# ================================================================

source("simulation/cp_futility_engine.R")

N <- 50
N_total <- 150
qP <- 0.45
qT <- 0.30
final_thr <- 0.10
cp_cut <- 0.70

round_half_up <- function(x) floor(x + 0.5)

timing_grid <- data.frame(
  IA_label = c("30%", "35%", "40%", "45%"),
  IA_fraction = c(0.30, 0.35, 0.40, 0.45)
)
timing_grid$n1_per_arm <- round_half_up(N * timing_grid$IA_fraction)
timing_grid$Stage1_total <- 3L * timing_grid$n1_per_arm

scenario_grid <- data.frame(
  Scenario = c("Null", "One promising", "One target", "Both target"),
  pP = c(0.45, 0.45, 0.45, 0.45),
  pL = c(0.45, 0.45, 0.45, 0.30),
  pH = c(0.45, 0.35, 0.30, 0.30)
)

cp_from_D <- function(n1, D) {
  if (D >= 0) {
    xp <- D
    xt <- 0
  } else {
    xp <- 0
    xt <- -D
  }

  cp_individual_exact(
    xp = xp, np = n1,
    xt = xt, nt = n1,
    NP = N, NT = N,
    delta_go = final_thr,
    qP = qP, qT = qT
  )
}

future_final_go_prob <- function(
  xp, xL, xH, n1,
  pP, pL, pH
) {
  m <- N - n1
  yP <- 0:m
  p_yP <- dbinom(yP, size = m, prob = pP)

  ans <- 0

  for (i in seq_along(yP)) {
    yp <- yP[i]

    max_yL <- floor(
      N * ((xp + yp) / N - final_thr) -
        xL + 1e-12
    )

    max_yH <- floor(
      N * ((xp + yp) / N - final_thr) -
        xH + 1e-12
    )

    pL_success <- pbinom(max_yL, size = m, prob = pL)
    pH_success <- pbinom(max_yH, size = m, prob = pH)

    ans <- ans +
      p_yP[i] *
      (1 - (1 - pL_success) * (1 - pH_success))
  }

  ans
}

full_design_oc_exact <- function(
  n1,
  pP, pL, pH
) {
  lookup <- make_cp_lookup(
    nP = n1,
    nT = n1,
    NP = N,
    NT = N,
    delta_go = final_thr,
    qP = qP,
    qT = qT
  )

  cp_mat <- matrix(
    lookup$cp,
    nrow = n1 + 1,
    ncol = n1 + 1
  )

  p_xP <- dbinom(0:n1, size = n1, prob = pP)
  p_xL <- dbinom(0:n1, size = n1, prob = pL)
  p_xH <- dbinom(0:n1, size = n1, prob = pH)

  p_stage1_go <- 0
  p_stage1_go_final_go <- 0

  for (xP in 0:n1) {
    for (xL in 0:n1) {
      for (xH in 0:n1) {
        pr <-
          p_xP[xP + 1] *
          p_xL[xL + 1] *
          p_xH[xH + 1]

        stage1_go <-
          cp_mat[xP + 1, xL + 1] >= cp_cut ||
          cp_mat[xP + 1, xH + 1] >= cp_cut

        if (stage1_go) {
          p_stage1_go <- p_stage1_go + pr

          p_stage1_go_final_go <-
            p_stage1_go_final_go +
            pr *
            future_final_go_prob(
              xp = xP, xL = xL, xH = xH,
              n1 = n1,
              pP = pP, pL = pL, pH = pH
            )
        }
      }
    }
  }

  final_no_ia <- final_classification_prob_exact(
    N = N,
    pP_true = pP,
    pL_true = pL,
    pH_true = pH,
    weak_effect_boundary = 0.05,
    promising_threshold = final_thr
  )$P_Go_leaning

  data.frame(
    P_Stage1_Go = p_stage1_go,
    P_Stage1_Go_and_Final_Go = p_stage1_go_final_go,
    P_Final_Go_without_binding_IA = final_no_ia,
    Final_Go_probability_lost_to_IA =
      final_no_ia - p_stage1_go_final_go
  )
}

# Operational model carried forward from the current design:
#   P(N_IA >= ceiling(0.70 * 150)) <= 0.05
#   endpoint maturation lag L = 6 months
#   ordinary accrual r0 = 9/month

budget_boundary <- ceiling(0.70 * N_total)
L <- 6
r0 <- 9

operational_metrics <- function(stage1_total) {
  k <- budget_boundary - stage1_total

  poisson_tail <- function(lambda) {
    ppois(k - 1L, lambda = lambda, lower.tail = FALSE)
  }

  lambda_max <- uniroot(
    function(lambda) poisson_tail(lambda) - 0.05,
    interval = c(0, 200)
  )$root

  max_rate <- lambda_max / L
  retained_fraction <- min(1, max_rate / r0)

  data.frame(
    Boundary_total_randomized = budget_boundary,
    Additional_randomized_to_boundary = k,
    Lambda_max = lambda_max,
    Max_post_Stage1_rate_per_month = max_rate,
    Retained_fraction_of_ordinary_accrual = retained_fraction,
    Approx_IA_decision_month = stage1_total / r0 + L,
    Approx_Go_calendar_penalty_months =
      L * max(0, 1 - retained_fraction)
  )
}

rows <- list()
k <- 1L

for (i in seq_len(nrow(timing_grid))) {
  tg <- timing_grid[i, ]
  n1 <- tg$n1_per_arm

  D_candidates <- (-n1):n1
  cp_candidates <- vapply(
    D_candidates,
    function(D) cp_from_D(n1, D),
    numeric(1)
  )

  min_D_go <- min(D_candidates[cp_candidates >= cp_cut])
  cp_at_boundary <- cp_from_D(n1, min_D_go)

  op <- operational_metrics(tg$Stage1_total)

  for (j in seq_len(nrow(scenario_grid))) {
    sc <- scenario_grid[j, ]

    oc <- full_design_oc_exact(
      n1 = n1,
      pP = sc$pP,
      pL = sc$pL,
      pH = sc$pH
    )

    expected_N_no_overrun <-
      tg$Stage1_total * (1 - oc$P_Stage1_Go) +
      N_total * oc$P_Stage1_Go

    rows[[k]] <- cbind(
      data.frame(
        IA_label = tg$IA_label,
        IA_fraction = tg$IA_fraction,
        n1_per_arm = n1,
        Stage1_total = tg$Stage1_total,
        CP_Go_threshold = cp_cut,
        Minimum_event_difference_for_individual_Go = min_D_go,
        Observed_RD_at_boundary = min_D_go / n1,
        CP_at_boundary = cp_at_boundary,
        Scenario = sc$Scenario,
        pP_true = sc$pP,
        pL_true = sc$pL,
        pH_true = sc$pH
      ),
      oc,
      data.frame(
        Expected_total_N_no_overrun = expected_N_no_overrun
      ),
      op
    )

    k <- k + 1L
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
  "simulation/results/N50_IA30_35_40_45_timing_v2_5.csv",
  row.names = FALSE
)

print(out)
