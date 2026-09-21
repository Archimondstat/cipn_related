# CRC Stage 1 Risk-Efficiency / Precision Table v0.7

Date: 2026-09-21  
Status: comparison table only; no sample size or boundary selected

## Frozen assumptions

CRC efficacy assumptions remain unchanged:

[
p_P=45%,qquad p_T=30%,qquad ARR_{target}=15%.
]

The working final-Go rule remains (widehat{ARR}_{final}ge10%) only for calculating conditional power.

This table does **not** use final program-Go probability to rank sample sizes because the binary final-Go rule has a visible lattice effect across (N).

## Why compare a matched actual Stage 1 boundary

At a nominal 50% Stage 1 information fraction, the nominal CP cutoff does not map to the same decision boundary for every (N).

For design-alternative CP, the operative Stage 1 quantity is the event-count difference

[
d_1=x_{P1}-x_{T1}.
]

A common reference rule

[
d_1le-3
]

means that the active arm has at least three more CTCAE grade >=2 events than placebo at Stage 1.

Because CP is discrete, this same actual boundary corresponds to different nominal CP cutoffs at different (N). Therefore comparing the matched actual boundary is cleaner than comparing the same nominal CP number across sample sizes.

## 50% information, matched actual boundary (d_1le-3)

| Maximum N/arm | Nominal Stage 1 n/arm | Nominal CP cutoff giving this boundary | Overall No-Go if both doses truly ARR=0% | Futility signal for a truly ARR=15% dose | Overall false No-Go if one dose=15%, other=0% | Overall false No-Go if both doses=15% | E(N), Design A, global null | E(N), Design B, global null | A vs B N saved when one dose=15% | Approx. 95% CI half-width for ARR |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 36 | 18 | 10-15% | 8.72% | 3.55% | 2.16% | 0.73% | 99.18 | 103.29 | 3.49 | 22.09% |
| 40 | 20 | 15-20% | 9.51% | 3.51% | 2.21% | 0.73% | 109.55 | 114.29 | 4.09 | 20.96% |
| 44 | 22 | 10-15% | 10.23% | 3.43% | 2.22% | 0.71% | 119.87 | 125.25 | 4.72 | 19.99% |
| 48 | 24 | 15% | 10.89% | 3.34% | 2.22% | 0.68% | 130.14 | 136.16 | 5.36 | 19.13% |
| 52 | 26 | 10% | 11.49% | 3.23% | 2.20% | 0.66% | 140.37 | 147.03 | 6.02 | 18.38% |

## What this comparison shows

Once the Stage 1 information fraction and **actual futility boundary** are matched, the Stage 1 decision risks are remarkably stable across the candidate maximum sample sizes.

Across (N=36) to (52) per arm:

[
P(	ext{futility signal for a truly 15% ARR dose})
]

stays close to 3.2-3.6%, and

[
P(	ext{overall false No-Go}mid15%,0)
]

stays close to 2.2%.

The main systematic change with increasing (N) is therefore not Stage 1 false-futility risk but:

1. improved final estimation precision;
2. larger maximum and expected sample size;
3. somewhat larger absolute opportunity for Design A to save subjects relative to Design B.

This supports treating the choice of maximum (N) and the choice of Stage 1 futility aggressiveness as related but separable design decisions.

## Important limitation

The common boundary (d_1le-3) is used here only to make an apples-to-apples comparison across candidate (N). It is **not** a selected futility rule.

The next design discussion can therefore focus on the practical trade-off:

[
	ext{final precision / total sample size}
]

first, and then compare more conservative or more aggressive Stage 1 boundaries within the preferred (N) range.

## Reproducible code

- Full (N	imes f_1	imes c_F) calibration: `simulation/cp_sample_size_calibration_crc.R`
- Presentation table and matched-boundary extraction: `simulation/cp_crc_stage1_tradeoff_table.R`
