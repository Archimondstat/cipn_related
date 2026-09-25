# Matched Stage 1 signal comparison: 35% versus 40%

**Version:** 1.0  
**Date:** 25 September 2026  
**Status:** Working comparison; no final design selected.

## 1. Why compare a matched event-count rule?

Nominal CP cutoffs are discrete in this small binary-endpoint design. A threshold such as 65% can correspond to a two-event advantage in one design and a three-event advantage in another.

To compare IA timing itself, use the same attainable Stage 1 signal:

[
oxed{
max(x_P-x_L, x_P-x_H)ge2
}
]

i.e. at least one AK135 dose has at least two fewer CTCAE grade >=2 CIPN events than placebo at Stage 1.

This is a diagnostic comparison, not a proposal to replace CP by an event-count rule.

## 2. CP corresponding to a two-event advantage

For an individual dose, the exact CP values around the two-event boundary are:

| N/arm | IA | n1/arm | CP at D=1 | CP at D=2 | CP threshold interval that gives exactly D>=2 |
|---:|---:|---:|---:|---:|---|
|44|35%|15|59.4%|69.6%|(59.4%, 69.6%]|
|44|40%|18|54.9%|65.9%|(54.9%, 65.9%]|
|48|35%|17|62.2%|71.7%|(62.2%, 71.7%]|
|48|40%|19|59.4%|69.6%|(59.4%, 69.6%]|
|52|35%|18|56.3%|65.9%|(56.3%, 65.9%]|
|52|40%|21|51.8%|62.2%|(51.8%, 62.2%]|

Thus 65% implements the same two-event rule for all 35%/40% candidates except N=52, IA=40%, where 65% jumps to a three-event requirement. A threshold around 60% would implement the two-event rule for that design.

## 3. Exact Go probabilities under the matched two-event rule

| N/arm | IA | n1/arm | Boundary observed RD | P(Go|0%) | P(Go|5%) | P(Go|10%) | P(Go|15%) | P(Go|20%) |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|44|35%|15|13.3%|43.1%|54.9%|66.4%|76.7%|85.3%|
|44|40%|18|11.1%|45.1%|58.1%|70.4%|80.9%|89.0%|
|48|35%|17|11.8%|44.5%|57.1%|69.2%|79.7%|87.9%|
|48|40%|19|10.5%|45.7%|59.0%|71.6%|82.1%|90.0%|
|52|35%|18|11.1%|45.1%|58.1%|70.4%|80.9%|89.0%|
|52|40%|21|9.5%|46.8%|60.8%|73.6%|84.2%|91.7%|

## 4. Incremental statistical gain from waiting to 40%

With the same two-event rule:

| N/arm | Increase in P(Go|0%) | Increase in P(Go|15%) | Improvement in separation [P(Go|15)-P(Go|0)] |
|---:|---:|---:|---:|
|44|+2.1 pp|+4.2 pp|+2.1 pp|
|48|+1.2 pp|+2.4 pp|+1.2 pp|
|52|+1.6 pp|+3.2 pp|+1.6 pp|

Thus waiting from 35% to 40% gives a modest statistical improvement when the actual event-count rule is held constant.

## 5. Operational cost of waiting to 40%

Under the existing illustrative operational scenario of endpoint delay L=6 months and ordinary accrual r0=9 participants/month:

| N/arm | Post-S1 accrual retained at 35% | Post-S1 accrual retained at 40% | Approx decision month 35% | Approx decision month 40% |
|---:|---:|---:|---:|---:|
|44|68.9%|54.3%|11.0|12.0|
|48|72.2%|62.4%|11.7|12.3|
|52|82.0%|67.3%|12.0|13.0|

The statistical gain from 40% therefore needs to be weighed against a stronger slowdown and a later decision.

## 6. Interpretation

The matched comparison clarifies that the apparent differences between some 65%, 70%, and 75% CP designs are driven mainly by whether the nominal threshold crosses an integer event-count boundary.

For the current early No-Go objective, a two-event Stage 1 advantage provides a useful reference region:

[
P(GomidDelta=15%)approx77%-84%,
]

while

[
P(GomidDelta=0)approx43%-47%.
]

Moving from 35% to 40% improves target-effect preservation by only about 2-4 percentage points under the matched signal, while operational burden increases.

This note does not select 35% or 40%. It isolates the incremental statistical value of the later look.
