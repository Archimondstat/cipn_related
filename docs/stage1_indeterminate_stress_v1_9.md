# Stage 1 indeterminate-endpoint stress test

**Version:** 1.9  
**Date:** 25 September 2026  
**Status:** Stress test of the candidate available-case + consumed-slot CP method.

## 1. Objective

Evaluate whether the current Stage 1 rule remains operationally stable when some of the first 54 randomized participants have permanently indeterminate primary endpoints.

Current working design:

[
N=50/	ext{arm},
qquad
n_1approx18/	ext{arm},
]

[
max(CP_L,CP_H)ge70%
Rightarrow
	ext{Project Go}.
]

The primary candidate handling is **available-case + consumed-slot CP**.

## 2. Stress-test assumptions

For this first stress test:

- permanent indeterminate probability is 0%, 5%, or 10% per participant;
- missingness is independent of the latent binary endpoint (MCAR);
- the same missingness probability applies in all three randomized arms;
- Stage 1 nominal allocation is fixed at 18/18/18 to isolate the missing-endpoint issue from randomization imbalance.

At a 5% individual indeterminate rate:

[
E(U_{total})=54	imes0.05=2.7
]

and the probability of at least one indeterminate Stage 1 participant is:

[
1-0.95^{54}=93.7%.
]

At 10%:

[
E(U_{total})=5.4,
]

and the probability of at least one indeterminate is 99.7%.

Thus even a 5% participant-level rate is not a rare operational edge case.

## 3. Scenarios

Four true-rate configurations were evaluated:

- Null: (p_P=p_L=p_H=45%);
- One promising dose: (p_P=p_L=45%, p_H=35%);
- One target-active dose: (p_P=p_L=45%, p_H=30%);
- Both target-active doses: (p_P=45%, p_L=p_H=30%).

Exact enumeration was used; no Monte Carlo error is present.

## 4. Effect on Stage 1 Go probability

### Available-case + consumed-slot CP

| Scenario | 0% indeterminate | 5% indeterminate | 10% indeterminate |
|---|---:|---:|---:|
| Null |45.15%|39.95%|39.12%|
| One promising dose |61.02%|55.31%|53.94%|
| One target-active dose |70.33%|64.73%|63.12%|
| Both target-active doses |80.93%|76.07%|74.47%|

The candidate method becomes somewhat more conservative as indeterminate endpoints accumulate.

For the key one-target-dose scenario:

[
70.33%ightarrow64.73%ightarrow63.12%.
]

However, the null Go probability also falls:

[
45.15%ightarrow39.95%ightarrow39.12%.
]

Therefore the separation between the one-target and null scenarios changes only modestly:

- 0% missing: 25.18 percentage points;
- 5% missing: 24.78 percentage points;
- 10% missing: 24.01 percentage points.

The main impact is therefore a general conservative shift rather than a collapse of discrimination.

## 5. How often does missingness actually change the decision?

Because missingness is assumed MCAR in this stress test, each indeterminate participant has a latent binary endpoint. This permits comparison with the counterfactual Stage 1 decision that would have been made if all 54 outcomes had been observed.

### One target-active dose

| Indeterminate rate | Available-case differs from complete-data decision | Available Go / Complete No-Go | Available No-Go / Complete Go |
|---:|---:|---:|---:|
|5%|7.40%|0.91%|6.50%|
|10%|10.93%|1.86%|9.06%|

Thus at 5% missingness, the available-case + consumed-slot rule changes the project decision in about 7% of trials.

Most disagreements are conservative:

[
	ext{complete-data Go}ightarrow	ext{available-case No-Go}.
]

At 10% missingness, decision disagreement rises to about 11%.

### Other scenarios

At 5% missingness, disagreement with the complete-data decision is:

- Null: 7.74%;
- One promising dose: 7.91%;
- One target dose: 7.40%;
- Both target doses: 6.27%.

At 10% missingness it is approximately 9%-12%.

## 6. Worst-case / best-case sensitivity is very wide

For each active-vs-placebo comparison:

- worst for AK135: placebo missing = non-event; treatment missing = event;
- best for AK135: placebo missing = event; treatment missing = non-event.

At project level, the probability that these two extreme assignments lead to different Go/No-Go conclusions is:

| Scenario | 5% missing | 10% missing |
|---|---:|---:|
| Null |25.64%|48.77%|
| One promising dose |25.03%|47.90%|
| One target dose |23.05%|44.89%|
| Both target doses |19.28%|38.93%|

Therefore a governance rule requiring the same decision under both worst- and best-case assignment would create a large "indeterminate decision" region even when the individual missing rate is only 5%.

This argues against using the extreme sensitivity bounds as a mechanical second stopping rule.

They are more suitable as contextual sensitivity information.

## 7. Interpretation

The first stress test suggests:

1. **Available-case + consumed-slot CP is workable at low missingness.**  
   At a 5% participant-level indeterminate rate, it reduces target-dose Stage 1 Go probability by about 5.6 percentage points but largely preserves null-vs-target discrimination.

2. **It is mildly conservative under MCAR.**  
   When its decision differs from the counterfactual complete-data decision, the dominant direction is Go becoming No-Go.

3. **10% indeterminate endpoints are materially influential.**  
   Decision disagreement with complete data rises to about 11% in the one-target scenario.

4. **Worst/best assignment is too sensitive to be an automatic governance rule.**  
   Even at 5% missingness, approximately 23% of one-target trials straddle the 70% cutoff across the two extreme assignments.

## 8. Working implication

The results support keeping:

[
oxed{	ext{available-case + consumed-slot CP}}
]

as the leading simple Stage 1 method.

However, the design should not rely on worst/best-case agreement as a mandatory Go/No-Go criterion.

A more practical structure would be:

- primary Stage 1 decision: slot-adjusted available-case CP;
- report extreme or other prespecified missing-data sensitivity as supporting information;
- include an operational review/flag if the amount of indeterminate Stage 1 data is unexpectedly high.

No numerical missing-rate trigger is fixed by this note.

## 9. Remaining limitation

This stress test assumes MCAR and equal missing probability across arms.

It does not yet address informative missingness caused by treatment toxicity, chemotherapy discontinuation, disease progression, or death.

Those situations should be handled through the final estimand/missing-data strategy and, if needed, a targeted asymmetric sensitivity analysis rather than by assuming that all indeterminate endpoints behave identically.
