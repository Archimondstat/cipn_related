# ================================================================
# CIPN randomized Phase II - Cohort 1
# Revised robustness: vary true placebo rate and treatment event rate
# Version 1.6
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
# Conditional power is always calculated using the DESIGN future-data
# assumptions qP = 0.45 and qT = 0.30.
#
# Revised robustness logic:
# Do NOT assume a fixed true risk difference when placebo incidence changes.
# Instead, treat the treatment-arm CTCAE >=2 CIPN event rate as its own
# scenario parameter.
#
# Primary scenario:
#   one ineffective dose tracks placebo;
#   one target-active dose has fixed true event rate pT = 0.30.
#
# 2D sensitivity:
#   pP = 0.35,0.40,0.45,0.50,0.55
#   pT = 0.25,0.30,0.35
#
# Exact binomial calculations; no Monte Carlo.
# ================================================================

source("simulation/cp_futility_engine.R")

N <- 50
n1 <- 18
m <- N - n1

cp_cut <- 0.70
final_thr <- 0.10

# Design assumptions used inside CP only
qP <- 0.45
qT <- 0.30

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

# ------------------------------------------------
# Primary revised robustness:
# one inactive dose tracks placebo,
# one active dose fixed at 30%
# ------------------------------------------------
primary_rows <- list()
k <- 1L

for (pP in seq(0.30, 0.65, by = 0.05)) {
  pL <- pP
  pH <- 0.30

  oc <- full_design_oc_exact(
    pP = pP,
    pL = pL,
    pH = pH
  )

  primary_rows[[k]] <- cbind(
    data.frame(
      pP_true = pP,
      pInactive_true = pL,
      pTargetDose_true = pH,
      implied_true_RD = pP - pH
    ),
    oc
  )

  k <- k + 1L
}

primary_out <- do.call(rbind, primary_rows)

# ------------------------------------------------
# 2D sensitivity:
# one inactive dose tracks placebo;
# active-dose event rate varies independently
# ------------------------------------------------
grid_rows <- list()
k <- 1L

for (pP in seq(0.35, 0.55, by = 0.05)) {
  for (pT in c(0.25, 0.30, 0.35)) {

    if (pT > pP) next

    oc <- full_design_oc_exact(
      pP = pP,
      pL = pP,
      pH = pT
    )

    grid_rows[[k]] <- cbind(
      data.frame(
        pP_true = pP,
        pTargetDose_true = pT,
        implied_true_RD = pP - pT
      ),
      oc
    )

    k <- k + 1L
  }
}

grid_out <- do.call(rbind, grid_rows)

dir.create(
  "simulation/results",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  primary_out,
  "simulation/results/N50_IA35_CP70_fixed_treatment_rate_v1_6.csv",
  row.names = FALSE
)

write.csv(
  grid_out,
  "simulation/results/N50_IA35_CP70_pP_pT_grid_v1_6.csv",
  row.names = FALSE
)

print(primary_out)
print(grid_out)
