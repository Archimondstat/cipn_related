# CRC Stage 1 Timing × Boundary Screen v0.9

Date: 2026-09-21  
Status: exact design screening; no timing, N, or boundary selected

## Fixed efficacy assumptions

The CRC efficacy assumptions remain unchanged:

[
p_P=45%,qquad p_T=30%,qquad ARR_{target}=15%.
]

The current exercise varies only the design.

## Why the screening is now organized by actual boundary

For a binary endpoint, conditional power is discrete. Consequently, comparing a fixed nominal CP cutoff across 40%, 50%, and 60% Stage 1 information can unintentionally compare different **actual** event-count rules.

Define:

[
d_1=x_{P1}-x_{T1}.
]

Because CTCAE grade >=2 CIPN is unfavorable, a negative value means the active arm has more events than placebo.

The screening therefore compares three reference actual boundaries:

[
d_1le-4,qquad d_1le-3,qquad d_1le-2.
]

These are reference levels only and are not labels or selected rules.

For each (N) and Stage 1 information fraction, the code also gives the interval of nominal CP cutoffs that generates each integer boundary.

## Example: N=44/arm

N=44 remains only an anchor for illustration.

### Boundary (d_1le-4)

| Stage 1 information | nominal n1/arm | CP cutoff interval producing this boundary | No-Go if both doses null | Futility for a truly ARR=15% dose | Overall false No-Go if one dose=15%, other=0% | E(N), Design A, global null |
|---:|---:|---:|---:|---:|---:|---:|
| 40% | 18 | (8.99%, 14.80%] | 4.12% | 1.57% | 0.81% | 124.67 |
| 50% | 22 | (4.87%, 9.14%] | 5.38% | 1.64% | 0.93% | 124.46 |
| 60% | 26 | (1.96%, 4.50%] | 6.52% | 1.64% | 1.00% | 124.90 |

### Boundary (d_1le-3)

| Stage 1 information | nominal n1/arm | CP cutoff interval producing this boundary | No-Go if both doses null | Futility for a truly ARR=15% dose | Overall false No-Go if one dose=15%, other=0% | E(N), Design A, global null |
|---:|---:|---:|---:|---:|---:|---:|
| 40% | 18 | (14.80%, 22.63%] | 8.72% | 3.55% | 2.16% | 119.27 |
| 50% | 22 | (9.14%, 15.63%] | 10.23% | 3.43% | 2.22% | 119.87 |
| 60% | 26 | (4.50%, 9.12%] | 11.49% | 3.23% | 2.20% | 121.18 |

### Boundary (d_1le-2)

| Stage 1 information | nominal n1/arm | CP cutoff interval producing this boundary | No-Go if both doses null | Futility for a truly ARR=15% dose | Overall false No-Go if one dose=15%, other=0% | E(N), Design A, global null |
|---:|---:|---:|---:|---:|---:|---:|
| 40% | 18 | (22.63%, 32.32%] | 16.26% | 7.22% | 5.00% | 111.76 |
| 50% | 22 | (15.63%, 24.52%] | 17.60% | 6.57% | 4.74% | 113.83 |
| 60% | 26 | (9.12%, 16.45%] | 18.66% | 5.93% | 4.41% | 116.47 |

## First interpretation of the timing dimension

When the **actual Stage 1 boundary is held fixed**, moving the interim later from approximately 40% to 60% generally:

- increases the probability of recognizing a fully null program;
- slightly decreases the arm-level false-futility probability for a truly 15% ARR dose for the (d_1le-3) and (d_1le-2) reference rules;
- leaves overall false No-Go with one target-effective dose close to the same level;
- reduces the amount of trial remaining after the interim, so the expected-sample-size benefit of early decisions becomes smaller.

Thus the 40%/50%/60% choice is a genuine **timing-efficiency trade-off**, not merely a different nominal CP cutoff.

## Important consequence for the eventual protocol rule

A nominal CP cutoff should not be selected before the information fraction is selected or at least narrowed.

For example, at (N=44), the same actual rule (d_1le-3) corresponds approximately to:

[
c_Fin(14.8%,22.6%]quad	ext{at 40% information},
]

[
c_Fin(9.1%,15.6%]quad	ext{at 50% information},
]

and

[
c_Fin(4.5%,9.1%]quad	ext{at 60% information}.
]

Therefore a statement such as “use CP <10%” has different practical meaning depending on when Stage 1 is conducted.

## Files

Reproducible exact R code:

`simulation/cp_crc_stage1_timing_boundary_screen.R`

Generated outputs:

- `simulation/results/cp_crc_timing_boundary_screen_v0_9.csv`
- `simulation/results/cp_crc_N44_timing_boundary_v0_9.csv`
- `simulation/results/cp_crc_matched_dminus3_allN_v0_9.csv`

The next screening step should compare the same reference boundaries across all candidate (N), while retaining 40%, 50%, and 60% as separate Stage 1 timing choices.
