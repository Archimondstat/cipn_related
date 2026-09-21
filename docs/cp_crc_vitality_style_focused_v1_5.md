# Focused VITALITY-style CRC Reference Table v1.5

Date: 2026-09-22  
Status: presentation/calibration table; no automatic Stage 1 stopping boundary selected

## Fixed definitions

Treatment effect:

[
Delta=p_{mathrm{Placebo}}-p_{mathrm{Treatment}}.
]

Positive values favor treatment.

CRC quantities:

- target treatment effect = 15%;
- weak-effect boundary = 5%;
- promising threshold = 10%.

The Stage 1 values shown below are **reference observed treatment effects**, not automatic futility boundaries.

For equal nominal Stage 1 sample size:

[
widehatDelta_1
=
rac{x_{P1}-x_{T1}}{n_1}.
]

Thus each displayed reference effect has a direct event-count interpretation.

## N=44/arm focused comparison

| Stage 1 information | nominal n1/arm | Reference interim observed effect | Event-count difference (x_P-x_T) | Interpretation | Individual CP | Joint CP | P(both doses at/below reference), true effect=0% | true effect=5% | true effect=15% |
|---:|---:|---:|---:|:---|---:|---:|---:|---:|---:|
| 40% | 18 | -5.56% | -1 | Treatment has 1 more event | 32.32% | 46.26% | 27.00% | 17.12% | 4.94% |
| 40% | 18 | 0.00% | 0 | Same number of events | 43.34% | 58.85% | 40.34% | 28.23% | 10.36% |
| 40% | 18 | 5.56% | +1 | Placebo has 1 more event | 54.86% | 70.60% | 54.85% | 41.89% | 19.07% |
| 40% | 18 | 11.11% | +2 | Placebo has 2 more events | 65.95% | 80.53% | 68.68% | 56.56% | 31.16% |
| 50% | 22 | -4.55% | -1 | Treatment has 1 more event | 24.52% | 36.49% | 27.57% | 16.67% | 4.09% |
| 50% | 22 | 0.00% | 0 | Same number of events | 35.49% | 49.99% | 39.65% | 26.46% | 8.24% |
| 50% | 22 | 4.55% | +1 | Placebo has 1 more event | 47.76% | 63.51% | 52.76% | 38.47% | 14.93% |
| 50% | 22 | 9.09% | +2 | Placebo has 2 more events | 60.19% | 75.54% | 65.53% | 51.66% | 24.46% |
| 60% | 26 | -3.85% | -1 | Treatment has 1 more event | 16.45% | 25.59% | 28.01% | 16.21% | 3.39% |
| 60% | 26 | 0.00% | 0 | Same number of events | 26.68% | 39.22% | 39.13% | 24.98% | 6.65% |
| 60% | 26 | 3.85% | +1 | Placebo has 1 more event | 39.30% | 54.33% | 51.16% | 35.73% | 11.88% |
| 60% | 26 | 11.54% | +3 | Placebo has 3 more events | 66.43% | 80.93% | 73.77% | 59.86% | 29.40% |

## How to interpret CP

For this exploratory study:

[
CP_j
=
P(
widehatDelta_{j,F}ge10%
mid
D_1,	heta_{mathrm{future}}
).
]

Thus CP is the conditional probability of meeting the prespecified **Phase II promising threshold**.

The displayed reference effect is only a convenient way to index possible Stage 1 data patterns.

For example, at 50% information:

[
n_1=22.
]

A reference observed effect of:

[
9.09%=rac{2}{22}
]

corresponds to placebo having two more CIPN events than treatment.

The table then shows the CP associated with that observed data pattern and how frequently both active doses would fall at or below that reference region under different true effects.

It does not state that the study must stop or continue at 9.09%.

## Final three-region Phase II framework

At the final Phase II analysis:

[
widehatDelta_{max}
=
max(
widehatDelta_L,
widehatDelta_H
).
]

The efficacy classification is:

[
egin{cases}
widehatDelta_{max}<5% & 	ext{No-Go leaning}\
5%lewidehatDelta_{max}<10% & 	ext{Consider}\
widehatDelta_{max}ge10% & 	ext{Go leaning}
end{cases}
]

This classification remains contextual and is not an automatic development decision.

## Files

R code:

`simulation/cp_crc_vitality_style_focused.R`

Expected output:

`simulation/results/cp_crc_vitality_style_focused_N44_v1_5.csv`

Final classification OC:

`simulation/results/cp_final_classification_grid_v1_1.csv`
