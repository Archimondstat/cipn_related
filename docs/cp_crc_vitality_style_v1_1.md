# CRC VITALITY-style Futility Boundary Analysis v1.1

Date: 2026-09-21  
Status: exact analysis framework; no boundary selected

## Objective

Reformat the CRC Stage 1 analysis to follow the logic of VITALITY-HFpEF Table 4-2.

The key change is that each candidate Stage 1 boundary is shown together with:

1. its equivalent observed treatment-effect boundary;
2. individual conditional power;
3. joint conditional power across the two active doses;
4. the probability of meeting the futility criterion under relevant true-effect scenarios;
5. the probability that at least one dose eventually shows selected final treatment effects.

This makes the trade-off visible in one table rather than discussing CP cutoff, false futility, and final evidence separately.

## Mapping from VITALITY to the CIPN design

VITALITY used a continuous KCCQ treatment-effect boundary.

The CIPN endpoint is binary, so the exact Stage 1 boundary is discrete.

Define:

[
d_1=x_{P1}-x_{T1}.
]

For a candidate integer boundary (D):

[
d_1le D
]

is the arm-level futility criterion.

The equivalent observed interim ARR boundary is:

[
rac{D}{n_1}.
]

Because lower CIPN incidence is favorable, negative values mean that the active arm is numerically worse than placebo.

## N=44/arm, Stage 1 = 50% example

Here (n_1=22) per arm nominally.

The CP calculation retains the current working assumptions:

[
p_P^{future}=45%,qquad
p_T^{future}=30%,
]

and the working final-Go criterion:

[
widehat{ARR}_{final}ge10%.
]

| Equivalent interim ARR boundary | Individual CP | Joint CP | Probability both doses meet futility criterion: true ARR=0% | Probability both doses meet futility criterion: true ARR=15% | Joint probability final ARR >=15% / >=10% / >=5% on any dose |
|---:|---:|---:|---:|---:|---:|
| -18.18% | 4.87% | 8.32% | 5.38% | 0.24% | 1.85% / 8.32% / 24.48% |
| -13.64% | 9.14% | 14.99% | 10.23% | 0.71% | 4.15% / 14.99% / 36.49% |
| -9.09% | 15.63% | 24.48% | 17.60% | 1.81% | 8.32% / 24.48% / 49.99% |
| -4.55% | 24.52% | 36.49% | 27.57% | 4.09% | 14.99% / 36.49% / 63.51% |
| 0.00% | 35.49% | 49.99% | 39.65% | 8.24% | 24.48% / 49.99% / 75.54% |
| 4.55% | 47.76% | 63.51% | 52.76% | 14.93% | 36.49% / 63.51% / 85.07% |
| 9.09% | 60.19% | 75.54% | 65.53% | 24.46% | 49.99% / 75.54% / 91.76% |

## Immediate interpretation

This table makes clear that the previously used reference rule

[
d_1le-3
]

is highly conservative.

At (N=44), 50% information, it corresponds to an observed interim ARR boundary of:

[
-3/22=-13.64%.
]

Thus the active arm must be materially worse than placebo before it is called futile.

That rule gives:

[
P(	ext{overall futility}mid ARR_L=ARR_H=0)=10.23%,
]

but protects a truly target-effective program very strongly:

[
P(	ext{overall futility}mid ARR_L=ARR_H=15%)=0.71%.
]

Moving the boundary toward zero substantially increases the ability to stop a truly null program, but also increases false futility under the target effect.

For example, using an observed interim boundary of approximately 0%:

[
P(	ext{overall futility}mid0,0)=39.65%,
]

while:

[
P(	ext{overall futility}mid15%,15%)=8.24%.
]

This is directly analogous to the trade-off displayed in VITALITY Table 4-2.

## Why this format is preferable for discussion

The design discussion can now start from a clinically/statistically interpretable Stage 1 effect boundary and show its consequences, rather than asking the team to choose an abstract CP percentage.

For the binary CIPN endpoint, the actual decision boundary must still respect the discrete event-count structure.

The eventual operational implementation should remain CP-based and should use actual (n_P,n_L,n_H), but the design-calibration table can be presented in this VITALITY-style form.

## Stage 1 timing and maximum N

The R code generates this same table for:

[
N=36,40,44,48,52
]

and:

[
f_1=40%,50%,60%.
]

Therefore the next comparison can examine how the full VITALITY-style trade-off table changes with Stage 1 timing and maximum sample size.

## Files

R code:

`simulation/cp_crc_vitality_style_analysis.R`

Full result grid:

`simulation/results/cp_crc_vitality_style_allN_allTiming_v1_1.csv`

N=44, 50% information example:

`simulation/results/cp_crc_vitality_style_N44_f1_50_v1_1.csv`
