# CIPN Randomized Phase II Study
## Conditional-Power-Based Stage 1 Decision-Support Framework (CRC Scenario)

**Version:** 1.1  
**Date:** 22 September 2026  
**Status:** Core efficacy decision framework established; maximum sample size, Stage 1 timing, and operational review charter remain under calibration

---

## 1. Purpose

This report documents the current statistical framework for a randomized exploratory Phase II CIPN study with two active doses and a concurrent placebo arm.

The study is not intended to provide confirmatory proof of efficacy. Its role is to estimate treatment effects, characterize uncertainty, support dose/development decisions, and identify whether the observed efficacy profile is sufficiently promising for continued development.

The Stage 1 assessment uses conditional power (CP) as a quantitative, non-binding decision-support measure. CP is not used as an automatic stopping rule.

This version formally incorporates the three-region Phase II efficacy framework selected for the project.

---

## 2. Study structure

The working randomized treatment structure is:

- placebo;
- low-dose C;
- high-dose C;

with initial equal randomization.

A concurrent placebo arm is retained because CIPN incidence can vary materially with chemotherapy regimen, population, ascertainment, and follow-up. The development decision should therefore be anchored to the concurrently observed control risk rather than a fixed historical rate.

The current binary design endpoint is:

> CTCAE grade >=2 CIPN.

The exact clinical assessment horizon remains to be finalized. Endpoint maturation is expected to require approximately 4-6 months.

Whether an earlier CIPN assessment can validly support Stage 1 review remains a medical/clinical question and is not incorporated into the current simulation.

---

## 3. Treatment-effect definition and fixed development quantities

Treatment effect is defined throughout the project as:

[
oxed{
Delta=p_{mathrm{Placebo}}-p_{mathrm{Treatment}}
}
]

so a positive value favors treatment.

For the CRC working scenario:

[
p_P=45%, qquad p_T=30%.
]

Therefore:

[
oxed{Delta_{mathrm{target}}=15%}
]

is the **target treatment effect**.

The following three quantities are now kept distinct:

[
oxed{
Delta_{mathrm{weak}}=5%
}
]

= **weak-effect boundary**;

[
oxed{
Delta_{mathrm{promising}}=10%
}
]

= **promising threshold**;

[
oxed{
Delta_{mathrm{target}}=15%
}
]

= **target treatment effect**.

The target effect is a design assumption. The 5% and 10% values are development-decision quantities and are not null-hypothesis significance thresholds.

---

## 4. Final Phase II efficacy classification

For each active dose:

[
widehatDelta_j
=
widehat p_P-widehat p_j,
qquad
jin{L,H}.
]

At the program level define:

[
widehatDelta_{max}
=
max(
widehatDelta_L,
widehatDelta_H
).
]

The final efficacy evidence is classified as:

[
oxed{
egin{cases}
widehatDelta_{max}<5%
&
	ext{No-Go leaning}\[2mm]
5%lewidehatDelta_{max}<10%
&
	ext{Consider}\[2mm]
widehatDelta_{max}ge10%
&
	ext{Go leaning}
end{cases}
}
]

This is an **efficacy classification**, not an automatic development decision.

The final development decision may also consider prospectively specified information including:

- safety;
- consistency of the efficacy profile;
- dose-response pattern;
- uncertainty around treatment-effect estimates;
- feasibility and other clinically relevant evidence.

The present exploratory Phase II framework does not require a confirmatory efficacy null hypothesis to be rejected in order to classify the result as promising.

---

## 5. Conditional power definition

### 5.1 Individual dose

At Stage 1, CP is calculated separately for each active dose versus placebo.

For dose (j):

[
oxed{
CP_j
=
Pleft(
widehatDelta_{j,F}ge10%
mid
D_1,	heta_{mathrm{future}}
ight)
}
]

where:

- (D_1) denotes the mature Stage 1 data;
- (	heta_{mathrm{future}}) denotes the prespecified future-data assumption.

Thus, in this exploratory study, CP is defined as the conditional probability that the dose ultimately meets the prespecified **Phase II promising criterion**.

It is not defined as the probability of rejecting a confirmatory null hypothesis.

### 5.2 Joint CP

Because Low and High share the same placebo arm:

[
oxed{
CP_{mathrm{joint}}
=
Pleft(
max(
widehatDelta_{L,F},
widehatDelta_{H,F}
)
ge10%
mid
D_1,	heta_{mathrm{future}}
ight)
}
]

The shared future placebo outcome is handled explicitly in the exact calculation.

### 5.3 Future-data assumption

The primary working future-data assumption is the original design alternative:

[
p_P^{future}=45%,
qquad
p_T^{future}=30%.
]

This is a design-alternative CP rather than a current-trend extrapolation.

---

## 6. Stage 1 review: decision support rather than a mechanical boundary

At Stage 1, the operational analysis will calculate CP using the actual mature counts:

[
(n_P,x_P),quad
(n_L,x_L),quad
(n_H,x_H).
]

The program therefore supports:

[
n_P
e n_L
e n_H.
]

The Stage 1 review is non-binding.

The intended process is:

1. calculate observed Low-vs-placebo and High-vs-placebo treatment effects;
2. calculate (CP_L), (CP_H), and, where useful, joint CP;
3. place the observed results within the prospectively simulated calibration framework;
4. review prospectively specified safety and supportive information;
5. make a contextual Go / No-Go recommendation.

A displayed interim treatment-effect value such as 0%, 5%, or approximately 10% is a **reference observed treatment effect**, not an automatic futility boundary.

Accordingly, probabilities reported for these rows should be labeled as probabilities of falling into the corresponding reference region rather than probabilities of stopping.

---

## 7. Stage 1 design-calibration space

The current maximum efficacy-evaluable sample-size grid is:

[
N=36, 40, 44, 48, 52
quad	ext{per arm}.
]

The nominal Stage 1 mature-information fractions are:

[
f_1=40%, 50%, 60%.
]

For (N=44) per arm, the corresponding nominal mature sample sizes are approximately:

| Stage 1 information | Nominal mature n/arm |
|---:|---:|
| 40% | 18 |
| 50% | 22 |
| 60% | 26 |

These are calibration targets rather than rigid requirements for equal observed sample sizes at the actual review.

---

## 8. Reference interim treatment-effect table

When equal nominal Stage 1 sample size (n_1) is used for design presentation:

[
widehatDelta_1
=
rac{x_P-x_T}{n_1}.
]

Therefore the event-count difference

[
D=x_P-x_T
]

provides a direct interpretation of each displayed reference treatment effect.

For example, at (n_1=22):

| Reference observed effect | Event-count difference (x_P-x_T) |
|---:|---:|
| -4.55% | -1 |
| 0.00% | 0 |
| 4.55% | +1 |
| 9.09% | +2 |

The 9.09% row means that placebo has two more observed CTCAE grade >=2 CIPN events than treatment at Stage 1.

It does **not** mean that 9.09% is an automatic stopping or continuation boundary.

---

## 9. Final efficacy-classification operating characteristics

The final three-region classification has been evaluated exactly for:

[
N=36,40,44,48,52
]

per arm and true treatment effects:

[
0%,5%,10%,15%,20%.
]

Both active doses are assigned the same true effect in the initial grid, with (p_P=45%).

For the current (N=44) anchor:

| True treatment effect | P(No-Go leaning) | P(Consider) | P(Go leaning) |
|---:|---:|---:|---:|
| 0% | 56.23% | 17.11% | 26.66% |
| 5% | 36.07% | 18.57% | 45.36% |
| 10% | 18.94% | 15.57% | 65.49% |
| 15% | 7.79% | 9.89% | 82.32% |
| 20% | 2.38% | 4.61% | 93.01% |

These values describe the **efficacy classification only**.

The relatively high probability of a Go-leaning classification when the true treatment effect is 0% is an expected consequence of:

- using the better of two active doses;
- using an observed-effect threshold rather than a significance requirement;
- not applying a multiplicity-controlled confirmatory hypothesis test.

This does not represent the probability of an automatic development Go under the null because the selected framework is contextual and non-binding.

Nevertheless, this operating characteristic must be explicitly considered when drafting the final development-decision charter.

### 9.1 Important consequence for Stage 1 timing

Because no deterministic Stage 1 stopping rule has been selected, the **final** No-Go / Consider / Go classification probabilities do not depend on whether the Stage 1 review occurs at 40%, 50%, or 60% information.

Stage 1 timing still affects:

- interim effect distributions;
- individual and joint CP;
- probability of entering selected reference regions;
- opportunity to stop, slow accrual, or conserve resources.

A full design-level probability of early termination and expected sample size cannot be calculated until an explicit operational action rule is specified.

---

## 10. Delayed endpoint, pipeline subjects, and overrun

The 4-6 month endpoint maturation creates a distinction between:

- randomized subjects;
- subjects with mature Stage 1 efficacy data;
- subjects already enrolled but still in follow-up.

The working operational concept remains:

- define the Stage 1 analysis cohort prospectively;
- calculate Stage 1 CP using that mature cohort;
- permit controlled continuation or slowing of enrollment while outcomes mature;
- include pipeline/overrun subjects in the final Phase II analysis as appropriate;
- do not retrospectively add pipeline subjects to the Stage 1 CP calculation.

The exact slowdown/overrun rule remains open.

---

## 11. External trial precedents

### 11.1 PTG-100-02 / NCT02895100

PTG-100-02 was a Phase 2b randomized, double-blind, placebo-controlled, adaptive two-stage study with multiple active doses and placebo.

Relevant features included:

- Stage 1 conditional power;
- potential dose dropping;
- review of safety, efficacy, and exploratory information;
- non-mechanical clinical/adaptive review;
- explicit handling of overrun subjects while Stage 1 outcomes matured.

Its formal CP target was linked to final statistical significance rather than an observed-effect promising threshold, so it is used here as an adaptive-process precedent rather than copied directly.

### 11.2 VITALITY-HFpEF / NCT03547583

VITALITY-HFpEF was a randomized Phase 2b study of two vericiguat doses and placebo.

Its SAP presented operating characteristics over candidate interim observed-effect boundaries, including individual CP, joint CP, and probabilities under different true effects.

The futility recommendation was non-binding, and if only one active dose was unfavorable, that dose was not automatically dropped.

This is the closest precedent for the **presentation and calibration philosophy** used in the current CIPN framework.

Its final statistical success event was hypothesis rejection; the present exploratory CIPN study instead defines CP against a prespecified Phase II promising threshold.

### 11.3 TAK-555-3010 / NCT04759833

TAK-555-3010 was a Phase 3 study with low dose, high dose, and placebo.

Its interim analysis was performed around 50% information. CP was calculated separately for both active-vs-placebo comparisons, and overall futility stopping was considered only if both CP values were below the prespecified threshold.

Its confirmatory context and fixed statistical rule are not directly transferred to this exploratory Phase II study, but the structure provides a useful precedent for two active doses sharing a project-level futility review.

---

## 12. Methodological interpretation

Classic CP commonly refers to:

[
P(	ext{final hypothesis rejection}mid	ext{interim data}).
]

For the present exploratory Phase II study, the same probability structure is used with a different final event:

[
P(
	ext{final promising criterion met}
mid
	ext{interim data}
).
]

This should therefore be described explicitly in protocol/SAP/reporting language as:

> conditional power (CP), defined in this exploratory study as the conditional probability of meeting the prespecified final Phase II efficacy promising criterion.

This terminology avoids implying a confirmatory efficacy claim.

---

## 13. Current conclusions

The following elements are now fixed for the current working framework:

1. treatment effect:
   [
   Delta=p_P-p_T;
   ]
2. CRC target effect:
   [
   15%;
   ]
3. weak-effect boundary:
   [
   5%;
   ]
4. promising threshold:
   [
   10%;
   ]
5. final efficacy classification:
   No-Go leaning / Consider / Go leaning;
6. CP final event:
   [
   widehatDelta_{j,F}ge10%;
   ]
7. Stage 1 CP is non-binding decision support;
8. interim displayed effect values are reference values, not automatic stopping boundaries;
9. actual interim denominators may differ across arms;
10. shared placebo is handled explicitly in joint CP.

---

## 14. Remaining open items

The following remain to be selected or operationalized:

- final maximum efficacy-evaluable (N);
- preferred Stage 1 information fraction / information window;
- dose-level dropping versus project-level continuation;
- composition and charter of the independent review body;
- explicit information allowed in the contextual review;
- enrollment slowdown / overrun policy;
- missing/non-evaluable endpoint handling;
- whether an earlier CIPN endpoint can support Stage 1 review;
- whether uncertainty criteria should be added to the final contextual development decision even though they are not part of the primary three-region efficacy classification.

---

## 15. Reproducible implementation

Primary implementation files:

- `simulation/cp_futility_engine.R`
- `simulation/cp_futility_engine.sas`

Final classification OC results:

- `simulation/results/cp_final_classification_grid_v1_1.csv`

Supporting documentation:

- `docs/cp_final_classification_oc_v1_1.md`
- `docs/cp_futility_derivation_v1_1.md`

---

## References

1. Simon R. Optimal two-stage designs for phase II clinical trials. *Controlled Clinical Trials*. 1989;10(1):1-10. doi:10.1016/0197-2456(89)90015-9.
2. Lan KKG, Wittes J. The B-value: a tool for monitoring data. *Biometrics*. 1988;44(2):579-585.
3. Jung SH. Randomized phase II trials with a prospective control. *Statistics in Medicine*. 2008;27(4):568-583. doi:10.1002/sim.2961.
4. Ortega-Villa AM, et al. Futility Monitoring in Clinical Trials. *Statistics in Medicine*. 2025. doi:10.1002/sim.70157.
5. Armstrong PW, Lam CSP, Anstrom KJ, et al. Effect of Vericiguat vs Placebo on Quality of Life in Patients With Heart Failure and Preserved Ejection Fraction: The VITALITY-HFpEF Randomized Clinical Trial. *JAMA*. 2020;324(15):1512-1521.
6. PTG-100-02 / NCT02895100. Protocol and Statistical Analysis Plan. ClinicalTrials.gov.
7. VITALITY-HFpEF / NCT03547583. Protocol and Statistical Analysis Plan. ClinicalTrials.gov.
8. TAK-555-3010 / NCT04759833. Protocol and Statistical Analysis Plan. ClinicalTrials.gov.
