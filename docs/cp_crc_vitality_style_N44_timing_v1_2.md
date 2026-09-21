# CRC VITALITY-style Timing Tables — N=44 Anchor v1.2

Date: 2026-09-21  
Status: design exploration; no boundary or timing selected

CRC efficacy assumptions remain fixed:

[
p_P=45%,qquad p_T=30%,qquad ARR_{target}=15%.
]

This document places the 40%, 50%, and 60% Stage 1 analyses in the same format as the VITALITY-HFpEF futility-boundary table.

For the binary CIPN endpoint, define:

[
d_1=x_{P1}-x_{T1}.
]

A candidate integer boundary (D) corresponds to the arm-level rule:

[
d_1le D.
]

The equivalent observed interim ARR boundary is:

[
D/n_1.
]

Conditional power continues to use the current working future assumption:

[
p_P^{future}=45%,qquad p_T^{future}=30%,
]

and the working final-Go event:

[
widehat{ARR}_{final}ge10%.
]

The final-Go rule is still provisional; the CRC efficacy assumption itself is unchanged.

## Stage 1 at 40% information

For (N=44), the nominal mature Stage 1 sample size is (n_1=18) per arm.

| Interim ARR boundary | Individual CP | Joint CP | P(both futile), true ARR=0% | P(both futile), true ARR=15% | P(any final ARR >=15% / >=10% / >=5%) |
|---:|---:|---:|---:|---:|---:|
| -22.22% | 8.99% | 14.78% | 4.12% | 0.22% | 4.61% / 14.78% / 34.05% |
| -16.67% | 14.80% | 23.32% | 8.72% | 0.73% | 8.62% / 23.32% / 46.26% |
| -11.11% | 22.63% | 34.05% | 16.26% | 2.05% | 14.78% / 34.05% / 58.85% |
| -5.56% | 32.32% | 46.26% | 27.00% | 4.94% | 23.32% / 46.26% / 70.60% |
| 0.00% | 43.34% | 58.85% | 40.34% | 10.36% | 34.05% / 58.85% / 80.53% |
| 5.56% | 54.86% | 70.60% | 54.85% | 19.07% | 46.26% / 70.60% / 88.12% |
| 11.11% | 65.95% | 80.53% | 68.68% | 31.16% | 58.85% / 80.53% / 93.35% |

## Stage 1 at 50% information

For (N=44), (n_1=22) per arm.

| Interim ARR boundary | Individual CP | Joint CP | P(both futile), true ARR=0% | P(both futile), true ARR=15% | P(any final ARR >=15% / >=10% / >=5%) |
|---:|---:|---:|---:|---:|---:|
| -18.18% | 4.87% | 8.32% | 5.38% | 0.24% | 1.85% / 8.32% / 24.48% |
| -13.64% | 9.14% | 14.99% | 10.23% | 0.71% | 4.15% / 14.99% / 36.49% |
| -9.09% | 15.63% | 24.48% | 17.60% | 1.81% | 8.32% / 24.48% / 49.99% |
| -4.55% | 24.52% | 36.49% | 27.57% | 4.09% | 14.99% / 36.49% / 63.51% |
| 0.00% | 35.49% | 49.99% | 39.65% | 8.24% | 24.48% / 49.99% / 75.54% |
| 4.55% | 47.76% | 63.51% | 52.76% | 14.93% | 36.49% / 63.51% / 85.07% |
| 9.09% | 60.19% | 75.54% | 65.53% | 24.46% | 49.99% / 75.54% / 91.76% |

## Stage 1 at 60% information

For (N=44), (n_1=26) per arm.

| Interim ARR boundary | Individual CP | Joint CP | P(both futile), true ARR=0% | P(both futile), true ARR=15% | P(any final ARR >=15% / >=10% / >=5%) |
|---:|---:|---:|---:|---:|---:|
| -15.38% | 1.96% | 3.48% | 6.52% | 0.25% | 0.46% / 3.48% / 14.93% |
| -11.54% | 4.50% | 7.70% | 11.49% | 0.66% | 1.36% / 7.70% / 25.59% |
| -7.69% | 9.12% | 14.93% | 18.66% | 1.57% | 3.48% / 14.93% / 39.22% |
| -3.85% | 16.45% | 25.59% | 28.01% | 3.39% | 7.70% / 25.59% / 54.33% |
| 0.00% | 26.68% | 39.22% | 39.13% | 6.65% | 14.93% / 39.22% / 68.84% |
| 3.85% | 39.30% | 54.33% | 51.16% | 11.88% | 25.59% / 54.33% / 80.93% |
| 7.69% | 53.08% | 68.84% | 63.05% | 19.47% | 39.22% / 68.84% / 89.64% |

## What is already visible

When the observed interim boundary is near 0%, the probability of stopping a fully null program is about 39-40% at all three timings:

[
40%: 40.34%,qquad
50%: 39.65%,qquad
60%: 39.13%.
]

At the same 0% boundary, the probability of overall futility when both active doses truly have ARR=15% decreases as the interim is delayed:

[
10.36%ightarrow8.24%ightarrow6.65%.
]

Thus later timing protects a truly effective program more strongly for the same **observed-effect** boundary, whereas earlier timing leaves more opportunity for sample-size saving if the program is futile.

This is the VITALITY-style trade-off we should use for the next screening step.

## Files

- `simulation/results/cp_crc_vitality_style_N44_f1_40_v1_2.csv`
- `simulation/results/cp_crc_vitality_style_N44_f1_50_v1_2.csv`
- `simulation/results/cp_crc_vitality_style_N44_f1_60_v1_2.csv`
- generating code remains `simulation/cp_crc_vitality_style_analysis.R`
