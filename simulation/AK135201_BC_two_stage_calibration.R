# AK135-201 BC exploratory two-stage OC (2026-10-12)
# Run from repository root:
# Rscript simulation/AK135201_BC_two_stage_calibration.R
# Requires only base R and existing simulation/cp_futility_engine.R
# Historical assumptions: placebo 30%, AK135 20% or 15%
# docs/cp_two_stage_framework.md (2026-09-21).
# No BC sample size or CP cutoff has been finally approved.
# All outcomes determinate and nominally equal group sizes are assumed.

source("simulation/cp_futility_engine.R")

bc_final_only <- function(N, pP, pL, pH, delta = 0.10) {
  k <- ceiling(N * delta - 1e-12)
  xP <- 0:N
  a <- pbinom(xP - k, N, pL)
  b <- pbinom(xP - k, N, pH)
  sum(dbinom(xP, N, pP) * (1 - (1 - a) * (1 - b)))
}

bc_oc_exact <- function(N, n1, pP, pL, pH,
                        qP = 0.30, qT = 0.15,
                        delta = 0.10, cp_cutoff = 0.70) {
  stopifnot(n1 > 0L, n1 < N)
  m <- N - n1
  cp <- make_cp_lookup(
    nP = n1, nT = n1, NP = N, NT = N,
    delta_go = delta, qP = qP, qT = qT)
  cp_mat <- matrix(cp$cp, nrow = n1 + 1L, ncol = n1 + 1L)
  x <- 0:n1
  wP <- dbinom(x, n1, pP)
  wL <- dbinom(x, n1, pL)
  wH <- dbinom(x, n1, pH)
  wLH <- outer(wL, wH)
  pyP <- dbinom(0:m, m, pP)
  k <- ceiling(N * delta - 1e-12)
  stage_go <- 0
  stage_go_and_final_go <- 0

  for (xp in x) {
    dose_ok <- cp_mat[xp + 1L, ] >= cp_cutoff
    # Stage 1 Go if either dose CP meets the criterion.
    eligible <- outer(dose_ok, dose_ok, FUN = "|")
    w <- eligible * wLH
    if (sum(w) == 0) next
    stage_go <- stage_go + wP[xp + 1L] * sum(w)
    conditional_final <- 0
    for (yp in 0:m) {
      a <- pbinom(xp + yp - k - x, m, pL)
      b <- pbinom(xp + yp - k - x, m, pH)
      any_dose_final <- 1 - outer(1 - a, 1 - b)
      conditional_final <- conditional_final +
        pyP[yp + 1L] * sum(w * any_dose_final)
    }
    stage_go_and_final_go <- stage_go_and_final_go +
      wP[xp + 1L] * conditional_final
  }
  f <- bc_final_only(N, pP, pL, pH, delta)
  data.frame(P_Stage1_Go = stage_go,
             P_Stage1_Go_and_Final_Go = stage_go_and_final_go,
             P_Final_Go_without_binding_IA = f,
             Loss_due_to_binding_IA = f - stage_go_and_final_go)
}

scenario <- data.frame(
  name = c("null", "one_10pp", "one_15pp", "both_15pp"),
  pP = c(.30, .30, .30, .30),
  pL = c(.30, .30, .30, .15),
  pH = c(.30, .20, .15, .15))
future <- data.frame(
  label = c("q_30_to_15", "q_30_to_20"),
  qP = c(.30, .30), qT = c(.15, .20))
Ns <- c(30L, 33L, 36L, 40L, 45L, 50L, 60L)

out <- vector("list", length(Ns) * nrow(scenario) * nrow(future))
k <- 0L
for (j in seq_len(nrow(future))) {
  for (N in Ns) {
    n1 <- floor(.40 * N + .5)
    for (i in seq_len(nrow(scenario))) {
      q <- future[j, ]
      sc <- scenario[i, ]
      k <- k + 1L
      oc <- bc_oc_exact(N, n1, sc$pP, sc$pL, sc$pH,
                        qP = q$qP, qT = q$qT,
                        delta = .10, cp_cutoff = .70)
      out[[k]] <- cbind(data.frame(
        N_per_arm = N, Stage1_per_arm = n1,
        projection = q$label, scenario = sc$name,
        pP = sc$pP, pL = sc$pL, pH = sc$pH),
        oc)
    }
  }
}
ans <- do.call(rbind, out)
dir.create("simulation/results", recursive = TRUE, showWarnings = FALSE)
write.csv(ans, "simulation/results/AK135201_BC_exploratory_two_stage_OC.csv",
          row.names = FALSE)
print(subset(ans, projection == "q_30_to_15" &
                 scenario %in% c("null", "one_15pp") &
                 N_per_arm %in% c(30, 40, 50, 60)),
      row.names = FALSE)
cat("CAUTION: this OC does not simulate regimen stratification,\n",
    "unequal arm sizes, indeterminate EOT or different regimen risks.\n")
