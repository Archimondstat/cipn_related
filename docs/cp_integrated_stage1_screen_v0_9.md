# Integrated Stage 1 screen: CP boundary and operational timing

**Version:** 0.9  
**Date:** 25 September 2026  
**Status:** Working design comparison; no final selection.

## 1. Candidate space

Current Stage 1 candidates:

[
N=44,48,52	ext{ per arm},
qquad
f_1=35%,40%,45%,
qquad
c=65%,70%,75%.
]

The simplified project-level rule is:

[
M=max(CP_L,CP_H),
]

[
Mge cRightarrow	ext{Go to Stage 2},
qquad
M<cRightarrow	ext{No-Go}.
]

CP continues to use future event-rate assumptions (p_P=0.45), (p_T=0.30), with final promising threshold (widehatDelta_Fge10%).

Operational calculations are kept conceptually separate. The working budget constraint is:

[
P{N_{IA}ge lceil0.70Nceil}le0.05.
]

For illustration, the combined table below uses endpoint delay (L=6) months and ordinary accrual (r_0=9) participants/month.

## 2. Key statistical finding: later IA is not automatically better

At a fixed nominal CP threshold, the actual decision rule is discrete. As the IA moves later, the amount of future information shrinks, so the same observed event difference can produce a lower CP.

Consequently, moving from 35% to 40% or 45% can cause the minimum event-count advantage needed for Go to jump from 2 events to 3 or 4 events.

This creates non-monotone Stage 1 Go probabilities across IA timings.

## 3. Integrated comparison at CP=65%

| N/arm | IA | n1/arm | Minimum event advantage for one dose | Observed RD at boundary | P(Go|Δ=0) | P(Go|Δ=15%) | Post-S1 accrual retained (L=6,r0=9) | Approx IA decision month |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|44|35%|15|2|13.3%|43.1%|76.7%|68.9%|11.0|
|44|40%|18|2|11.1%|45.1%|80.9%|54.3%|12.0|
|44|45%|20|3|15.0%|33.0%|72.5%|44.7%|12.7|
|48|35%|17|2|11.8%|44.5%|79.7%|72.2%|11.7|
|48|40%|19|2|10.5%|45.7%|82.1%|62.4%|12.3|
|48|45%|22|2|9.1%|47.2%|85.1%|47.9%|13.3|
|52|35%|18|2|11.1%|45.1%|80.9%|82.0%|12.0|
|52|40%|21|3|14.3%|33.8%|74.1%|67.3%|13.0|
|52|45%|23|3|13.0%|35.1%|76.9%|57.5%|13.7|

## 4. What the 65% boundary means

For several candidate designs, (CPge65%) corresponds to at least one AK135 dose having two fewer CIPN events than placebo at Stage 1.

Examples:

- N=44, IA=40%: 2-event advantage among 18 participants per arm, observed RD 11.1%;
- N=48, IA=40%: 2-event advantage among 19 participants per arm, observed RD 10.5%;
- N=52, IA=35%: 2-event advantage among 18 participants per arm, observed RD 11.1%.

These designs preserve approximately 81-82% Stage 1 Go probability under the target true effect of 15%.

By contrast, when the 65% threshold maps to a 3-event advantage, target-effect Go probability can fall substantially. For example:

- N=44, IA=45%: 3-event advantage required; P(Go|15%)=72.5%;
- N=52, IA=40%: 3-event advantage required; P(Go|15%)=74.1%.

This is not a simulation anomaly. It is a consequence of discrete event counts and the shrinking amount of future data available to recover from an unconvincing interim result.

## 5. Incremental value of waiting

### N=44 per arm

Moving from 35% to 40% at CP=65%:

- target-effect Go: 76.7% -> 80.9% (+4.2 percentage points);
- null Go: 43.1% -> 45.1% (+2.0 points);
- retained post-S1 accrual rate at L=6,r0=9: 68.9% -> 54.3%;
- decision time: approximately month 11.0 -> 12.0.

Moving further to 45% causes the event-count boundary to jump to 3 events and target-effect Go falls to 72.5%.

### N=48 per arm

At CP=65%, the event-count requirement remains 2 events across 35%, 40%, and 45%.

- P(Go|15%): 79.7% -> 82.1% -> 85.1%;
- P(Go|0%): 44.5% -> 45.7% -> 47.2%.

Thus later IA mainly increases continuation under both null and target scenarios, with only modest improvement in discrimination, while the required operational slowdown becomes materially stronger.

### N=52 per arm

At CP=65%:

- 35% IA requires a 2-event advantage and gives P(Go|15%)=80.9%;
- 40% and 45% IA require a 3-event advantage and give 74.1% and 76.9%.

Therefore the 35% look is statistically more protective of a true 15% effect and is also operationally easier.

## 6. Role of 70% and 75%

The nominal 70% and 75% boundaries often collapse to the same attainable event-count rule.

Where they increase the required advantage from 2 to 3 events, or from 3 to 4 events, the loss in P(Go|15%) is substantial.

Examples:

- N=44, IA=40%: 65% requires 2 events and gives 80.9%; 70/75% require 3 events and give 68.8%.
- N=48, IA=40%: 65% requires 2 events and gives 82.1%; 70/75% require 3 events and give 70.7%.
- N=52, IA=35%: 65% requires 2 events and gives 80.9%; 70% requires 3 events and gives 68.8%; 75% requires 4 events and gives 54.3%.

Thus the key distinction is the attainable event-count boundary rather than the nominal CP percentage itself.

## 7. Current interpretation

The most informative comparison is not simply 35% versus 40% versus 45%, nor 65% versus 70% versus 75%.

It is:

[
oxed{	ext{IA timing}+	ext{attainable event-count Go rule}}
]

with CP providing the probabilistic interpretation.

A two-event advantage for at least one dose appears to be the recurring region in which target-effect preservation remains around 80% while the Stage 1 rule still requires a positive observed signal.

No final choice is made here. Final selection should also be conditional on the final N per arm, because the same nominal CP threshold maps differently across N and IA.
