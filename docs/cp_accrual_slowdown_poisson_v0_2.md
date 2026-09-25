# Accrual slowdown Poisson screen v0.2

**Date:** 25 September 2026  
**Status:** Exact stochastic operational screen under homogeneous Poisson accrual; no final slowdown factor selected.

## 1. Why this layer was added

The deterministic slowdown screen showed a linear trade-off:

\[
\text{protected patients}=(1-s)r_0L,
\]

\[
\text{Go calendar penalty}=(1-s)L.
\]

That model cannot identify an interior optimum. This second screen adds stochastic recruitment and asks a more operational question:

> How likely is the trial to have already randomized 70%, 80%, 90%, or 100% of its maximum sample before the Stage 1 CP decision becomes available?

This tail-risk criterion can distinguish slowdown strategies even when their mean trade-off is approximately linear.

## 2. Model

After the fixed Stage 1 cohort is accrued, additional recruitment during the endpoint-maturation interval is modeled as:

\[
X \sim \mathrm{Poisson}(s r_0 L).
\]

The number randomized when the CP decision is available is:

\[
N_{IA}=N_1+\min(X,N-N_1).
\]

The screen evaluates:

- Stage 1 = 35% and 40%;
- ordinary accrual = 6, 9, 12 participants/month;
- endpoint maturity = 4, 5, 6 months;
- slowdown multiplier = 1.00, 0.75, 0.50, 0.25.

The CP statistical operating characteristics are unchanged by slowdown because the Stage 1 decision cohort remains fixed.

## 3. Focused result: Stage 1 = 40%, L = 6 months

Here \(N_1=54\).

| Ordinary rate | Slowdown | E[N randomized at IA] | P(>=80% randomized at IA) | P(full accrual before IA) | E[still avoidable if No-Go] |
|---:|---:|---:|---:|---:|---:|
| 6/month | 100% | 90.0 | 0.7% | ~0% | 42.0 |
| 6/month | 75% | 81.0 | 0.001% | ~0% | 51.0 |
| 6/month | 50% | 72.0 | ~0% | ~0% | 60.0 |
| 6/month | 25% | 63.0 | ~0% | ~0% | 69.0 |
| 9/month | 100% | 108.0 | 62.6% | 0.1% | 24.0 |
| 9/month | 75% | 94.5 | 4.6% | ~0% | 37.5 |
| 9/month | 50% | 81.0 | 0.001% | ~0% | 51.0 |
| 9/month | 25% | 67.5 | ~0% | ~0% | 64.5 |
| 12/month | 100% | 124.8 | 99.4% | 25.5% | 7.2 |
| 12/month | 75% | 108.0 | 62.6% | 0.1% | 24.0 |
| 12/month | 50% | 90.0 | 0.7% | ~0% | 42.0 |
| 12/month | 25% | 72.0 | ~0% | ~0% | 60.0 |

## 4. Main new finding

The stochastic tail risk makes the 50% anchor more interesting than the deterministic mean calculation alone suggested.

At 9/month with a 6-month endpoint:

- no slowdown gives about a **63%** chance that at least 80% of the entire trial is already randomized before the CP decision;
- slowing to 75% reduces this to about **4.6%**;
- slowing to 50% reduces it to essentially zero.

At 12/month:

- no slowdown gives about a **99%** chance that at least 80% is already randomized and about a **26%** chance that full accrual is already complete;
- 75% slowdown still leaves about a **63%** chance that at least 80% is randomized;
- 50% slowdown reduces the >=80% risk to about **0.7%** and essentially eliminates full accrual before IA.

Thus 50% is not an algebraic optimum, but it behaves like a useful **risk-control anchor** across the faster-accrual scenarios.

## 5. Interaction with the current CP futility boundary

Using the existing exact global-null Stage 1 stop probabilities:

At 40% information:

- CP cutoff 30%: \(P(Stop|\Delta=0)=16.26\%\);
- CP cutoff 35%: \(P(Stop|\Delta=0)=27.00\%\).

For r=9/month and L=6 months:

| Slowdown | E[N] under global null, CP 30% | E[N] under global null, CP 35% |
|---:|---:|---:|
| 100% | 128.1 | 125.5 |
| 75% | 125.9 | 121.9 |
| 50% | 123.7 | 118.2 |
| 25% | 121.5 | 114.6 |

For r=12/month and L=6 months:

| Slowdown | E[N] under global null, CP 30% | E[N] under global null, CP 35% |
|---:|---:|---:|
| 100% | 130.8 | 130.1 |
| 75% | 128.1 | 125.5 |
| 50% | 125.2 | 120.7 |
| 25% | 122.2 | 115.8 |

This illustrates why slowdown matters even when the statistical stopping probability is unchanged: it changes how many participants remain preventable when a No-Go recommendation occurs.

## 6. Working interpretation

The first stochastic screen supports keeping:

- **50% of ordinary accrual as the central operational anchor**;
- **75% as the lighter-slowdown sensitivity**;
- **25% as the near-pause sensitivity**.

The reason for centering 50% is now more concrete than before:

- it materially suppresses the probability that the trial is already mostly accrued before IA in the 9-12/month scenarios;
- it retains ongoing recruitment;
- under a 6-month maturity delay, its simple-model Go penalty remains about 3 months, versus 4.5 months for 25%.

This is still not a final rule because homogeneous Poisson accrual does not model site-level restart friction or screening already in progress.

## 7. Next design question

Before adding more complexity, the project should decide what operational risk it wants the slowdown to control.

A natural candidate constraint is:

\[
P(\text{at least 80% of maximum N randomized before IA}) \le 5\%.
\]

Under the current 40% / 6-month illustration:

- at 9/month, 75% slowdown approximately meets this;
- at 12/month, 75% does not, while 50% does.

If a 5% tail-risk constraint is clinically/operationally acceptable, this gives a principled way to choose the slowdown rate as a function of expected accrual speed rather than imposing the same rate in every scenario.

## Reproducibility

R code:

`simulation/cp_accrual_slowdown_poisson_v0_2.R`

Results:

`simulation/results/cp_accrual_slowdown_poisson_v0_2.csv`
