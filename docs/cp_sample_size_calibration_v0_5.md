# CRC Sample-size Calibration Plan v0.5

Date: 2026-09-21  
Status: working design grid; CRC efficacy assumptions frozen

## Frozen efficacy assumptions

For the next calibration step, the CRC efficacy assumptions are deliberately kept unchanged:

[
p_P=45%,qquad p_T=30%,qquad ARR_{target}=15%.
]

These are the treatment-effect assumptions used to judge whether a candidate design adequately protects a clinically target-effective dose.

The previous (N=44) per arm is no longer treated as fixed. It remains an anchor from the earlier precision-based calculation.

The provisional final Phase II Go rule remains:

[
widehat{ARR}_{final}ge10%.
]

This 10% value is a working decision-rule parameter, not the assumed treatment effect.

## New design grid

Candidate maximum efficacy-evaluable sample sizes:

[
N=36, 40, 44, 48, 52	ext{ per arm}.
]

Candidate nominal Stage 1 information fractions:

[
f_1=40%, 50%, 60%.
]

Candidate CP futility cutoffs:

[
c_F=5%, 10%, 15%, 20%.
]

For design calibration only:

[
n_1approx f_1N
]

is rounded to the nearest integer per arm.

The eventual operational CP program will use the actual mature sample size in each arm and will not require equal (n_P,n_L,n_H).

## Outputs

For each ((N,f_1,c_F)), exact Stage 1 enumeration will report:

- (P(	ext{overall No-Go}mid ARR_L=ARR_H=0));
- futility probability for a truly ARR=15% dose;
- (P(	ext{overall false No-Go}mid 15%,0));
- (P(	ext{overall false No-Go}mid 15%,15%));
- expected sample size for Design A and Design B, excluding operational overrun;
- incremental sample-size saving from arm dropping;
- approximate final 95% CI half-width for ARR under (p_P=45%, p_T=30%).

The CI half-width is retained as a precision descriptor only; it no longer determines the sample size.

## Code

`simulation/cp_sample_size_calibration_crc.R`

This step keeps the efficacy assumptions fixed and varies only the design dimensions (N,f_1,c_F).
