# ================================================================
# CIPN randomized Phase II - Cohort 1
# Robustness to true placebo incidence
# Version 1.5
# Date: 2026-09-25
#
# Working design:
#   N = 50 per arm
#   Stage 1 = 35% mature information -> n1 = 18 per arm
#   Project-level Go if max(CP_L, CP_H) >= 70%
#   No dose dropping
#   Final promising rule: max(observed RD_L, observed RD_H) >= 10%
#
# IMPORTANT:
# CP is always calculated using the DESIGN future-data assumptions
# qP = 0.45 and qT = 0.30.
#
# Robustness question:
# What happens if the TRUE placebo incidence differs from 45%?
#
# Primary pP range: 35%-55%
# Stress range:       30%-65%
# True absolute treatment effect: 0%, 5%, 10%, 15%, 20%.
#
# Two effect configurations:
#   one_effective: Low effect = 0, High effect = delta
#   both_effective: Low = High = delta
#
# Exact binomial calculations; no Monte Carlo.
# ================================================================

source("simulation/cp_futility_engine.R")

N <- 50
n1 <- 18
m <- N - n1

cp_cut <- 0.70
final_thr <- 0.10

# Design assumptions used INSIDE conditional power
qP <- 0.45
qT <- 0.30

pP_grid <- seq(0.30, 0.65, by = 0.05)
delta_grid <- c(0, 0.05, 0.10, 0.15, 0.20)

cp_lookup <- make_cp_lookup(
  nP = n1,
  nT = n1,
  NP = N,
  NT = N,
  delta_go = final_thr,
  qP = qP,
  qT = qT
)

cp_mat <- matrix(
  cp_lookup$cp,
  nrow = n1 + 1,
  ncol = n1 + 1
)

future_final_go_prob <- function(
  xp, xL, xH,
  pP, pL, pH
) {
  yP <- 0:m
  p_yP <- dbinom(yP, size = m, prob = pP)

  ans <- 0

  for (i in seq_along(yP)) {
    yp <- yP[i]
    final_xP <- xp + yp

    max_yL <- floor(
      final_xP - final_thr * N - xL + 1e-12
    )

    max_yH <- floor(
      final_xP - final_thr * N - xH + 1e-12
    )

    pL_success <- pbinom(
      max_yL,
      size = m,
      prob = pL
    )

    pH_success <- pbinom(
      max_yH,
      size = m,
      prob = pH
    )

    ans <- ans +
      p_yP[i] *
      (1 - (1 - pL_success) * (1 - pH_success))
  }

  ans
}

full_design_oc_exact <- function(
  pP, pL, pH
) {
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
              xp = xP,
              xL = xL,
              xH = xH,
              pP = pP,
              pL = pL,
              pH = pH
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
    P_Final_Go_without_IA = final_no_ia,
    Opportunity_loss_from_binding_IA =
      final_no_ia - p_stage1_go_final_go
  )
}

rows <- list()
k <- 1L

for (design_case in c("one_effective", "both_effective")) {
  for (pP in pP_grid) {
    for (delta in delta_grid) {

      if (design_case == "one_effective") {
        delta_L <- 0
        delta_H <- delta
      } else {
        delta_L <- delta
        delta_H <- delta
      }

      pL <- pP - delta_L
      pH <- pP - delta_H

      if (pL < 0 || pH < 0) next

      oc <- full_design_oc_exact(
        pP = pP,
        pL = pL,
        pH = pH
      )

      rows[[k]] <- cbind(
        data.frame(
          design_case = design_case,
          pP_true = pP,
          true_effect = delta,
          pL_true = pL,
          pH_true = pH
        ),
        oc
      )

      k <- k + 1L
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
  "simulation/results/N50_IA35_CP70_placebo_robustness_v1_5.csv",
  row.names = FALSE
)

print(out)
