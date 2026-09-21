# Focused VITALITY-style CRC Boundary Table v1.3

Date: 2026-09-21  
Status: presentation table; no design selected

## Fixed definition

All subsequent tables use one treatment-effect definition only:

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

## Frozen CRC efficacy assumptions

[
p_{	ext{Placebo}}=45%,qquad
p_{	ext{Treatment}}=30%,
]

therefore:

[
oxed{
	ext{Target treatment effect}=15%
}
]

The main operating-characteristic scenarios shown are:

- true treatment effect = 0%: no efficacy;
- true treatment effect = 5%: weak efficacy;
- true treatment effect = 15%: target efficacy.

## Presentation principle

Strongly negative interim boundaries are no longer emphasized.

The main table retains only:

- one slightly negative boundary as a conservative reference;
- 0% treatment effect;
- approximately +5%;
- approximately +10%.

Because the endpoint is binary, the exact observed treatment-effect boundary depends on the nominal Stage 1 sample size.

## N=44/arm focused comparison

| Stage 1 information | nominal n1/arm | Interim treatment-effect boundary | Individual CP | Joint CP | P(overall futility), true effect=0% | P(overall futility), true effect=5% | P(overall futility), true effect=15% | P(any final effect >=15% / >=10% / >=5%) |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 40% | 18 | -5.56% | 32.32% | 46.26% | 27.00% | 17.12% | 4.94% | 23.32% / 46.26% / 70.60% |
| 40% | 18 | 0.00% | 43.34% | 58.85% | 40.34% | 28.23% | 10.36% | 34.05% / 58.85% / 80.53% |
| 40% | 18 | 5.56% | 54.86% | 70.60% | 54.85% | 41.89% | 19.07% | 46.26% / 70.60% / 88.12% |
| 40% | 18 | 11.11% | 65.95% | 80.53% | 68.68% | 56.56% | 31.16% | 58.85% / 80.53% / 93.35% |
| 50% | 22 | -4.55% | 24.52% | 36.49% | 27.57% | 16.67% | 4.09% | 14.99% / 36.49% / 63.51% |
| 50% | 22 | 0.00% | 35.49% | 49.99% | 39.65% | 26.46% | 8.24% | 24.48% / 49.99% / 75.54% |
| 50% | 22 | 4.55% | 47.76% | 63.51% | 52.76% | 38.47% | 14.93% | 36.49% / 63.51% / 85.07% |
| 50% | 22 | 9.09% | 60.19% | 75.54% | 65.53% | 51.66% | 24.46% | 49.99% / 75.54% / 91.76% |
| 60% | 26 | -3.85% | 16.45% | 25.59% | 28.01% | 16.21% | 3.39% | 7.70% / 25.59% / 54.33% |
| 60% | 26 | 0.00% | 26.68% | 39.22% | 39.13% | 24.98% | 6.65% | 14.93% / 39.22% / 68.84% |
| 60% | 26 | 3.85% | 39.30% | 54.33% | 51.16% | 35.73% | 11.88% | 25.59% / 54.33% / 80.93% |
| 60% | 26 | 11.54% | 66.43% | 80.93% | 73.77% | 59.86% | 29.40% | 54.33% / 80.93% / 95.06% |

## How to read the main decision region

The rows near 0%-10% are the development-relevant region.

For example, at 50% Stage 1 information:

- a 0% boundary stops about 39.7% of truly null programs, but falsely stops about 8.2% of programs where both doses truly achieve the 15% target effect;
- an approximately 5% boundary increases null stopping to about 52.8%, but raises target-effect false futility to about 14.9%;
- an approximately 10% boundary increases null stopping to about 65.5%, but raises target-effect false futility to about 24.5%.

The 5% true-effect column is included because current medical input regards approximately 0%-5% treatment effect as having limited development value.

## Files

R code:

`simulation/cp_crc_vitality_style_focused.R`

Focused result table:

`simulation/results/cp_crc_vitality_style_focused_N44_v1_3.csv`
