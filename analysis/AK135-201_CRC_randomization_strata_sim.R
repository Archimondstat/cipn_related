# AK135-201 CRC cohort: randomization stratification comparison
# Exploratory simulation only; not a finalized IWRS specification.
# Base R, no additional packages required.
# Cohort: 150 participants; 3 arms, 1:1:1; Stage 1 review at 60 randomized.
# Demographic probabilities below are illustrative, NOT protocol assumptions.

args <- commandArgs(trailingOnly = TRUE)
B <- if (length(args) >= 1L) as.integer(args[[1L]]) else 10000L
if (is.na(B) || B < 1L) stop("B must be a positive integer")
set.seed(20261012)

N <- 150L
looks <- c(60L, 150L)
prob_female <- 0.45
prob_age65_plus <- 0.30
block_sizes <- c(6L)             # primary scenario: balanced six-person blocks
# To examine a masked variable-block scenario, use c(3L, 6L).

# Each completed block contains equal allocations across all three arms.
draw_sequence <- function(n, sizes) {
  allocations <- integer(0L)
  while (length(allocations) < n) {
    b <- sizes[[sample.int(length(sizes), size = 1L)]]
    if ((b %% 3L) != 0L) stop("All block sizes must be divisible by 3")
    allocations <- c(allocations, sample(rep(1:3, each = b / 3L)))
  }
  allocations[seq_len(n)]
}

# Separate balanced randomization sequence for each prespecified stratum.
stratified_alloc <- function(factor, sizes) {
  out <- integer(length(factor))
  for (stratum in 0:1) {
    ids <- which(factor == stratum)  # preserves accrual order within stratum
    if (length(ids)) out[ids] <- draw_sequence(length(ids), sizes)
  }
  out
}

calc_metrics <- function(arms, female, age65, at_n) {
  arms <- arms[seq_len(at_n)]
  female <- female[seq_len(at_n)]
  age65 <- age65[seq_len(at_n)]
  arm_n <- tabulate(arms, nbins = 3L)
  female_n <- vapply(1:3, function(a) sum(female[arms == a] == 1L), numeric(1))
  age65_n <- vapply(1:3, function(a) sum(age65[arms == a] == 1L), numeric(1))
  c(
    arm_n_range = max(arm_n) - min(arm_n),
    female_percentage_point_range = 100 * diff(range(female_n / arm_n)),
    age65_percentage_point_range = 100 * diff(range(age65_n / arm_n))
  )
}

methods <- c("none", "sex", "age65")
result <- array(
  NA_real_, dim = c(B, length(looks), length(methods), 3L),
  dimnames = list(NULL, as.character(looks), methods,
                  c("arm_n_range", "female_pp_range", "age65_pp_range"))
)

for (b in seq_len(B)) {
  female <- rbinom(N, size = 1, prob = prob_female)
  age65 <- rbinom(N, size = 1, prob = prob_age65_plus)
  assignments <- list(
    none = draw_sequence(N, block_sizes),
    sex = stratified_alloc(female, block_sizes),
    age65 = stratified_alloc(age65, block_sizes)
  )
  for (j in seq_along(looks)) {
    for (m in seq_along(methods)) {
      result[b, j, m, ] <- calc_metrics(
        assignments[[methods[[m]]]], female, age65, looks[[j]]
      )
    }
  }
}

summaries <- list()
for (j in seq_along(looks)) {
  for (m in seq_along(methods)) {
    x <- result[, j, m, , drop = FALSE]
    x <- matrix(x, ncol = 3L)
    summaries[[length(summaries) + 1L]] <- data.frame(
      randomized_n = looks[[j]],
      strategy = methods[[m]],
      mean_arm_n_range = mean(x[, 1L]),
      median_female_pp_range = median(x[, 2L]),
      median_age65_pp_range = median(x[, 3L]),
      p_arm_n_range_ge_3 = mean(x[, 1L] >= 3L),
      p_female_pp_range_ge_10 = mean(x[, 2L] >= 10),
      p_age65_pp_range_ge_10 = mean(x[, 3L] >= 10)
    )
  }
}
ans <- do.call(rbind, summaries)
num <- vapply(ans, is.numeric, logical(1))
ans[num] <- lapply(ans[num], round, digits = 3L)
cat("Simulations:", B, "\nBlock sizes:", paste(block_sizes, collapse = ","),
    "\nFemale:", prob_female, "\nAge >=65:", prob_age65_plus, "\n\n")
print(ans, row.names = FALSE)
cat("\nInterpretation: a smaller max-minus-min percentage-point range means\n",
    "better balance of that PRE-RANDOMIZATION characteristic.\n",
    "The exact 20/20/20 at Stage 1 for 'none' occurs only for\n",
    "fixed block size 6 and the first 60 RANDOMIZED participants,\n",
    "not necessarily for 60 endpoint-evaluable participants.\n", sep = "")
