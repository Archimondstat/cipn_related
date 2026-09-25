# Accrual slowdown screen v0.1

**Date:** 25 September 2026  
**Status:** First deterministic operational screen; no slowdown factor selected.

## 1. Question

After the prespecified Stage 1 cohort has been fully randomized, how much should recruitment be slowed while waiting for the delayed primary endpoint to mature?

The current candidates are:

- 100% of ordinary recruitment rate: no slowdown;
- 75%;
- 50%;
- 25%.

This screen deliberately holds the statistical Stage 1 CP rule fixed. Slowdown changes only the number of additional participants randomized before the CP decision becomes available.

## 2. Model

Let:

- \(N=132\): maximum total sample size;
- \(N_1\): Stage 1 randomization target;
- \(r_0\): ordinary total recruitment rate per month;
- \(L\): endpoint maturation delay in months;
- \(s\): slowdown multiplier after Stage 1 accrual.

After Stage 1 accrual, the reduced rate is:

\[
r_s=s r_0.
\]

The expected number randomized when the interim decision becomes available is:

\[
N_{IA}(s)=\min\{N, N_1+s r_0L\}.
\]

If the trial continues and the ordinary rate is restored immediately after the interim decision, then in the region where full accrual has not already occurred:

\[
T_{Go}(s)=\frac{N}{r_0}+(1-s)L.
\]

Thus:

\[
\boxed{\text{Go calendar penalty}=(1-s)L}
\]

and:

\[
\boxed{\text{participants protected before IA}=(1-s)r_0L}.
\]

Therefore, before saturation at \(N\):

\[
\frac{\text{participants protected}}{\text{added month if Go}}
=
r_0.
\]

This is the key result of the first screen: under a constant-rate deterministic model, 75%, 50%, and 25% slowdown lie on the same linear trade-off frontier. There is **no mathematical interior optimum** without adding further operational assumptions.

## 3. Focused result: Stage 1 = 40%, endpoint delay = 6 months

Here \(N_1=54\).

| Ordinary rate | Slowdown rate | Randomized at IA | Fraction randomized | Still avoidable if No-Go | Protected vs no slowdown | Extra time if Go |
|---:|---:|---:|---:|---:|---:|---:|
| 6/month | 100% | 90 | 68% | 42 | 0 | 0.0 mo |
| 6/month | 75% | 81 | 61% | 51 | 9 | 1.5 mo |
| 6/month | 50% | 72 | 55% | 60 | 18 | 3.0 mo |
| 6/month | 25% | 63 | 48% | 69 | 27 | 4.5 mo |
| 9/month | 100% | 108 | 82% | 24 | 0 | 0.0 mo |
| 9/month | 75% | 94.5 | 72% | 37.5 | 13.5 | 1.5 mo |
| 9/month | 50% | 81 | 61% | 51 | 27 | 3.0 mo |
| 9/month | 25% | 67.5 | 51% | 64.5 | 40.5 | 4.5 mo |
| 12/month | 100% | 126 | 95% | 6 | 0 | 0.0 mo |
| 12/month | 75% | 108 | 82% | 24 | 18 | 1.5 mo |
| 12/month | 50% | 90 | 68% | 42 | 36 | 3.0 mo |
| 12/month | 25% | 72 | 55% | 60 | 54 | 4.5 mo |

## 4. What this tells us about the 50% anchor

A 50% slowdown is a useful **operational anchor**, but this first model does not show that it is statistically optimal.

For a 6-month endpoint delay it has a transparent interpretation:

- it removes one half of the otherwise expected pipeline recruitment;
- if Stage 1 continues, it costs approximately 3 additional months to complete accrual;
- at 9/month it protects about 27 randomizations before the decision;
- at 12/month it protects about 36 randomizations before the decision.

By comparison:

- 75% rate costs only 1.5 months but protects only half as many participants as the 50% strategy;
- 25% rate protects another equal increment of participants but costs another 1.5 months.

The deterministic model therefore gives us a **Pareto frontier**, not a winner.

## 5. Why the next layer must be stochastic / operational

To distinguish 75%, 50%, and 25%, the next model needs at least one nonlinear operational feature. Candidate features are:

1. stochastic monthly recruitment rather than a fixed rate;
2. heterogeneity across sites;
3. a minimum feasible site-level recruitment rate;
4. restart/ramp-up delay after a positive Stage 1 decision;
5. screening already in progress when slowdown begins;
6. site closure or loss of recruitment momentum at very low rates;
7. uncertainty in endpoint maturation time;
8. the actual probability of Stage 1 No-Go under each CP boundary.

The strongest reason not to jump immediately to 25% is therefore operational rather than statistical: 25% begins to resemble a near-pause and may produce restart friction that is absent from this first model.

## 6. Immediate next step

Use **50% as the central anchor**, with 75% and 25% as sensitivity strategies.

The next simulation should combine:

- ordinary recruitment rate: 6, 9, 12/month;
- slowdown: 75%, 50%, 25%;
- endpoint maturity: 4, 5, 6 months;
- Stage 1 timing: 35% and 40% initially;
- the currently calibrated CP regions.

The simulation should add random accrual and report:

- distribution of randomized N at the IA decision;
- probability of full accrual before IA;
- conditional sample saved given No-Go;
- expected sample saved under the global null;
- calendar completion penalty when the study continues.

Only after this layer should the slowdown factor be narrowed further.

## Reproducibility

R code:

`simulation/cp_accrual_slowdown_screen_v0_1.R`

Full deterministic grid:

`simulation/results/cp_accrual_slowdown_screen_v0_1.csv`
