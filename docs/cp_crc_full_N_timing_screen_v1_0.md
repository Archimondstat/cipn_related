# CRC Full N × Stage 1 Timing Screen v1.0

Date: 2026-09-21  
Status: exact screening result; no design selected

## Frozen efficacy assumptions

The CRC efficacy assumptions remain unchanged:

[
p_P=45%,qquad p_T=30%,qquad ARR_{target}=15%.
]

The current design search varies:

[
Nin{36,40,44,48,52}	ext{ per arm},
]

[
f_1in{40%,50%,60%},
]

and the Stage 1 futility boundary.

To compare Stage 1 timing cleanly, the main table below holds the **actual integer boundary** fixed at:

[
d_1=x_{P1}-x_{T1}le-3.
]

This is a reference boundary only, not a selected rule.

## Matched (d_1le-3) comparison

| N/arm | Stage 1 | nominal n1/arm | CP-cutoff interval giving (d_1le-3) | No-Go if both doses null | Futility for true ARR=15% | Overall false No-Go if one dose=15%, other=0% | E(N), Design A, null | A vs B saving, one target dose | ARR 95% CI half-width |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 36 | 40% | 14 | (15.63%, 24.52%] | 6.88% | 3.51% | 1.94% | 98.95 | 3.68 | 22.09% |
| 36 | 50% | 18 | (9.12%, 16.45%] | 8.72% | 3.55% | 2.16% | 99.18 | 3.49 | 22.09% |
| 36 | 60% | 22 | (3.84%, 8.77%] | 10.23% | 3.43% | 2.22% | 100.28 | 3.00 | 22.09% |
| 40 | 40% | 16 | (19.11%, 28.48%] | 7.85% | 3.56% | 2.07% | 109.13 | 4.35 | 20.96% |
| 40 | 50% | 20 | (12.28%, 20.49%] | 9.51% | 3.51% | 2.21% | 109.55 | 4.09 | 20.96% |
| 40 | 60% | 24 | (6.27%, 12.50%] | 10.89% | 3.34% | 2.22% | 110.76 | 3.57 | 20.96% |
| 44 | 40% | 18 | (14.80%, 22.63%] | 8.72% | 3.55% | 2.16% | 119.27 | 5.04 | 19.99% |
| 44 | 50% | 22 | (9.14%, 15.63%] | 10.23% | 3.43% | 2.22% | 119.87 | 4.72 | 19.99% |
| 44 | 60% | 26 | (4.50%, 9.12%] | 11.49% | 3.23% | 2.20% | 121.18 | 4.17 | 19.99% |
| 48 | 40% | 19 | (19.39%, 27.89%] | 9.12% | 3.53% | 2.19% | 129.31 | 5.78 | 19.13% |
| 48 | 50% | 24 | (11.88%, 19.11%] | 10.89% | 3.34% | 2.22% | 130.14 | 5.36 | 19.13% |
| 48 | 60% | 29 | (5.54%, 10.67%] | 12.32% | 3.05% | 2.14% | 131.98 | 4.61 | 19.13% |
| 52 | 40% | 21 | (15.31%, 22.53%] | 9.88% | 3.47% | 2.22% | 139.35 | 6.50 | 18.38% |
| 52 | 50% | 26 | (8.99%, 14.80%] | 11.49% | 3.23% | 2.20% | 140.37 | 6.02 | 18.38% |
| 52 | 60% | 31 | (4.02%, 7.87%] | 12.81% | 2.93% | 2.09% | 142.31 | 5.24 | 18.38% |

## Timing pattern

Holding (N) and the actual boundary fixed, moving Stage 1 from 40% to 60% produces a remarkably stable pattern across the entire sample-size range.

For the reference (d_1le-3) rule:

- global-null Stage 1 No-Go increases by about 2.8-3.4 percentage points;
- false arm-level futility for a truly 15% ARR dose changes very little and tends to decrease slightly;
- overall false No-Go when one dose is truly target-effective remains close to 2%;
- Design A loses some of its sample-saving advantage because less trial remains after a later interim.

For example at (N=44):

[
P(NoGomid0,0):quad 8.72%ightarrow10.23%ightarrow11.49%
]

for 40%, 50%, and 60% Stage 1 timing, while:

[
P(Futilitymid ARR=15%):quad3.55%ightarrow3.43%ightarrow3.23%.
]

Thus the timing decision is not mainly about protecting the target-effective dose under this matched boundary. It is mainly a trade-off between:

[
	ext{earlier opportunity to save patients}
]

and

[
	ext{slightly greater ability to recognize a null program later}.
]

## Sample-size pattern

Across (N=36) to (52), with Stage 1 information fraction and actual boundary matched, Stage 1 false-futility behavior is again quite stable.

The systematic effect of larger (N) is primarily:

- improved final ARR precision;
- larger total and expected sample size;
- larger absolute opportunity for Design A to save patients relative to Design B.

The approximate 95% CI half-width for ARR under the frozen target rates improves from:

[
22.1%quad(N=36)
]

to:

[
18.4%quad(N=52).
]

## Implication for the next screen

The current evidence supports keeping the design selection in two connected but distinct steps:

1. narrow the plausible maximum (N) range based on final evidence/precision and development feasibility;
2. within that range, compare 40%, 50%, and 60% Stage 1 timing together with alternative futility boundaries (d_1le-4,-3,-2).

No row is selected at this stage.

## Reproducibility

Primary R code:

`simulation/cp_crc_stage1_timing_boundary_screen.R`

Saved matched-boundary result:

`simulation/results/cp_crc_matched_dminus3_allN_v1_0.csv`

Saved 40%-to-60% timing contrast:

`simulation/results/cp_crc_timing_40_vs_60_v1_0.csv`
