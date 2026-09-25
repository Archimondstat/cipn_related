# Operational screen: 35% versus 40% Stage 1

**Version:** 0.5  
**Date:** 25 September 2026  
**Status:** Operational/budget comparison only; CP statistical performance intentionally excluded.

## 1. Question

Given the working budget constraint

[
P{N_{IA}ge lceil 0.70Nceil}le 0.05,
]

compare 35% versus 40% Stage 1 timing across:

- maximum N per arm = 44, 48, 52;
- endpoint maturity delay L = 4, 5, 6 months;
- ordinary accrual rates = 6, 9, 12 participants/month.

The Stage 1 slowdown is assumed to start when the prespecified Stage 1 cohort has completed randomization. The CP analysis occurs when that cohort's primary endpoint is mature.

## 2. Maximum allowable post-Stage-1 absolute accrual rate

Under the Poisson pipeline model,

[
Xsim Poisson(r_{slow}L),
]

and the budget constraint determines an exact upper bound on the absolute post-Stage-1 accrual rate:

[
r_{slow,max}=rac{lambda_{0.05}(k)}{L},
]

where

[
k=lceil0.70Nceil-N_1.
]

This rate depends on N, Stage 1 timing, and endpoint delay, but not on the pre-slowdown ordinary accrual rate.

| N/arm | Stage 1 | L=4 mo | L=5 mo | L=6 mo |
|---:|---:|---:|---:|---:|
| 44 | 35% | 9.30/mo | 7.44/mo | 6.20/mo |
| 44 | 40% | 7.33/mo | 5.87/mo | 4.89/mo |
| 48 | 35% | 9.74/mo | 7.79/mo | 6.49/mo |
| 48 | 40% | 8.42/mo | 6.74/mo | 5.61/mo |
| 52 | 35% | 11.07/mo | 8.86/mo | 7.38/mo |
| 52 | 40% | 9.08/mo | 7.26/mo | 6.05/mo |

Across every N and endpoint-delay assumption, the 35% look allows a higher post-Stage-1 accrual rate than the 40% look.

## 3. Six-month endpoint: required slowdown from ordinary accrual

### Ordinary accrual = 9/month

| N/arm | 35% Stage 1 | 40% Stage 1 |
|---:|---:|---:|
| 44 | retain 68.9% | retain 54.3% |
| 48 | retain 72.2% | retain 62.4% |
| 52 | retain 82.0% | retain 67.3% |

### Ordinary accrual = 12/month

| N/arm | 35% Stage 1 | 40% Stage 1 |
|---:|---:|---:|
| 44 | retain 51.7% | retain 40.7% |
| 48 | retain 54.1% | retain 46.8% |
| 52 | retain 61.5% | retain 50.4% |

Thus the operational difference between 35% and 40% is not small when the endpoint is delayed and recruitment is fast.

## 4. Calendar penalty if Stage 1 ultimately continues

If recruitment is slowed to the maximum rate allowed by the budget constraint and the ordinary rate is restored immediately after a positive Stage 1 decision, then under the deterministic rate approximation:

[
Delta T_{Go}
=
Lleft(1-rac{r_{slow}}{r_0}ight)_+.
]

For L=6 months:

| N/arm | Ordinary rate | 35% Stage 1 penalty | 40% Stage 1 penalty |
|---:|---:|---:|---:|
| 44 | 6/mo | 0.00 mo | 1.11 mo |
| 44 | 9/mo | 1.87 mo | 2.74 mo |
| 44 | 12/mo | 2.90 mo | 3.56 mo |
| 48 | 6/mo | 0.00 mo | 0.39 mo |
| 48 | 9/mo | 1.67 mo | 2.26 mo |
| 48 | 12/mo | 2.75 mo | 3.19 mo |
| 52 | 6/mo | 0.00 mo | 0.00 mo |
| 52 | 9/mo | 1.08 mo | 1.96 mo |
| 52 | 12/mo | 2.31 mo | 2.97 mo |

The 35% look therefore also creates a smaller calendar penalty under Go.

## 5. Interim calendar time

The CP decision is expected at approximately

[
t_{IA}=rac{N_1}{r_0}+L.
]

Because the 35% cohort is smaller than the 40% cohort, its decision is also available earlier.

Stage 1 total sample sizes are:

| N/arm | 35% nominal | Actual fraction | 40% nominal | Actual fraction |
|---:|---:|---:|---:|---:|
| 44 | 45 total | 34.1% | 54 total | 40.9% |
| 48 | 51 total | 35.4% | 57 total | 39.6% |
| 52 | 54 total | 34.6% | 63 total | 40.4% |

For example, at 9/month and L=6:

- N=44/arm: 35% decision about month 11.0; 40% about month 12.0;
- N=48/arm: 35% about month 11.7; 40% about month 12.3;
- N=52/arm: 35% about month 12.0; 40% about month 13.0.

## 6. Operational conclusion

Under the current 70% / 5% budget constraint, **35% Stage 1 operationally dominates 40% Stage 1** in the dimensions examined here:

- the slowdown instruction is triggered earlier;
- more pipeline recruitment can be tolerated;
- the CP decision becomes available earlier;
- the Go-case calendar penalty is smaller;
- the same budget-risk constraint is maintained.

This is an operational statement only.

It does **not** establish that 35% is the better statistical design, because the 35% CP decision uses less mature information and may have worse false-No-Go, dose-selection, or decision-stability properties.

Therefore 40% should survive as a candidate only if the additional statistical information produces enough improvement in CP operating characteristics to justify its operational cost.

## 7. Implication for the next step

The design comparison can now be reduced to a clean question:

> What statistical improvement is gained by waiting from approximately 35% to 40% mature information, and is that gain worth the stronger slowdown and later decision required by the budget constraint?

The next analysis should therefore compare 35% versus 40% CP operating characteristics for N=44, 48, 52 per arm using the same final-Go rule and the current CP future-effect assumptions.

No 45% or 50% timing is needed in the primary operational screen unless later CP results provide a specific reason to reconsider them.
