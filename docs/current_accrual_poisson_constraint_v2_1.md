# Current Poisson accrual constraint after Stage 1

**Version:** 2.1  
**Date:** 29 September 2026  
**Status:** Current operational model aligned with the frozen N=50/arm, Stage 1 first-54 design.

## 1. Purpose

The primary endpoint matures with a substantial delay. Therefore, even after the first 54 randomized participants have fixed Stage 1 membership, additional participants may be randomized before the Stage 1 Conditional Power decision becomes available.

To preserve the practical value of a binding futility decision, the current operational target is:

[
P{N_{IA}ge lceil 0.70N_{total}ceil}le0.05.
]

This is a **budget / commitment constraint**, not a type-I-error or other inferential error constraint.

## 2. Current design

[
N_{total}=150,qquad N_1=54.
]

Hence:

[
B=lceil0.70	imes150ceil=105.
]

If (X) is the number randomized after the Stage 1 cohort is complete but before the CP decision, crossing the budget boundary means:

[
Xge105-54=51.
]

## 3. Poisson process model

During the endpoint-maturation period of length (L) months:

[
Xsim Poisson(r_{slow}L),
]

where (r_{slow}) is the average post-Stage-1 randomization rate.

The operational constraint becomes:

[
P{Poisson(r_{slow}L)ge51}le0.05.
]

Let (lambda_{max}) solve:

[
P{Poisson(lambda_{max})ge51}=0.05.
]

The exact numerical solution is:

[
lambda_{max}approx39.8487.
]

Therefore:

[
oxed{r_{slow,max}=39.8487/L}.
]

If the ordinary randomization rate is (r_0), the largest fraction that can be retained is:

[
oxed{s_{max}=minleft(1,rac{r_{slow,max}}{r_0}ight)}.
]

## 4. Operational table

| Endpoint maturity L | Max post-S1 rate/month | Retain if r0=6 | Retain if r0=9 | Retain if r0=12 |
|---:|---:|---:|---:|---:|
|4 months|9.96|100%|100%|83.0%|
|5 months|7.97|100%|88.6%|66.4%|
|6 months|6.64|100%|73.8%|55.3%|

For the central operational assumption:

[
r_0=9/month,qquad L=6 months,
]

the maximum rate is approximately:

[
6.64/month,
]

or:

[
73.8%
]

of ordinary recruitment.

With no slowdown, (Xsim Poisson(54)) and:

[
P(N_{IA}ge105)=P(Xge51)approx67.7%.
]

At the derived rate of approximately 6.64/month, the same probability is 5%.

## 5. Operational implementation

After the 54th randomized participant:

1. initiate the prespecified accrual slowdown;
2. derive the allowable rate from the current (L) and expected ordinary rate (r_0);
3. if ordinary accrual is already below the allowed absolute rate, no artificial slowing is required;
4. if ordinary accrual exceeds the limit, use site-level enrollment pacing, screening/randomization caps, or equivalent operational controls to keep the overall average rate below the calculated cap;
5. after Project Go, restore ordinary accrual; after Project No-Go, stop new randomization;
6. if observed accrual speed or endpoint maturity differs materially from assumptions, recalculate the allowed cap.

Under the central (r_0=9/month, L=6) scenario, the theoretical upper rate is 6.64/month. Operational implementation may choose a slightly lower target to provide margin.

## 6. Relationship to the 35% Stage 1 timing

The Poisson model strengthens the operational argument for the first-54 (approximately 35%) Stage 1 look. Earlier Stage 1 timing leaves more pipeline headroom before the 70% boundary and therefore permits a less severe slowdown while preserving the same 5% commitment-risk criterion.

## Reproducibility

R code:

`simulation/current_accrual_poisson_constraint_v2_1.R`

Results:

`simulation/results/current_accrual_poisson_constraint_v2_1.csv`
