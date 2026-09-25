# Final sample-size scan: N = 40 to 60 per arm

**Version:** 1.1  
**Date:** 25 September 2026  
**Status:** First-pass N selection screen; IA timing and CP intentionally excluded.

## 1. Objective

Choose a plausible final sample-size region before calibrating Stage 1 timing and CP.

The final promising criterion in this screen is:

[
Delta_{max}=max(widehatDelta_L,widehatDelta_H)ge10%.
]

Because the endpoint is binary and final group sizes are equal, this is equivalent to requiring at least one active arm to have an event-count advantage over placebo of:

[
k_N=lceil0.10Nceil.
]

The scan uses:

[
N=40,41,ldots,60	ext{ per arm}.
]

## 2. True-effect scenarios

The key scenarios are:

- ((0,0)): both doses ineffective;
- ((0,15)): one dose ineffective, one at the 15% target effect;
- ((5,15)): one weak-effect dose, one target-effect dose;
- ((10,15)): one promising-effect dose, one target-effect dose;
- ((15,15)): both doses at target effect.

Placebo event rate is fixed at 45% for this first screen.

The ((0,15)) scenario is especially important for dose exploration because it protects the possibility that only one AK135 dose is truly effective.

## 3. Lattice effect

The final 10% observed-effect threshold changes in integer-event steps.

- N=40 requires 4 fewer events, exactly 10.0%.
- N=41-50 requires 5 fewer events.
- N=51-60 requires 6 fewer events.

Therefore the attainable threshold is especially favorable at N=40, 50, and 60, while moving from N=50 to N=51 causes a sharp jump from exactly 10.0% to 11.8%.

This produces a saw-tooth pattern in the final Go-leaning probabilities.

## 4. Selected results

| N/arm | Total N | Event diff | Attainable threshold | P(Go|0,0) | P(Go|0,15) | P(Go|5,15) | P(Go|10,15) | P(Go|15,15) | 95% RD half-width at 45% vs 30% |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|44|132|5|11.36%|26.66%|69.45%|71.72%|76.02%|82.32%|19.99%|
|45|135|5|11.11%|27.05%|70.39%|72.63%|76.88%|83.10%|19.76%|
|48|144|5|10.42%|28.15%|73.03%|75.16%|79.27%|85.23%|19.14%|
|50|150|5|10.00%|28.84%|74.64%|76.70%|80.70%|86.48%|18.75%|
|51|153|6|11.76%|22.23%|68.30%|70.41%|74.81%|81.64%|18.56%|
|54|162|6|11.11%|23.24%|70.97%|72.99%|77.25%|83.83%|18.04%|
|58|174|6|10.34%|24.50%|74.16%|76.06%|80.13%|86.33%|17.41%|
|60|180|6|10.00%|25.09%|75.62%|77.45%|81.42%|87.42%|17.11%|

## 5. Main findings

### 5.1 One-dose-target scenario is more demanding than two-dose-target scenario

At N=44:

[
P(Go|0,15)=69.5%,
]

while:

[
P(Go|15,15)=82.3%.
]

At N=50:

[
P(Go|0,15)=74.6%,
]

while:

[
P(Go|15,15)=86.5%.
]

Thus a design judged only under ((15,15)) can look materially more favorable than one judged under the realistic scenario in which only one dose is truly effective.

### 5.2 N=50 is an important lattice point

At N=50 the 10% final threshold corresponds exactly to a five-event difference:

[
5/50=10%.
]

This gives relatively high target preservation before the event-count threshold jumps to six events at N=51.

Compared with N=48, N=50 adds only six participants overall and increases:

[
P(Go|0,15): 73.0%	o74.6%,
]

and:

[
P(Go|15,15):85.2%	o86.5%.
]

### 5.3 N=51 is not a simple improvement over N=50

At N=51 the minimum final event difference becomes 6:

[
6/51=11.76%.
]

Consequently:

[
P(Go|0,15)
]

drops from 74.6% at N=50 to 68.3% at N=51, despite the larger sample size.

The null Go probability also drops substantially, from 28.8% to 22.2%. This is improved discrimination in one sense, but it comes at the cost of lower probability of recognizing a truly target-effective dose.

### 5.4 Precision changes slowly

Under pP=45% and pT=30%, the simple approximate 95% risk-difference half-width changes from about:

- 20.0% at N=44;
- 19.1% at N=48;
- 18.8% at N=50;
- 18.4% at N=52;
- 17.1% at N=60.

Therefore precision alone does not strongly distinguish nearby N values.

## 6. What remains to decide before shortlisting N

The numerical scan does not by itself select N. The project needs to state which final-stage property it wants to protect.

A useful primary planning quantity is:

[
P(Go|0,15),
]

because it represents the chance of recognizing a target-effective program when only one of the two doses is truly effective.

The project should decide what range is acceptable for this quantity. For example, a 70% criterion would lead to a different sample-size region than a 75% criterion.

At the same time, (P(Go|0,0)) should be shown as the price paid for preserving target-effect sensitivity. It should not be interpreted as a confirmatory type-I error because the final rule is an exploratory observed-effect classification, not a formal hypothesis test.

Only after this planning criterion is agreed should 2-4 final N candidates be carried back into the IA/CP calibration.
