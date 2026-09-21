# CRC CP Boundary Trade-off Table v0.4

Date: 2026-09-21  
Status: exploratory; no boundary selected

## Frozen working assumptions for this table

For this first decision table, the efficacy assumptions are intentionally left unchanged:

- placebo CTCAE grade >=2 CIPN event rate: 45%;
- target active event rate: 30%;
- target ARR: 15%;
- maximum sample size: 44 subjects/arm;
- provisional final Phase II Go rule: observed final ARR >=10%;
- conditional-power future assumption: design alternative,
  \[
  p_P^{future}=45\%,\qquad p_T^{future}=30\%;
  \]
- no operational overrun, safety override, missing data, or earlier endpoint;
- exact Stage 1 enumeration, so the table has no Monte Carlo error.

## Boundary trade-off table

| Stage 1 n/arm | Information | CP cutoff | Overall No-Go if both doses truly ARR=0% | Futility signal for a truly ARR=15% dose | Overall false No-Go if one dose ARR=15%, other 0% | Overall false No-Go if both doses ARR=15% | A vs B N saved: global null | A vs B N saved: one target dose |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 18 | 40.9% | 5%  | 0.60% | 0.22% | 0.07% | 0.01% | 1.35 | 0.85 |
| 18 | 40.9% | 10% | 4.12% | 1.57% | 0.81% | 0.22% | 4.11 | 3.12 |
| 18 | 40.9% | 15% | 8.72% | 3.55% | 2.16% | 0.73% | 5.93 | 5.04 |
| 18 | 40.9% | 20% | 8.72% | 3.55% | 2.16% | 0.73% | 5.93 | 5.04 |
| 22 | 50.0% | 5%  | 5.38% | 1.64% | 0.93% | 0.24% | 3.98 | 3.13 |
| 22 | 50.0% | 10% | 10.23% | 3.43% | 2.22% | 0.71% | 5.38 | 4.72 |
| 22 | 50.0% | 15% | 10.23% | 3.43% | 2.22% | 0.71% | 5.38 | 4.72 |
| 22 | 50.0% | 20% | 17.60% | 6.57% | 4.74% | 1.81% | 6.56 | 6.51 |
| 26 | 59.1% | 5%  | 11.49% | 3.23% | 2.20% | 0.66% | 4.61 | 4.17 |
| 26 | 59.1% | 10% | 18.66% | 5.93% | 4.41% | 1.57% | 5.46 | 5.57 |
| 26 | 59.1% | 15% | 18.66% | 5.93% | 4.41% | 1.57% | 5.46 | 5.57 |
| 26 | 59.1% | 20% | 28.01% | 10.14% | 8.11% | 3.39% | 5.92 | 6.91 |

## How to read the table

The first four probability columns define the principal Stage 1 risk trade-off.

- **Overall No-Go under the global null** measures how often a completely ineffective program can be stopped at Stage 1.
- **Futility signal for a truly ARR=15% dose** is the arm-level false-futility risk relevant to Design A.
- **Overall false No-Go with one target-effective dose** measures the risk of stopping the entire program when one dose actually has the target effect.
- **Overall false No-Go with both target-effective doses** is the more favorable effective-program scenario.

The final two columns quantify only the incremental sample-size advantage of Design A over Design B before operational overrun:

\[
E(N_B)-E(N_A).
\]

They should not be interpreted as total expected sample-size savings versus a fixed one-stage design.

## Discreteness

Some nominal CP cutoffs give identical operating characteristics:

- n1=18: 15% and 20% are identical;
- n1=22: 10% and 15% are identical;
- n1=26: 10% and 15% are identical.

This is expected for a binary endpoint. The CP values attainable at Stage 1 are discrete, so changing the nominal cutoff does not necessarily change the actual event-count futility boundary.

## Current interpretation

The table is intentionally not labeled Conservative / Moderate / Aggressive yet.

The next step is to identify the non-dominated candidate rows and present a small risk-efficiency frontier. Selection should be based on the joint trade-off among:

\[
P(\text{No-Go}\mid ARR_L=ARR_H=0),
\]

\[
P(\text{futility signal for a true 15% ARR dose}),
\]

\[
P(\text{overall false No-Go}\mid 15\%,0),
\]

Stage 1 timing, and the incremental sample-size benefit of dose dropping.

No clinical tolerance has been imposed at this stage.
