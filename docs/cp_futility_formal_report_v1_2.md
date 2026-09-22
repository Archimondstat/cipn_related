# CIPN Randomized Phase II Study
## Conditional-Power-Based Stage 1 Decision-Support Framework (CRC Scenario)

**Version:** 1.2  
**Date:** 22 September 2026  
**Status:** Core efficacy framework and Stage 1 enrollment-to-trigger logic established; information-window bounds and operational review procedures remain under discussion

---

## 1. Purpose

This report documents the current statistical framework for a randomized exploratory Phase II CIPN study with two active doses and a concurrent placebo arm.

The study is not intended to provide confirmatory proof of efficacy. Its role is to estimate treatment effects, characterize uncertainty, support dose/development decisions, and identify whether the observed efficacy profile is sufficiently promising for continued development.

The Stage 1 assessment uses conditional power (CP) as a quantitative, non-binding decision-support measure. CP is not used as an automatic stopping rule.

This version formally incorporates the three-region Phase II efficacy framework selected for the project.

---

## 2. Study structure

The current design work is focused on **Cohort 1**.

Cohort 1 consists of participants with colon cancer after curative surgery who are planned to receive approximately 6 months of **mFOLFOX6 adjuvant chemotherapy**. Participants are randomized to:

- placebo;
- low-dose C;
- high-dose C;

with initial equal randomization.

A concurrent placebo arm is retained because the development decision is intended to compare the active doses against the concurrently observed CIPN risk under the same mFOLFOX6 background.

### 2.1 Primary endpoint

For Cohort 1, the primary endpoint is binary:

> **Proportion of participants who develop CTCAE grade >=2 CIPN from baseline through 3 months after the actual last mFOLFOX6 adjuvant treatment.**

For participant (i):

[
Y_i
=
I{
	ext{CTCAE grade >=2 CIPN occurs during the primary observation period}
}.
]

Thus the endpoint is a binary occurrence endpoint rather than a time-to-event endpoint.

### 2.2 When the primary endpoint status is determined

A participant's primary endpoint status is considered determined when either of the following is true:

> **CTCAE grade >=2 CIPN has occurred; or the participant has completed follow-up through 3 months after the actual last mFOLFOX6 adjuvant treatment without such an event.**

Accordingly:

- once CTCAE grade >=2 CIPN occurs within the observation period, (Y_i=1) is determined;
- if no such event occurs, (Y_i=0) is determined only after completion of follow-up through 3 months after the actual last mFOLFOX6 adjuvant treatment.

For participants who permanently discontinue adjuvant chemotherapy early, the follow-up anchor is the **actual last adjuvant treatment**, not the originally planned end of the 6-month course.

### 2.3 Consequence for Stage 1 subject selection

Stage 1 subjects should **not** be selected simply as the first participants whose endpoint becomes analyzable.

That approach would preferentially select:

- participants who experience CTCAE grade >=2 CIPN earlier; and/or
- participants whose adjuvant chemotherapy ends earlier.

The Stage 1 analysis population should therefore be determined prospectively by **randomization order**, independent of the time at which an individual endpoint becomes known.

The current statistical principle is:

[
oxed{
	ext{Stage 1 subjects form an initial prefix of the randomized sequence.}
}
]

In other words, Stage 1 consists of the earliest randomized participants in sequence, rather than whichever participants happen to become analyzable first.

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

## 6. Stage 1 timing and trigger logic

### 6.1 Nominal timing

The current nominal Stage 1 timing is:

[
oxed{50%	ext{ of planned primary-endpoint information}}
]

where information is defined by the number of participants whose **primary endpoint status has been determined**, not by the number randomized.

### 6.2 Information fraction

Let:

- (N_{mathrm{plan}}) = planned total analysis population for Cohort 1;
- (K) = number of earliest randomized participants, in sequence, whose primary endpoint status has been determined and who therefore constitute the current analyzable randomization-order prefix.

The Stage 1 information fraction is defined as:

[
oxed{
f_1=rac{K}{N_{mathrm{plan}}}.
}
]

The intention is to conduct Stage 1 around 50% information, but **not at an exact fixed percentage**.

A small prospectively specified information window will be used:

[
oxed{
f_Lle f_1le f_U,
qquad
f_1^{mathrm{nominal}}=50%.
}
]

The lower bound allows the analysis to proceed without unnecessarily waiting for an exact 50% point when sufficient primary-endpoint information is already available.

The upper bound allows operational time for data cut-off, data cleaning, preparation of the unblinded analysis, and review when enrollment and endpoint maturation are occurring quickly.

### 6.3 Randomization-order requirement

The information window does not permit arbitrary selection of analyzable participants.

Stage 1 must remain an **initial randomization-order prefix**. Participants who were randomized later cannot be used to replace earlier randomized participants whose endpoint status is not yet determined.

This preserves separation between:

[
	ext{who is eligible for Stage 1}
]

and:

[
	ext{when that participant's endpoint becomes determined}.
]

The exact numerical lower and upper limits of the information window, and the operational point at which (K) is frozen for the Stage 1 data cut-off, remain to be agreed by the project team.

---

## 7. Stage 1 review: decision support rather than a mechanical boundary

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

## 8. Stage 1 design-calibration space

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

## 9. Reference interim treatment-effect table

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

## 10. Final efficacy-classification operating characteristics

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

### 10.1 Important consequence for Stage 1 timing

Because no deterministic Stage 1 stopping rule has been selected, the **final** No-Go / Consider / Go classification probabilities do not depend on whether the Stage 1 review occurs at 40%, 50%, or 60% information.

Stage 1 timing still affects:

- interim effect distributions;
- individual and joint CP;
- probability of entering selected reference regions;
- opportunity to stop, slow accrual, or conserve resources.

A full design-level probability of early termination and expected sample size cannot be calculated until an explicit operational action rule is specified.

---

## 11. Delayed endpoint, pipeline subjects, and overrun

Because the primary endpoint may not be determined until 3 months after the actual last mFOLFOX6 adjuvant treatment in participants without an earlier CTCAE grade >=2 CIPN event, there can be a substantial gap between:

- the number randomized;
- the number belonging to the Stage 1 randomization-order prefix;
- the number whose primary endpoint status is already determined;
- the number already randomized but still in treatment or follow-up.

These later participants are operationally relevant but should not be allowed to change the prospectively defined Stage 1 subject-selection principle.

The current working principles are:

- Stage 1 membership is determined by randomization order;
- primary endpoint status is determined using the rule in Section 2.2;
- the actual Stage 1 information fraction is based on the analyzable randomization-order prefix;
- participants randomized beyond the Stage 1 cut-off remain in follow-up and may contribute to the final Phase II analysis;
- the Stage 1 review remains non-binding.

The following operational questions are intentionally left to the project team:

- whether enrollment continues unchanged, slows, or pauses as the lower information-window bound is approached;
- how much overrun is acceptable before the upper information-window bound;
- the exact Stage 1 data cut-off / freeze rule;
- how participants becoming endpoint-determined during data-cleaning and review preparation are handled.

---

## 12. External trial precedents

### 12.1 PTG-100-02 / NCT02895100

PTG-100-02 was a Phase 2b randomized, double-blind, placebo-controlled, adaptive two-stage study with multiple active doses and placebo.

Relevant features included:

- Stage 1 conditional power;
- potential dose dropping;
- review of safety, efficacy, and exploratory information;
- non-mechanical clinical/adaptive review;
- explicit handling of overrun subjects while Stage 1 outcomes matured.

Its formal CP target was linked to final statistical significance rather than an observed-effect promising threshold, so it is used here as an adaptive-process precedent rather than copied directly.

### 12.2 VITALITY-HFpEF / NCT03547583

VITALITY-HFpEF was a randomized Phase 2b study of two vericiguat doses and placebo.

Its SAP presented operating characteristics over candidate interim observed-effect boundaries, including individual CP, joint CP, and probabilities under different true effects.

The futility recommendation was non-binding, and if only one active dose was unfavorable, that dose was not automatically dropped.

This is the closest precedent for the **presentation and calibration philosophy** used in the current CIPN framework.

Its final statistical success event was hypothesis rejection; the present exploratory CIPN study instead defines CP against a prespecified Phase II promising threshold.

### 12.3 TAK-555-3010 / NCT04759833

TAK-555-3010 was a Phase 3 study with low dose, high dose, and placebo.

Its interim analysis was performed around 50% information. CP was calculated separately for both active-vs-placebo comparisons, and overall futility stopping was considered only if both CP values were below the prespecified threshold.

Its confirmatory context and fixed statistical rule are not directly transferred to this exploratory Phase II study, but the structure provides a useful precedent for two active doses sharing a project-level futility review.

---

## 13. Methodological interpretation

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

## 14. Current conclusions

The following elements are now fixed for the current working framework:

1. The current design focus is **Cohort 1**: colon cancer after curative surgery with planned mFOLFOX6 adjuvant chemotherapy.
2. Participants are randomized to placebo, low-dose C, or high-dose C.
3. Treatment effect is:
   [
   Delta=p_P-p_T.
   ]
4. CRC target treatment effect:
   [
   15%.
   ]
5. Weak-effect boundary:
   [
   5%.
   ]
6. Promising threshold:
   [
   10%.
   ]
7. Final efficacy classification is No-Go leaning / Consider / Go leaning.
8. The Cohort 1 primary endpoint is the proportion developing CTCAE grade >=2 CIPN from baseline through 3 months after the **actual last mFOLFOX6 adjuvant treatment**.
9. Primary endpoint status is determined when:
   - CTCAE grade >=2 CIPN has occurred; or
   - follow-up through 3 months after the actual last mFOLFOX6 adjuvant treatment is complete without such an event.
10. Stage 1 subjects are selected prospectively by **randomization order**, not by which participants become analyzable first.
11. Stage 1 is nominally planned at approximately **50% primary-endpoint information**.
12. The actual Stage 1 timing will use a prospectively specified **information window** around 50%.
13. Stage 1 information is defined by the number of endpoint-determined participants in the eligible randomization-order prefix, divided by the planned total analysis population.
14. CP is non-binding decision support.
15. The CP final promising event is:
   [
   widehatDelta_{j,F}ge10%.
   ]
16. Interim displayed treatment effects are reference values, not automatic stopping boundaries.
17. Shared placebo is handled explicitly in joint CP.

---

## 15. Remaining open items

The following items remain for project-team/statistical discussion.

### 15.1 Study-level design

- final maximum efficacy-evaluable sample size (N);
- whether randomization should be stratified and, if so, which small number of clinically important factors should be used;
- final blinding strategy for Cohort 1.

### 15.2 Stage 1 timing and operations

- exact lower and upper bounds of the Stage 1 information window around nominal 50%;
- exact Stage 1 data cut-off / rule for freezing (K);
- whether enrollment continues, slows, or pauses as the Stage 1 window is reached;
- acceptable overrun while Stage 1 data are prepared and reviewed;
- treatment of participants whose endpoint becomes determined during the Stage 1 data-cleaning/review interval.

### 15.3 Interim review governance

- dose-level dropping versus project-level continuation;
- composition and charter of the independent/unblinded review body;
- who may access unblinded arm-level efficacy information;
- whether the blinded study team receives only a recommendation or additional arm-level information;
- explicit information permitted in the contextual review beyond CP and observed treatment effects.

### 15.4 Analysis details

- missing/non-evaluable primary-endpoint handling;
- final analysis population definition;
- whether uncertainty criteria should be added to the final contextual development decision even though they are not part of the primary three-region efficacy classification.

The current framework does **not** use “first analyzable participants” as the Stage 1 population and does not require a separate earlier CIPN endpoint for the Stage 1 trigger.

---

## 16. Reproducible implementation

Primary implementation files:

- `simulation/cp_futility_engine.R`
- `simulation/cp_futility_engine.sas`

Final classification OC results:

- `simulation/results/cp_final_classification_grid_v1_1.csv`

Supporting documentation:

- `docs/cp_final_classification_oc_v1_1.md`
- `docs/cp_futility_derivation_v1_1.md`
- `docs/cp_futility_formal_report_v1_2.md`

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
