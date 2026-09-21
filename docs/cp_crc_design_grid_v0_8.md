# CRC Design Grid v0.8 — Stage 1 at 40%, 50%, and 60%

Date: 2026-09-21  
Status: design-calibration framework; no design selected

## Frozen CRC efficacy assumptions

[
p_P=45%,qquad p_T=30%,qquad ARR_{target}=15%.
]

These assumptions remain unchanged.

The design search now treats the following as separate dimensions:

[
oxed{N}
]

maximum efficacy-evaluable sample size per arm,

[
oxed{f_1}
]

nominal Stage 1 information fraction,

and

[
oxed{c_F}
]

conditional-power futility cutoff.

## Stage 1 information fractions

The design-calibration grid explicitly evaluates:

[
f_1=40%,quad 50%,quad 60%.
]

For each candidate maximum (N), the nominal Stage 1 mature sample size is:

[
n_{1,nominal}approx f_1N.
]

Examples:

| Maximum N/arm | 40% | 50% | 60% |
|---:|---:|---:|---:|
| 36 | 14 | 18 | 22 |
| 40 | 16 | 20 | 24 |
| 44 | 18 | 22 | 26 |
| 48 | 19 | 24 | 29 |
| 52 | 21 | 26 | 31 |

These are **design-calibration values**, not rigid interim sample sizes.

At the actual interim analysis, conditional power will be calculated from the actual mature/evaluable sample sizes and event counts in each arm.

## Why all three Stage 1 fractions need to remain in the design table

The information fraction changes a real development trade-off.

An earlier interim (approximately 40%) offers more opportunity to save subjects and time if the program is futile, but has less information and therefore generally requires a more conservative futility rule to protect a truly active dose.

A later interim (approximately 60%) has more reliable information but leaves less trial remaining to save.

The 50% analysis is therefore only a natural central reference, not a default final choice.

## Presentation structure

The complete table now contains:

[
Nin{36,40,44,48,52},
]

[
f_1in{40%,50%,60%},
]

and

[
c_Fin{5%,10%,15%,20%}.
]

For every combination it reports:

- actual nominal (n_1) after rounding;
- the integer Stage 1 event-count boundary implied by the CP cutoff;
- overall Stage 1 No-Go under the global null;
- overall Stage 1 No-Go when both doses have only 5% ARR;
- futility probability for a truly 15% ARR dose;
- overall false No-Go when one dose has 15% ARR and the other is null;
- overall false No-Go when both doses have 15% ARR;
- expected sample size for Design A and Design B;
- incremental sample-size saving from arm dropping;
- final ARR precision.

## Files

Full grid:

`simulation/results/cp_crc_N_f1_cF_tradeoff_v0_8.csv`

Separate review tables:

- `simulation/results/cp_crc_f1_40_tradeoff_v0_8.csv`
- `simulation/results/cp_crc_f1_50_tradeoff_v0_8.csv`
- `simulation/results/cp_crc_f1_60_tradeoff_v0_8.csv`

Reproducible presentation code:

`simulation/cp_crc_N_f1_boundary_table.R`

This is the table structure that should be used for the next design-screening step.
