# Budget constraint for Stage 1 slowdown v0.3

**Date:** 25 September 2026  
**Status:** Working operational constraint; not yet a final protocol rule.

## 1. Proposed budget target

The operational target is now tightened from the previous 80% screen to:

\[
\boxed{
P(N_{IA} \ge 70\%\times N_{max}) \le 5\%
}
\]

With:

\[
N_{max}=132,
\]

70% corresponds to:

\[
0.70\times132=92.4.
\]

Therefore the exact integer event is:

\[
\boxed{N_{IA}\ge93}.
\]

This target is interpreted as a **budget / commitment constraint**: before the Stage 1 CP decision becomes available, the design should have no more than approximately a 5% chance of already committing at least 70% of the maximum randomized sample.

## 2. Consequence for the pipeline allowance

For a fixed Stage 1 cohort \(N_1\), the maximum permitted pipeline count before crossing 70% is determined by:

\[
N_1+X\ge93.
\]

Thus:

- 35% Stage 1: \(N_1=45\), crossing occurs at \(X\ge48\);
- 40% Stage 1: \(N_1=54\), crossing occurs at \(X\ge39\).

Under the homogeneous Poisson model:

\[
X\sim Poisson(s r_0L).
\]

The budget constraint becomes:

\[
P\{X\ge93-N_1\}\le0.05.
\]

Solving this exactly gives the maximum allowable expected pipeline mean:

- 35% Stage 1: \(\lambda_{max}\approx37.20\);
- 40% Stage 1: \(\lambda_{max}\approx29.33\).

Hence:

\[
s_{max}=\frac{\lambda_{max}}{r_0L}.
\]

## 3. Most relevant case: 6-month endpoint maturity

### Stage 1 = 35%

| Ordinary accrual | No slowdown | 75% rate | 50% rate | Least restrictive candidate meeting 5% |
|---:|---:|---:|---:|---:|
| 6/month | 3.2% | 0.02% | ~0% | 100% |
| 9/month | 81.1% | 13.7% | 0.02% | 50% |
| 12/month | 99.9% | 81.1% | 3.2% | 50% |

### Stage 1 = 40%

| Ordinary accrual | No slowdown | 75% rate | 50% rate | 25% rate | Least restrictive candidate meeting 5% |
|---:|---:|---:|---:|---:|---:|
| 6/month | 33.0% | 1.75% | ~0% | ~0% | 75% |
| 9/month | 98.6% | 61.4% | 1.75% | ~0% | 50% |
| 12/month | ~100% | 98.6% | 33.0% | ~0% | 25% |

## 4. Main implication

The 70% / 5% budget criterion materially changes the Stage 1 timing discussion.

Under a 6-month endpoint delay:

- with **35% Stage 1**, a 50% slowdown is enough even at 12/month;
- with **40% Stage 1**, 50% slowdown is enough at 9/month, but **not** at 12/month;
- at 12/month with 40% Stage 1, the discrete candidate grid requires slowing to 25%.

Therefore, if the project wishes to avoid near-pause behavior, the budget constraint itself creates pressure toward an earlier Stage 1 look.

This is a new argument in favor of comparing 35% versus 40% information jointly with slowdown.

## 5. Continuous slowdown threshold

The exact maximum slowdown multiplier satisfying the 5% budget target at L=6 months is:

| Stage 1 | 6/month | 9/month | 12/month |
|---:|---:|---:|---:|
| 35% | >=1.00 | 0.689 | 0.517 |
| 40% | 0.815 | 0.543 | 0.407 |

Interpretation:

- at 35% / 12-month accrual, approximately 52% of normal speed is the theoretical maximum, so the 50% candidate is almost exactly matched to the budget constraint;
- at 40% / 12-month accrual, the theoretical maximum is only about 41%, so a fixed 50% slowdown is insufficient.

## 6. Budget versus trial-duration interpretation

This target is not a statistical type-I-error constraint. It is an operational budget criterion.

Its role is to ensure that a Stage 1 No-Go decision remains financially meaningful.

A useful framing is:

\[
\boxed{
\text{Statistical trigger: mature Stage 1 endpoint data}
}
\]

\[
\boxed{
\text{Operational constraint: }P(N_{IA}\ge93)\le5\%
}
\]

The slowdown rate is then derived from the expected accrual rate and endpoint delay.

## 7. Working design rule for the next simulation

Rather than fixing slowdown at 50% in every scenario, the next simulation should use:

> the **least restrictive slowdown rate** that satisfies the 70% / 5% budget constraint.

This avoids unnecessary slowing when accrual is modest, while protecting the budget when accrual is fast.

The next comparison should prioritize:

- Stage 1 information: 35% vs 40%;
- endpoint maturity: 4, 5, 6 months;
- ordinary accrual: 6, 9, 12/month;
- slowdown determined by the 70% / 5% operational constraint;
- the currently calibrated CP cutoff candidates.

## Reproducibility

R code:

`simulation/cp_accrual_budget_constraint_v0_3.R`

Results:

`simulation/results/cp_accrual_budget_constraint_v0_3.csv`
