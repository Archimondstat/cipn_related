# N=50/arm Stage 1 calibration with full-design OC

**Version:** 1.3  
**Date:** 25 September 2026  
**Status:** Working calibration after selecting N=50/arm as the practical final-N anchor.

## 1. Why this step is necessary

The final-N screen showed that:

[
N=50/	ext{arm}
]

gives:

[
P(	ext{Final Go}mid Delta_L=0,Delta_H=15%)=74.64%approx75%
]

when no binding interim stop is imposed.

Once Stage 1 is intended to make a real Go/No-Go decision, however, the operating characteristics must be recalculated for the **whole two-stage design**. Otherwise the final-only 75% figure overstates the probability that a target-effective dose survives Stage 1 and is ultimately classified as promising.

For this calibration, the Stage 1 rule is treated as binding:

[
max(CP_L,CP_H)ge cRightarrow	ext{continue},
]

otherwise the study stops for insufficient efficacy.

## 2. N=50 and attainable Stage 1 rules

With (N=50/	ext{arm}):

- 35% IA gives (n_1=18/	ext{arm});
- 40% IA gives (n_1=20/	ext{arm});
- 45% IA gives (n_1=23/	ext{arm}).

The individual CP values around the relevant event-count differences are:

| IA | n1/arm | CP at D=1 | CP at D=2 | CP at D=3 |
|---:|---:|---:|---:|---:|
|35%|18|63.48%|72.73%|80.62%|
|40%|20|60.84%|70.67%|79.16%|
|45%|23|56.45%|67.21%|76.68%|

Therefore:

- 35% IA: CP 65% and 70% both mean (Dge2); CP 75% means (Dge3);
- 40% IA: CP 65% and 70% both mean (Dge2); CP 75% means (Dge3);
- 45% IA: CP 65% means (Dge2); CP 70% and 75% both mean (Dge3).

This is another example of the binary-endpoint lattice effect.

## 3. Stage 1 continuation probability

For the asymmetric planning scenario:

[
(Delta_L,Delta_H)=(0,15%),
]

the exact probability of passing Stage 1 is:

| IA | CP threshold | Event rule | P(Stage 1 Go | 0,15) |
|---:|---:|---:|---:|
|35%|65% / 70%|D>=2|70.33%|
|35%|75%|D>=3|56.67%|
|40%|65% / 70%|D>=2|72.74%|
|40%|75%|D>=3|60.20%|
|45%|65%|D>=2|75.85%|
|45%|70% / 75%|D>=3|64.78%|

Thus, even the two-event rule stops approximately 24%-30% of trials at Stage 1 when exactly one dose truly has the target 15% effect.

## 4. Full-design probability of ultimately reaching a final promising result

The more important quantity is:

[
P(	ext{Stage 1 Go AND Final Go}).
]

For the ((0,15%)) planning scenario:

| IA | CP threshold | Event rule | P(Stage 1 Go) | P(Stage 1 Go and Final Go) | Final Go without binding IA | Opportunity loss from IA |
|---:|---:|---:|---:|---:|---:|---:|
|35%|65% / 70%|D>=2|70.33%|59.96%|74.64%|14.68 pp|
|35%|75%|D>=3|56.67%|50.21%|74.64%|24.43 pp|
|40%|65% / 70%|D>=2|72.74%|62.07%|74.64%|12.57 pp|
|40%|75%|D>=3|60.20%|53.38%|74.64%|21.26 pp|
|45%|65%|D>=2|75.85%|64.77%|74.64%|9.87 pp|
|45%|70% / 75%|D>=3|64.78%|57.48%|74.64%|17.16 pp|

This is a major design implication.

The earlier statement that N=50/arm gives approximately 75% recognition of one target-effective dose is true only for the final analysis **without a binding Stage 1 stop**.

With a binding Stage 1 Go/No-Go rule, the overall probability falls to approximately:

- 60% at 35% IA with the two-event rule;
- 62% at 40% IA with the two-event rule;
- 65% at 45% IA with the two-event rule.

## 5. Null scenario

For ((0,0)):

| IA | CP threshold | Event rule | P(Stage 1 Go) | P(Stage 1 Go and Final Go) |
|---:|---:|---:|---:|---:|
|35%|65% / 70%|D>=2|45.15%|21.29%|
|35%|75%|D>=3|31.32%|16.86%|
|40%|65% / 70%|D>=2|46.27%|22.13%|
|40%|75%|D>=3|33.00%|18.02%|
|45%|65%|D>=2|47.68%|23.26%|
|45%|70% / 75%|D>=3|35.15%|19.60%|

Thus the two-event rule remains intentionally permissive: approximately 45%-48% of null trials continue, but only approximately 21%-23% both continue and ultimately meet the final observed-effect promising criterion.

## 6. Both doses at the target effect

For ((15%,15%)), the two-event rule gives:

| IA | CP threshold | P(Stage 1 Go) | P(Stage 1 Go and Final Go) | Final Go without binding IA |
|---:|---:|---:|---:|---:|
|35%|65% / 70%|80.93%|74.46%|86.48%|
|40%|65% / 70%|83.17%|76.49%|86.48%|
|45%|65%|85.92%|78.95%|86.48%|

Even when both doses truly have 15% effects, a binding interim rule still removes some trials that would otherwise have reached the final promising classification.

## 7. Current interpretation

The two-event Stage 1 rule remains the least problematic of the current candidates, but the full-design OC changes the sample-size discussion materially.

If the desired approximately 75% probability is intended to describe the **whole two-stage program** under the one-effective-dose scenario, then N=50/arm plus a binding Stage 1 rule does not achieve it.

Therefore the next design decision is conceptual:

1. Is approximately 75% intended only as the final-analysis recognition probability conditional on reaching the final analysis?
2. Or should approximately 75% apply to the entire two-stage design, including the possibility of Stage 1 termination?

This distinction must be fixed before finalizing the IA/CP rule or reconsidering N.

## 8. Operational context for N=50

Under the existing illustrative operational assumptions:

[
L=6	ext{ months},qquad r_0=9/	ext{month},
]

and the 70%/5% budget-risk constraint:

| IA | Stage 1 total | Approx retained post-S1 accrual | Approx IA decision month |
|---:|---:|---:|---:|
|35%|54|73.8%|12.0|
|40%|60|64.0%|12.7|
|45%|69|49.5%|13.7|

Thus later IA preserves more target-effect trials statistically, but requires materially stronger recruitment slowdown and a later decision.
