# CP Stage 1 simulation v0.1
# Project: CIPN-related randomized Phase II design
# Date: 2026-09-21
#
# Purpose:
#   Explore Stage 1 dose-level futility and overall No-Go operating
#   characteristics for a 3-arm Placebo / Low / High design.
#
# v0.1 intentionally isolates the statistical futility mechanism:
#   - no accrual-delay / overrun model yet;
#   - no safety override yet;
#   - equal final N per arm;
#   - provisional final-Go event: observed final ARR >= delta_go;
#   - exact conditional probability of final Go for each active dose.
#
# The final-Go threshold is treated as a sensitivity parameter, not a frozen
# clinical decision rule.

binom_pmf <- function(n, p) {
  k <- 0:n
  dbinom(k, size = n, prob = p)
}

cp_lookup_design <- function(n1, N, delta_go, p_future_p, p_future_t) {
  m <- N - n1
  threshold <- ceiling(N * delta_go - 1e-12)

  pmf_p <- binom_pmf(m, p_future_p)
  pmf_t <- binom_pmf(m, p_future_t)
  joint <- outer(pmf_p, pmf_t)

  out <- matrix(0, nrow = n1 + 1, ncol = n1 + 1,
                dimnames = list(xP = 0:n1, xT = 0:n1))

  for (xP in 0:n1) {
    for (xT in 0:n1) {
      prob <- 0
      for (yP in 0:m) {
        for (yT in 0:m) {
          if ((xP + yP) - (xT + yT) >= threshold) {
            prob <- prob + joint[yP + 1, yT + 1]
          }
        }
      }
      out[xP + 1, xT + 1] <- prob
    }
  }
  out
}

cp_lookup_current <- function(n1, N, delta_go) {
  m <- N - n1
  threshold <- ceiling(N * delta_go - 1e-12)

  out <- matrix(0, nrow = n1 + 1, ncol = n1 + 1,
                dimnames = list(xP = 0:n1, xT = 0:n1))

  for (xP in 0:n1) {
    p_future_p <- xP / n1
    pmf_p <- binom_pmf(m, p_future_p)

    for (xT in 0:n1) {
      p_future_t <- xT / n1
      pmf_t <- binom_pmf(m, p_future_t)
      joint <- outer(pmf_p, pmf_t)

      prob <- 0
      for (yP in 0:m) {
        for (yT in 0:m) {
          if ((xP + yP) - (xT + yT) >= threshold) {
            prob <- prob + joint[yP + 1, yT + 1]
          }
        }
      }
      out[xP + 1, xT + 1] <- prob
    }
  }
  out
}

simulate_cp_design <- function(
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

  if (future_mode == "design") {
    cp_tab <- cp_lookup_design(
      n1 = n1,
      N = N,
      delta_go = delta_go,
      p_future_p = p_future_p,
      p_future_t = p_future_t
    )
  } else {
    cp_tab <- cp_lookup_current(
      n1 = n1,
      N = N,
      delta_go = delta_go
    )
  }

  xP1 <- rbinom(nsim, n1, pP)
  xL1 <- rbinom(nsim, n1, pL)
  xH1 <- rbinom(nsim, n1, pH)

  cpL <- cp_tab[cbind(xP1 + 1, xL1 + 1)]
  cpH <- cp_tab[cbind(xP1 + 1, xH1 + 1)]

  dropL <- cpL < cF
  dropH <- cpH < cF
  noGo <- dropL & dropH
  oneDrop <- xor(dropL, dropH)
  bothContinue <- !dropL & !dropH

  m <- N - n1

  # Stage 2 outcomes for evaluating the provisional final-Go event.
  yP <- rbinom(nsim, m, pP)
  yL <- rbinom(nsim, m, pL)
  yH <- rbinom(nsim, m, pH)

  final_threshold <- ceiling(N * delta_go - 1e-12)

  finalGoL <- ((xP1 + yP) - (xL1 + yL) >= final_threshold) &
              !dropL & !noGo
  finalGoH <- ((xP1 + yP) - (xH1 + yH) >= final_threshold) &
              !dropH & !noGo

  finalProgramGo <- finalGoL | finalGoH

  # Sample size ignoring operational overrun:
  # - overall No-Go: stop after 3*n1;
  # - one arm dropped: placebo + remaining active finish to N;
  # - both active arms retained: 3*N.
  totalN <- ifelse(
    noGo,
    3 * n1,
    ifelse(oneDrop, 3 * n1 + 2 * m, 3 * N)
  )

  data.frame(
    pP = pP,
    pL = pL,
    pH = pH,
    N = N,
    n1 = n1,
    delta_go = delta_go,
    cF = cF,
    future_mode = future_mode,
    P_NoGo_S1 = mean(noGo),
    P_Drop_L = mean(dropL),
    P_Drop_H = mean(dropH),
    P_OneDoseDrop = mean(oneDrop),
    P_BothContinue = mean(bothContinue),
    P_FinalProgramGo = mean(finalProgramGo),
    EN_no_overrun = mean(totalN),
    Mean_CP_L = mean(cpL),
    Mean_CP_H = mean(cpH)
  )
}

# -------------------------------------------------------------------------
# CRC base case from previous sample-size work
# -------------------------------------------------------------------------
# Placebo/control event rate: 45%
# Target treatment event rate: 30%
# Target ARR: 15%
#
# N = 44/arm is the prior 1:1:1 candidate corresponding approximately to
# CI half-width 20% in the earlier precision-based sample-size table.
#
# The provisional final-Go threshold below (delta_go) is NOT a final medical
# decision. The medical team currently regards ~0-5% ARR as weak and prefers
# flexibility, so delta_go must be explored as a sensitivity parameter.

scenarios <- data.frame(
  scenario = c(
    "Null_0_0",
    "WeakBoth_5_5",
    "LowTarget_15_0",
    "HighTarget_0_15",
    "BothTarget_15_15",
    "Mixed_10_15"
  ),
  pP = rep(0.45, 6),
  pL = c(0.45, 0.40, 0.30, 0.45, 0.30, 0.35),
  pH = c(0.45, 0.40, 0.45, 0.30, 0.30, 0.30)
)

grid <- expand.grid(
  n1 = c(18, 22, 26),
  delta_go = c(0.05, 0.075, 0.10),
  cF = c(0.05, 0.10, 0.15, 0.20),
  future_mode = c("design", "current"),
  scenario = scenarios$scenario,
  stringsAsFactors = FALSE
)

results <- vector("list", nrow(grid))

for (i in seq_len(nrow(grid))) {
  g <- grid[i, ]
  s <- scenarios[scenarios$scenario == g$scenario, ]

  ans <- simulate_cp_design(
    pP = s$pP,
    pL = s$pL,
    pH = s$pH,
    N = 44,
    n1 = g$n1,
    delta_go = g$delta_go,
    cF = g$cF,
    future_mode = g$future_mode,
    p_future_p = 0.45,
    p_future_t = 0.30,
    nsim = 100000,
    seed = 20260921 + i
  )

  ans$scenario <- g$scenario
  results[[i]] <- ans
}

results <- do.call(rbind, results)

dir.create("simulation/results", recursive = TRUE, showWarnings = FALSE)
write.csv(
  results,
  "simulation/results/cp_stage1_v0_1_full.csv",
  row.names = FALSE
)

# A compact first-look subset
first_look <- subset(
  results,
  n1 == 22 & delta_go == 0.10 & cF == 0.10
)

write.csv(
  first_look,
  "simulation/results/cp_stage1_v0_1_first_look.csv",
  row.names = FALSE
)

print(first_look)
