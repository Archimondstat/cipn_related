# CRC Full OC Calibration v0.6 — Important Discreteness Finding

Date: 2026-09-21  
Status: exploratory; CRC efficacy assumptions unchanged

The CRC efficacy assumptions remain frozen at:

[
p_P=45%,qquad p_T=30%,qquad ARR_{target}=15%.
]

The maximum sample size (N) is now allowed to vary.

## Why the final-Go probability cannot yet be used mechanically to choose N

The current working final Phase II Go rule is:

[
widehat{ARR}_{final}ge10%.
]

For equal final arm sizes (N), this is equivalent to requiring an integer event-count difference:

[
X_P-X_Tgelceil0.10Nceil.
]

Therefore different candidate values of (N) correspond to slightly different **effective** ARR thresholds:

| N/arm | Required placebo-treatment event difference | Effective minimum observed ARR |
|---:|---:|---:|
| 36 | 4 | 11.11% |
| 40 | 4 | 10.00% |
| 44 | 5 | 11.36% |
| 48 | 5 | 10.42% |
| 52 | 6 | 11.54% |

This creates visible non-monotonicity in the probability of final program Go as (N) changes.

For example, with approximately 50% Stage 1 information and conservative/moderate futility settings, the probability of final program Go when one dose has true ARR=15% is around:

- (N=36): about 69-70%;
- (N=40): about 73-74%;
- (N=44): about 69%;
- (N=48): about 72-73%;
- (N=52): about 69%.

This oscillation should **not** be interpreted as larger sample sizes being worse. It is primarily caused by the provisional 10% observed-ARR success rule crossing integer event-count boundaries.

## Consequence for design selection

The current (N	imes f_1	imes c_F) grid remains useful for:

- Stage 1 null stopping probability;
- false futility for a target-effective dose;
- expected sample size;
- Design A vs Design B sample-size savings;
- final estimation precision.

However, the final-Go probability should be treated cautiously until the final Phase II success criterion is specified in a way suitable for sample-size calibration.

The CRC treatment-effect assumption itself does **not** need to change.

## Exact code

The new code calculates exact full operating characteristics for both candidate policies:

`simulation/cp_full_oc_calibration_crc.R`

It also writes a separate table showing the event-count lattice induced by the working 10% final-Go rule.
