# CIPN Phase II Cohort 1
## Stage 1 information fraction × CP cutoff calibration grid

**Version:** 0.1  
**Date:** 23 September 2026  
**Status:** Working simulation/calibration grid; not a final stopping rule.

---

## 1. Purpose

Evaluate how the Stage 1 timing and a candidate conditional-power (CP) futility cutoff jointly affect operating characteristics.

The current grid is:

- Stage 1 information fraction: **35%, 40%, 45%, 50%**
- CP cutoff: **25%, 30%, 35%, 40%, 45%, 50%**

The current final-sample-size anchor is **N=44 per arm** (132 total).

For nominal equal per-arm calibration:

| Nominal information fraction | Nominal mature n/arm |
|---:|---:|
| 35% | 15 |
| 40% | 18 |
| 45% | 20 |
| 50% | 22 |

These are design-calibration values. The operational Stage 1 population remains defined by randomization order and can have unequal mature denominators across arms.

---

## 2. Working futility rule used only for this calibration

For each active dose:

[
CP_j=P(widehatDelta_{j,F}ge10%mid D_1,	heta_{mathrm{future}})
]

with future-data assumptions:

[
p_P^{future}=0.45,qquad p_T^{future}=0.30.
]

For this first grid, a **project-level futility stop** is simulated when:

[
oxed{CP_L<cquad	ext{and}quad CP_H<c}
]

where (c) is the candidate CP cutoff.

Equivalently:

[
max(CP_L,CP_H)<c.
]

This is a **working simulation rule only**. It does not imply that the project has selected a mechanical stopping rule.

Dose-level dropping and a joint-CP cutoff are not evaluated in this version.

---

## 3. True-effect scenarios

The following common true treatment effects are evaluated for both AK135 doses:

[
Delta_{mathrm{true}}=0%,5%,10%,15%,20%
]

with:

[
p_P=45%,qquad p_T=45%-Delta_{mathrm{true}}.
]

The 15% scenario is the current target treatment-effect scenario.

---

## 4. Key operating characteristics

The table below focuses on:

- **Stop0**: exact probability of early futility stop when the true effect is 0%;
- **Stop10**: exact probability of early futility stop when the true effect is 10%;
- **Stop15**: exact probability of early futility stop when the true effect is 15%;
- **EN0**: expected total sample size under the true 0% effect, assuming immediate stopping and no operational overrun;
- **Go15**: simulated probability of reaching the final analysis and obtaining a Go-leaning efficacy classification when the true effect is 15%;
- **GoLoss15**: absolute reduction in Go-leaning probability at the 15% target scenario relative to having no interim futility rule.

Monte Carlo final-classification probabilities use 400,000 replicates per information-fraction / true-effect scenario. Early-stop probabilities are calculated exactly.

| Info | n/arm | CP cutoff | Stop0 | Stop10 | Stop15 | EN0 | Go15 | GoLoss15 |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|35%|15|25%|7.37%|1.78%|0.72%|125.6|82.16%|0.16%|
|35%|15|30%|14.99%|4.71%|2.22%|119.0|81.63%|0.69%|
|35%|15|35%|14.99%|4.71%|2.22%|119.0|81.63%|0.69%|
|35%|15|40%|26.43%|10.51%|5.71%|109.0|80.00%|2.32%|
|35%|15|45%|26.43%|10.51%|5.71%|109.0|80.00%|2.32%|
|35%|15|50%|41.04%|20.14%|12.45%|96.3|76.08%|6.24%|
|40%|18|25%|16.26%|4.67%|2.05%|119.3|81.84%|0.50%|
|40%|18|30%|16.26%|4.67%|2.05%|119.3|81.84%|0.50%|
|40%|18|35%|27.00%|9.78%|4.94%|110.9|80.66%|1.68%|
|40%|18|40%|27.00%|9.78%|4.94%|110.9|80.66%|1.68%|
|40%|18|45%|40.34%|18.04%|10.36%|100.5|77.87%|4.47%|
|40%|18|50%|40.34%|18.04%|10.36%|100.5|77.87%|4.47%|
|45%|20|25%|16.97%|4.61%|1.93%|119.8|81.88%|0.41%|
|45%|20|30%|27.31%|9.33%|4.49%|112.3|80.94%|1.35%|
|45%|20|35%|27.31%|9.33%|4.49%|112.3|80.94%|1.35%|
|45%|20|40%|39.97%|16.85%|9.22%|103.2|78.69%|3.60%|
|45%|20|45%|39.97%|16.85%|9.22%|103.2|78.69%|3.60%|
|45%|20|50%|39.97%|16.85%|9.22%|103.2|78.69%|3.60%|
|50%|22|25%|27.57%|8.89%|4.09%|113.8|81.41%|0.98%|
|50%|22|30%|27.57%|8.89%|4.09%|113.8|81.41%|0.98%|
|50%|22|35%|27.57%|8.89%|4.09%|113.8|81.41%|0.98%|
|50%|22|40%|39.65%|15.78%|8.24%|105.8|79.63%|2.76%|
|50%|22|45%|39.65%|15.78%|8.24%|105.8|79.63%|2.76%|
|50%|22|50%|52.76%|25.42%|14.93%|97.2|75.93%|6.45%|

---

## 5. Important discreteness finding

Because the endpoint is binary and the interim sample sizes are small, CP takes a discrete set of attainable values.

Therefore several nominal CP cutoffs produce **exactly the same stopping region**.

Examples:

- 35% information: 30% and 35% are equivalent; 40% and 45% are equivalent.
- 40% information: 25% and 30% are equivalent; 35% and 40% are equivalent; 45% and 50% are equivalent.
- 45% information: 30% and 35% are equivalent; 40%, 45%, and 50% are equivalent.
- 50% information: 25%, 30%, and 35% are equivalent; 40% and 45% are equivalent.

Hence the final design should be calibrated against **attainable CP regions / event-count configurations**, not only against nominal CP percentages.

---

## 6. Initial interpretation

The grid shows the expected trade-off:

- later Stage 1 reviews and/or larger CP cutoffs increase the probability of stopping an ineffective program;
- the same choices also increase the probability of stopping under the 15% target effect and reduce the chance of reaching a final Go-leaning classification;
- a 50% CP cutoff is comparatively aggressive across the grid;
- several moderate combinations produce a target-effect early-stop probability of approximately 4-6% while stopping approximately 26-28% of truly null programs.

No design is selected in this note. The purpose is to provide a common calibration table for project discussion.

---

## 7. Limitations of this first grid

This first calibration assumes:

1. equal nominal interim sample size per arm;
2. no missing/indeterminate Stage 1 endpoint;
3. no operational overrun after the stop recommendation;
4. both active doses have the same true effect;
5. project-level stopping only if both individual CP values fall below the cutoff.

The next simulation layer should evaluate:

- randomization-order Stage 1 selection with unequal mature n across arms;
- missing/indeterminate endpoints from loss to follow-up or death;
- operational overrun;
- asymmetric Low/High true-effect scenarios;
- alternative policies such as dose dropping or joint-CP-based stopping.

