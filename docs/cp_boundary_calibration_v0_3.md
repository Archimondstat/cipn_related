# CP Boundary Calibration v0.3 — Exact Stage 1 Grid

Date: 2026-09-21  
Status: exploratory; no boundary selected

## What changed from v0.2

The boundary-calibration step has been rewritten as **exact enumeration**, not Monte Carlo simulation.

For each candidate design, the code enumerates all possible Stage 1 event counts:

[
x_P=0,ldots,n_1,quad
x_L=0,ldots,n_1,quad
x_H=0,ldots,n_1
]

and weights each state by its exact binomial probability.

Therefore the Stage 1 operating characteristics below have no Monte Carlo error.

Reproducible R code:

`simulation/cp_boundary_calibration_exact.R`

## Primary calibration grid

CRC working assumptions:

- placebo event rate (p_P=45%);
- target active event rate (p_T=30%);
- maximum (N=44) per arm;
- design-alternative CP:
  [
  p_P^{future}=45%,quad p_T^{future}=30%;
  ]
- Stage 1 candidate sizes:
  [
  n_1=18, 22, 26	ext{ per arm};
  ]
- provisional final-Go ARR thresholds:
  [
  delta_{Go}=5%, 7.5%, 10%;
  ]
- CP futility cutoffs:
  [
  c_F=5%, 10%, 15%, 20%.
  ]

True treatment-effect scenarios use the full Low/High grid:

[
ARR_L,ARR_Hin{0,5,10,15,20%}.
]

## Key first-look table: provisional final-Go ARR = 10%

| (n_1)/arm | (c_F) | Overall No-Go if both doses truly 0% | Drop a truly 15% ARR dose | Overall false No-Go if one dose =15%, other=0% | Overall false No-Go if both =15% |
|---:|---:|---:|---:|---:|---:|
| 18 | 5% | 0.6% | 0.2% | 0.1% | <0.1% |
| 18 | 10% | 4.1% | 1.6% | 0.8% | 0.2% |
| 18 | 15% | 8.7% | 3.6% | 2.2% | 0.7% |
| 18 | 20% | 8.7% | 3.6% | 2.2% | 0.7% |
| 22 | 5% | 5.4% | 1.6% | 0.9% | 0.2% |
| 22 | 10% | 10.2% | 3.4% | 2.2% | 0.7% |
| 22 | 15% | 10.2% | 3.4% | 2.2% | 0.7% |
| 22 | 20% | 17.6% | 6.6% | 4.7% | 1.8% |
| 26 | 5% | 11.5% | 3.2% | 2.2% | 0.7% |
| 26 | 10% | 18.7% | 5.9% | 4.4% | 1.6% |
| 26 | 15% | 18.7% | 5.9% | 4.4% | 1.6% |
| 26 | 20% | 28.0% | 10.1% | 8.1% | 3.4% |

The 15% and 20% CP cutoffs are sometimes identical because the binary endpoint produces a discrete set of attainable CP values.

## Structural finding: the CP boundary is discrete

Under the current **design-alternative CP** assumption, future placebo and treatment event rates are fixed.

With equal Stage 1 and final arm sizes and a final criterion based only on ARR, the CP for an active-vs-placebo comparison depends on the current Stage 1 event-count difference:

[
d_1=x_{P1}-x_{T1}.
]

Thus a CP cutoff ultimately maps to an integer event-count boundary.

Example:

[
N=44,quad n_1=22,quad delta_{Go}=10%,quad c_F=10%.
]

The relevant CP values include approximately:

| Stage 1 difference (d_1=x_P-x_T) | CP |
|---:|---:|
| -3 | <10% |
| -2 | 15.6% |
| -1 | 24.5% |
| 0 | 35.5% |
| 1 | 47.8% |
| 2 | 60.2% |

Therefore the current rule is effectively:

[
d_1le -3Rightarrow	ext{futility}.
]

For an unfavorable endpoint, (d_1=-3) means the active arm has at least three **more** CTCAE grade >=2 events than placebo at Stage 1.

This explains why design-alternative CP with a low cutoff is very conservative: an active dose can show no numerical benefit, or even modest numerical worsening, without entering the futility region.

## Design A versus Design B

For any fixed ((n_1,delta_{Go},c_F)):

[
P(	ext{overall Stage 1 No-Go})
]

is identical for Design A and Design B.

The difference is the handling of exactly one futile dose.

- Design A drops that dose.
- Design B retains it.

At the working setting:

[
n_1=22,quaddelta_{Go}=10%,quad c_F=10%,
]

when one dose truly has ARR=15% and the other ARR=0%:

- target-effective dose enters the futility region about 3.4%;
- overall false No-Go is about 2.2%;
- Design A saves about 4.7 randomized subjects on average versus Design B, before considering operational overrun.

Under the global null, Design A saves about 5.4 subjects on average versus Design B, again before overrun.

## Interpretation

The current design-alternative CP rule strongly protects a truly effective dose, but its ability to stop a completely ineffective program early is modest for conservative cutoffs.

This is not yet a reason to increase (c_F) mechanically.

The next boundary discussion should explicitly decide how much false-futility risk is acceptable. For example, the department may wish to compare candidate rules that keep:

[
P(	ext{drop a truly 15% ARR dose})
]

below a chosen tolerance while maximizing:

[
P(	ext{overall Stage 1 No-Go}mid ARR_L=ARR_H=0).
]

Any such tolerance remains a development decision and has not yet been fixed.

## Files

- exact calibration code: `simulation/cp_boundary_calibration_exact.R`
- earlier Monte Carlo policy comparison: `simulation/cp_design_comparison.R`
- two candidate designs: `docs/cp_two_candidate_designs.md`

Operational overrun, recruitment slowdown, safety override, and any earlier endpoint remain deliberately excluded from v0.3.
