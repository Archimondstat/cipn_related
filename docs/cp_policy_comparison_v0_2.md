# CP Design A vs Design B — First Policy Comparison

Date: 2026-09-21  
Status: exploratory only; no design parameter selected

## Objective

Compare the two candidate conditional-power policies under the same Stage 1 data and the same CP calculation.

- **Design A:** arm-wise futility + dose dropping; overall No-Go if both doses are futile.
- **Design B:** project-level futility only; no individual dose dropping; overall No-Go if both doses are futile.

Because both policies use the same rule for overall Stage 1 No-Go, their **Stage 1 overall No-Go probability is identical** for a fixed CP calculation and cutoff. Their difference arises only when exactly one dose is in the futility region.

## Provisional first-look setting

CRC working assumptions:

- placebo CTCAE grade >=2 event rate: 45%
- target active event rate: 30%
- target ARR: 15%
- maximum N: 44/arm
- Stage 1: 22/arm
- CP future-data assumption: design alternative, (p_P^{future}=0.45, p_T^{future}=0.30)
- provisional final-Go rule: observed final ARR >=10%
- CP futility cutoff: 10%

The 10% final-Go rule and 10% CP cutoff are working values only.

## Numerical first look

Approximate operating characteristics from 500,000 simulated trial paths per scenario:

| True scenario | Stage 1 overall No-Go | Low futility signal | High futility signal | Final program Go — A | Final program Go — B | E[N] A | E[N] B |
|---|---:|---:|---:|---:|---:|---:|---:|
| ARR (0%, 0%) | 10.4% | 22.6% | 22.5% | ~26.5% | ~26.6% | ~119.9 | ~125.3 |
| ARR (5%, 5%) | 5.0% | 13.6% | 13.7% | ~45.3% | ~45.4% | ~125.0 | ~128.8 |
| ARR (15%, 0%) | 2.2% | 3.5% | 22.4% | ~69.2% | ~69.3% | ~125.8 | ~130.5 |
| ARR (0%, 15%) | 2.2% | 22.4% | 3.4% | ~69.2% | ~69.3% | ~125.8 | ~130.5 |
| ARR (15%, 15%) | 0.7% | 3.4% | 3.4% | ~82.1% | ~82.2% | ~130.3 | ~131.5 |

Numbers are rounded and intended only as a first policy comparison.

## Main observation

Under this **particular provisional setting**, Design A saves subjects by dropping a single futile dose, while the reduction in final program-Go probability relative to Design B is very small.

For example, when one dose has the 15% target ARR and the other is inactive:

- Design A saves roughly 4-5 randomized subjects on average relative to Design B;
- the target-effective dose enters the Stage 1 futility region about 3-4% of the time;
- the difference in final program-Go probability between A and B is <0.1 percentage point in this first look.

This occurs because, under design-alternative CP with a low futility cutoff, an arm is dropped mainly in trial paths where its probability of ultimately satisfying the provisional final-Go rule is already very low.

This result **must not yet be interpreted as evidence that Design A is superior**, because:

1. the final-Go rule is still provisional;
2. the CP future-effect assumption is not finalized;
3. no operational overrun is included;
4. recruitment slowdown may reduce the practical sample-size saving from dose dropping;
5. no earlier endpoint, safety override, or missing-data process is modeled.

## Important structural point

For a fixed CP rule:

[
P(	ext{Stage 1 overall No-Go})
]

is the same for Design A and Design B.

Therefore the policy comparison is fundamentally about:

[
oxed{	ext{efficiency gained by dropping one futile arm}}
]

versus

[
oxed{	ext{risk of prematurely dropping an arm that could later have been useful}}.
]

This should be the main comparison criterion between the two designs.

## Next calibration step

Before adding accrual/overrun, compare the policies across:

- Stage 1 information: 18, 22, 26 subjects/arm;
- provisional final-Go ARR: 5%, 7.5%, 10%;
- CP cutoff: 5%, 10%, 15%, 20%;
- clinically relevant true-effect scenarios including 0%, 5%, 10%, 15%, 20% ARR.

Primary outputs:

- overall Stage 1 No-Go;
- individual futility signal;
- wrong drop of a target-effective dose (Design A);
- final program-Go probability;
- expected sample size;
- expected sample-size saving of Design A versus Design B.

Only after this grid is understood should the operational 4-6 month endpoint delay and slowdown/overrun module be added.
