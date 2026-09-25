# Budget-constrained accrual slowdown across N = 44, 48, 52 per arm

**Version:** 0.4  
**Date:** 25 September 2026  
**Status:** Working analytic operational screen; independent of CP cutoff.

## 1. Sample-size assumptions

The budget calculation is expanded to the three current maximum sample-size assumptions:

- 44 per arm: total N = 132;
- 48 per arm: total N = 144;
- 52 per arm: total N = 156.

The operational budget constraint remains:

\[
P(N_{IA} \ge \lceil0.70N\rceil) \le 0.05.
\]

Stage 1 per-arm sample sizes use the same nearest-integer convention as the existing CRC calibration code:

\[
n_{1,arm}=\lfloor N_{arm}f_1+0.5\rfloor.
\]

## 2. Exact thresholds

For each design, define:

\[
B=\lceil0.70N\rceil,
\qquad
k=B-N_1.
\]

During endpoint maturation:

\[
X\sim Poisson(r_{slow}L).
\]

The budget constraint is:

\[
P(X\ge k)\le0.05.
\]

Let \(\lambda_{0.05}(k)\) solve:

\[
P\{Poisson(\lambda)\ge k\}=0.05.
\]

Then the maximum allowed post-Stage-1 absolute recruitment rate is:

\[
\boxed{
r_{slow,max}=\frac{\lambda_{0.05}(k)}{L}
}
\]

and, relative to an ordinary recruitment rate \(r_0\),

\[
\boxed{
s_{max}=\min\left(1,\frac{r_{slow,max}}{r_0}\right).
}
\]

No CP cutoff enters this calculation.

## 3. Six-month endpoint maturity

| N/arm | Total N | Stage 1 target | n1/arm | Stage 1 total | 70% boundary | Max post-S1 rate/month |
|---:|---:|---:|---:|---:|---:|---:|
| 44 | 132 | 35% | 15 | 45 | 93 | 6.20 |
| 44 | 132 | 40% | 18 | 54 | 93 | 4.89 |
| 44 | 132 | 45% | 20 | 60 | 93 | 4.03 |
| 44 | 132 | 50% | 22 | 66 | 93 | 3.18 |
| 48 | 144 | 35% | 17 | 51 | 101 | 6.49 |
| 48 | 144 | 40% | 19 | 57 | 101 | 5.61 |
| 48 | 144 | 45% | 22 | 66 | 101 | 4.31 |
| 48 | 144 | 50% | 24 | 72 | 101 | 3.46 |
| 52 | 156 | 35% | 18 | 54 | 110 | 7.38 |
| 52 | 156 | 40% | 21 | 63 | 110 | 6.05 |
| 52 | 156 | 45% | 23 | 69 | 110 | 5.18 |
| 52 | 156 | 50% | 26 | 78 | 110 | 3.88 |

## 4. If ordinary recruitment is 6, 9, or 12/month

The table below gives the maximum fraction of ordinary recruitment that can be retained after Stage 1 while satisfying the 70% / 5% constraint at L = 6 months.

| N/arm | Stage 1 | r=6 | r=9 | r=12 |
|---:|---:|---:|---:|---:|
| 44 | 35% | 100% | 69% | 52% |
| 44 | 40% | 81% | 54% | 41% |
| 44 | 45% | 67% | 45% | 34% |
| 44 | 50% | 53% | 35% | 26% |
| 48 | 35% | 100% | 72% | 54% |
| 48 | 40% | 94% | 62% | 47% |
| 48 | 45% | 72% | 48% | 36% |
| 48 | 50% | 58% | 38% | 29% |
| 52 | 35% | 100% | 82% | 62% |
| 52 | 40% | 100% | 67% | 50% |
| 52 | 45% | 86% | 58% | 43% |
| 52 | 50% | 65% | 43% | 32% |

## 5. Main implication

The maximum total sample size materially affects operational feasibility.

At a 40% Stage 1 look with a six-month endpoint delay:

- N=44/arm permits about 4.89 participants/month after Stage 1;
- N=48/arm permits about 5.61/month;
- N=52/arm permits about 6.05/month.

Thus a larger maximum N creates more budget headroom before the 70% threshold is crossed.

However, the qualitative timing result is stable across all three N assumptions:

- 35-40% Stage 1 remains operationally manageable;
- 45% requires substantially stronger slowdown under fast accrual;
- 50% requires a strong slowdown across all three sample-size assumptions.

Therefore sample size must be included in the operational timing grid, but it does not remove the concern that a 50% mature-information interim is late for a delayed endpoint.

## 6. Design separation

This calculation should remain separate from CP calibration.

First screen:

\[
(N, f_1, L, r_0)
\rightarrow
r_{slow,max}
\]

using the 70% / 5% budget constraint.

Then, among operationally feasible Stage 1 designs, compare CP cutoffs and statistical operating characteristics.

## Reproducibility

R code:

`simulation/cp_accrual_budget_multiN_v0_4.R`

Results:

`simulation/results/cp_accrual_budget_multiN_v0_4.csv`
