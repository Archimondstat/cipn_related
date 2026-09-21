# Focused VITALITY-style CRC Boundary Table v1.4

Date: 2026-09-21  
Status: presentation table; no design selected

## Fixed definition

All tables use:

[
oxed{
	ext{Treatment effect}
=
p_{	ext{Placebo}}
-
p_{	ext{Treatment}}
}
]

Positive values favor treatment.

For Stage 1 with equal nominal sample size per arm:

[
widehat{Delta}_1
=
rac{x_{P1}-x_{T1}}{n_1}.
]

Therefore each displayed treatment-effect boundary has a direct **event-count difference**:

[
D=x_{P1}-x_{T1}.
]

The arm-level futility rule is:

[
x_{P1}-x_{T1}le D.
]

This event-count column is shown only because the current design-calibration tables assume equal Stage 1 sample sizes per arm. The final R/SAS implementation will calculate CP from actual (n_P,n_T,x_P,x_T) and will not depend on a fixed event-count-difference rule.

## Frozen CRC efficacy assumptions

[
p_{	ext{Placebo}}=45%,qquad
p_{	ext{Treatment}}=30%,
]

so:

[
oxed{	ext{Target treatment effect}=15%}.
]

Operating-characteristic scenarios shown:

- true treatment effect = 0%: no efficacy;
- true treatment effect = 5%: weak efficacy;
- true treatment effect = 15%: target efficacy.

## N=44/arm focused comparison

| Stage 1 information | nominal n1/arm | Interim treatment-effect boundary | Event-count difference (x_P-x_T) at boundary | Interpretation at boundary | Individual CP | Joint CP | P(overall futility), true effect=0% | P(overall futility), true effect=5% | P(overall futility), true effect=15% |
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

## Example

At 50% information, nominally (n_1=22) per arm.

A treatment-effect boundary of 9.09% is:

[
9.09%=rac{2}{22}.
]

Thus its event-count boundary is:

[
D=+2.
]

The futility criterion is:

[
x_{P1}-x_{T1}le2.
]

So an observed difference of 0, 1, or 2 more events in placebo than treatment still falls inside the futility region; a difference of 3 or more events in placebo than treatment does not.

## Files

R code:

`simulation/cp_crc_vitality_style_focused.R`

Updated focused result table:

`simulation/results/cp_crc_vitality_style_focused_N44_v1_4.csv`
