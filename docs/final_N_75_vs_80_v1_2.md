# Final-N planning anchor: ~75% at N=50 and what 80% requires

**Version:** 1.2  
**Date:** 25 September 2026  
**Status:** Working sample-size planning note.

## 1. Planning criterion

For sample-size selection, use the realistic asymmetric dose scenario:

[
(Delta_L,Delta_H)=(0%,15%),
]

with placebo incidence:

[
p_P=45%.
]

The final promising rule is:

[
max(widehatDelta_L,widehatDelta_H)ge10%.
]

The planning quantity is therefore:

[
P(Gomid0%,15%).
]

## 2. Practical 75% anchor

At:

[
oxed{N=50	ext{ per arm}}
]

the total randomized sample size is:

[
150.
]

The final 10% threshold corresponds exactly to a five-event difference:

[
5/50=10%.
]

The exact probability of a final Go-leaning classification under the ((0,15)) scenario is:

[
oxed{74.64%approx75%}.
]

Thus N=50 per arm is a natural practical anchor if approximately 75% target-dose recognition is considered acceptable.

## 3. What is required for 80%?

An exact scan over:

[
N=40,ldots,150	ext{ per arm}
]

shows that the **first** sample size reaching:

[
P(Gomid0,15)ge80%
]

is:

[
oxed{N=110	ext{ per arm}}.
]

At N=110:

- total N = 330;
- final promising threshold = 11-event advantage;
- attainable threshold = 10.0%;
- (P(Gomid0,15)=80.29%).

## 4. Why the required increase is so large

The increase from 75% to 80% is not smooth because the final binary endpoint is discrete.

Selected values are:

| N/arm | Total N | Required event advantage | P(Go|0,15) |
|---:|---:|---:|---:|
|50|150|5|74.64%|
|60|180|6|75.62%|
|70|210|7|76.61%|
|80|240|8|77.58%|
|90|270|9|78.52%|
|100|300|10|79.43%|
|101|303|11|75.54%|
|109|327|11|79.81%|
|110|330|11|80.29%|

At N=101 the required event difference jumps from 10 to 11 because:

[
10/101<10%.
]

This produces a sharp drop in Go probability. The same saw-tooth pattern occurs after every multiple of 10.

## 5. Precision comparison

Under the target pair (45%) versus (30%), the approximate 95% CI half-width for one treatment-placebo risk difference is:

- N=50: 18.75%;
- N=100: 13.26%;
- N=110: 12.64%.

Thus moving from N=50 to N=110 more than doubles total randomized sample size (150 to 330) to increase (P(Go|0,15)) from approximately 75% to 80%.

## 6. Current implication

For this exploratory Phase II design, 75% and 80% represent materially different resource commitments.

A planning choice of approximately 75% is naturally represented by:

[
oxed{N=50	ext{ per arm}}.
]

Requiring 80% under the one-effective-dose target scenario would move the design to approximately:

[
oxed{N=110	ext{ per arm}},
]

which should be evaluated against development feasibility before being considered a realistic requirement.
