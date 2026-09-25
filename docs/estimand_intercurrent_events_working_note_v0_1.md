# CIPN Phase II Cohort 1
## Estimand and Intercurrent-Event Working Note

**Version:** 0.1  
**Date:** 23 September 2026  
**Status:** Core Cohort 1 estimand/intercurrent-event rules substantially confirmed; only detailed SAP implementation and ancillary oncologic-endpoint hierarchy remain.

---

## 1. Current Cohort 1 estimand framework

### Population

Participants with colon cancer after curative surgery who are planned to receive 6 months of mFOLFOX6 adjuvant chemotherapy.

### Treatment conditions

Participants are randomized to:

- high-dose AK135;
- low-dose AK135;
- placebo;

with the assigned study treatment administered in the protocol-defined mFOLFOX6 adjuvant-chemotherapy background.

Primary treatment contrasts:

- high-dose AK135 vs placebo;
- low-dose AK135 vs placebo.

### Variable

Binary indicator of whether CTCAE grade >=2 CIPN occurs from baseline through 3 months after the **actual last mFOLFOX6 adjuvant treatment**.

For participant i:

[
Y_i =
egin{cases}
1, & 	ext{CTCAE grade >=2 CIPN occurs during the observation period},\
0, & 	ext{no CTCAE grade >=2 CIPN occurs during the observation period}.
end{cases}
]

### Population-level summary

For each randomized group, estimate the proportion of participants who develop CTCAE grade >=2 CIPN during the defined observation period.

Treatment effects are expressed as risk differences:

[
Delta_L = p_P - p_L,
qquad
Delta_H = p_P - p_H,
]

where positive values favor AK135.

---

## 2. Current distinction between intercurrent events and missing endpoint data

A key working principle is to distinguish:

1. **intercurrent events**, which occur after randomization and affect interpretation or observation of the endpoint; from
2. **missing or indeterminate primary-endpoint status**, where the endpoint cannot ultimately be classified as 0 or 1.

An incomplete AK135 treatment course does **not** automatically imply CIPN failure.

Likewise, a participant whose endpoint cannot be determined because follow-up is incomplete should not be conceptually conflated with a participant who actually experienced CTCAE grade >=2 CIPN.

---

## 3. Early discontinuation of AK135

### Current working strategy

Use a **treatment-policy strategy**.

Early discontinuation of AK135 itself is not considered a primary-endpoint event.

Participants should continue to be followed for the primary endpoint whenever feasible, irrespective of whether AK135 is completed.

Examples:

- AK135 discontinued early; later CTCAE grade >=2 CIPN occurs -> (Y=1).
- AK135 discontinued early; endpoint observation completed with no CTCAE grade >=2 CIPN -> (Y=0).
- AK135 discontinued early; subsequent follow-up is insufficient to determine the endpoint -> endpoint status is missing/indeterminate and handled under the prespecified missing-data strategy.

Working wording:

> Early discontinuation of AK135 will be handled using a treatment-policy strategy. Primary-endpoint data collected after AK135 discontinuation will continue to contribute to the primary estimand. Early AK135 discontinuation itself will not be classified as CTCAE grade >=2 CIPN.

---

## 4. Early permanent discontinuation of mFOLFOX6

### Current endpoint anchor

The current endpoint definition uses the participant's **actual last mFOLFOX6 adjuvant treatment** as the anchor.

Therefore, if mFOLFOX6 is permanently discontinued before completion of the planned 6-month course, the participant's primary observation period currently ends 3 months after the actual last mFOLFOX6 treatment.

Under this working definition:

- early chemotherapy discontinuation itself is not a CIPN event;
- if follow-up through 3 months after the actual last mFOLFOX6 treatment is complete and no CTCAE grade >=2 CIPN occurs, (Y=0);
- if CTCAE grade >=2 CIPN occurs before that point, (Y=1).

### Important implication

Participants who discontinue oxaliplatin-containing chemotherapy early may have lower cumulative neurotoxic exposure and a shorter opportunity to develop CIPN.

Therefore, the estimand interpretation depends materially on the use of the actual last mFOLFOX6 treatment as the endpoint anchor.

### Confirmed position and supplementary analysis

The actual last mFOLFOX6 treatment + 3 months remains the primary endpoint anchor.

A fixed planned-treatment-horizon analysis may be retained as a **supplementary/exploratory analysis**, rather than as a core primary-endpoint sensitivity analysis. Its purpose is to explore whether imbalance in mFOLFOX6 exposure or early permanent discontinuation materially affects interpretation of the primary result.

Relevant exposure summaries should include, where available, actual treatment cycles, cumulative oxaliplatin dose, relative dose intensity, and reasons for early permanent discontinuation.

---

## 5. Death before the end of the primary endpoint window

Death must be treated separately from ordinary loss to follow-up.

### If CTCAE grade >=2 CIPN occurs before death

The primary endpoint is already determined:

[
Y=1.
]

### If death occurs before the endpoint window ends and no CTCAE grade >=2 CIPN has been observed

The current working position is:

- death itself should **not** automatically be classified as a CIPN event;
- death should **not** automatically be classified as absence of CIPN;
- the CIPN endpoint is indeterminate/missing if death prevents completion of the required endpoint observation.

This is conceptually distinct from oncologic safety endpoints such as DFS or OS, for which death may itself be an event by definition.

### Relevant precedent: POLAR-A

POLAR-A (NCT03654729), a closely related randomized trial in patients receiving oxaliplatin-based adjuvant treatment, provides a useful precedent:

- study-treatment or mFOLFOX6 discontinuation did not automatically terminate all subsequent assessments;
- death was an explicit exception to continued assessment;
- when the primary CIPN assessment was unavailable, the endpoint entered the trial's missing-data framework rather than death being automatically reclassified as CIPN;
- DFS treated death as an oncologic event, illustrating the distinction between CIPN efficacy and oncologic safety.

Public documents:

- Protocol: https://cdn.clinicaltrials.gov/large-docs/29/NCT03654729/Prot_000.pdf
- SAP: https://cdn.clinicaltrials.gov/large-docs/29/NCT03654729/SAP_001.pdf

This precedent supports keeping death separate from the CIPN event definition while prespecifying how the resulting missing endpoint is handled.

---

## 6. Missing/indeterminate primary-endpoint status

A participant may have an indeterminate primary endpoint if the observation required to classify (Y=0) is not completed.

Examples include:

- loss to follow-up before the end of the required window;
- death before the end of the required window without prior CTCAE grade >=2 CIPN;
- initiation of a new anti-cancer treatment with a clearly established clinically relevant risk of inducing CIPN before completion of the primary endpoint window, when no prior CTCAE grade >=2 CIPN event has occurred;
- other circumstances preventing determination of the endpoint under the prespecified observation rule.

The **final primary analysis is confirmed as observed/evaluable cases**:

[
hat p_j = x_j/E_j,
]

where (E_j) is the number of participants in arm (j) with a determinate binary endpoint.

Indeterminate participants are not automatically classified as events or non-events. Their number, percentage, and reasons will be reported by treatment group.

Prespecified sensitivity analyses may include all-missing-as-event, differential worst-case assignment, and, if warranted by the amount of missing data, tipping-point or delta-adjusted analyses.

---

## 7. Confirmed Stage 1 cohort and analysis-ready definitions

The following operational definitions are now confirmed.

### 7.1 Stage 1 cohort

For the current working design with 150 total randomized participants and a nominal 35% Stage 1 look, the Stage 1 cohort is:

[
oxed{	ext{the first 54 randomized participants overall}}
]

according to randomization order.

Later randomized participants must not replace an earlier Stage 1 participant merely because their primary endpoint becomes available sooner.

The exact CP calculation will use the realized arm-specific Stage 1 sample sizes rather than assuming exact 18/18/18 allocation.

### 7.2 Participant-level Stage 1 status

Each Stage 1 participant ultimately enters one of three primary-endpoint states:

[
oxed{Y=1,quad Y=0,quad Y=	ext{indeterminate}}
]

where:

- (Y=1): CTCAE grade >=2 CIPN occurs during the participant-specific primary endpoint window;
- (Y=0): the required primary endpoint window is completed without CTCAE grade >=2 CIPN;
- **indeterminate**: the endpoint can no longer be classified as 0 or 1 because the required observation cannot be completed, for example because of death before endpoint-window completion without prior event or permanent loss to follow-up.

### 7.3 Analysis-ready is not the same as endpoint-evaluable

A Stage 1 participant is **analysis-ready** once one of the three states above is final.

Therefore an indeterminate endpoint is analysis-ready even though it is not endpoint-evaluable.

This prevents a permanently missing participant from indefinitely delaying Stage 1 and preserves the prespecified randomization-order cohort.

For Stage 1, indeterminate outcomes are handled using the confirmed **available-case + consumed-slot CP** approach: the participant continues to consume a randomized sample-size slot but does not contribute an observed binary endpoint. Future recruitment capacity is calculated from randomized/consumed slots rather than from evaluable endpoint counts.

---

## 8. New anti-cancer treatment with clear CIPN risk

A new anti-cancer treatment is considered an intercurrent event for the primary CIPN endpoint **only when it has a clearly established clinically relevant potential to induce CIPN**.

The rule is intentionally narrower than "any subsequent anti-cancer therapy."

Examples of subsequent treatments without a clear clinically relevant CIPN risk should not, solely because they are anti-cancer treatments, terminate primary CIPN follow-up.

### Operational rule

If CTCAE grade >=2 CIPN occurs before initiation of the new neurotoxic anti-cancer treatment:

[
Y=1.
]

If no CTCAE grade >=2 CIPN has occurred and the new neurotoxic anti-cancer treatment is initiated before completion of the participant-specific primary endpoint window:

- CIPN assessments after initiation of that treatment will not contribute to the primary endpoint;
- because the original primary window was not completed, the binary endpoint is classified as **indeterminate/missing**, rather than automatically as (Y=0).

In protocol/SAP wording, "censoring" may be used informally to describe the clinical cutoff, but for the binary primary analysis the more precise wording is that **endpoint ascertainment is truncated at initiation of the new neurotoxic treatment and the endpoint becomes indeterminate if no prior event has occurred**.

The exact list or rule for what qualifies as a "new anti-cancer treatment with clear CIPN risk" should be prespecified operationally, preferably by treatment class rather than adjudicated retrospectively case by case.


---

## 9. Items still to be decided

The remaining open implementation items are:

1. Exact operational definition/list of new anti-cancer treatments considered to have a clearly established clinically relevant CIPN risk.
2. Detailed specification of the supplementary fixed planned-treatment-horizon analysis, if retained in the SAP.
3. Detailed tipping-point/delta-adjusted implementation if the amount of indeterminate data makes such analysis meaningful.
4. Whether oncologic endpoints such as DFS/OS should be explicitly grouped under "oncologic safety" in the study endpoint hierarchy.

---

## 10. Current working summary

| Event / circumstance | Current working treatment |
|---|---|
| Early discontinuation of AK135 | Treatment-policy strategy; continue endpoint follow-up; discontinuation itself is not a CIPN event |
| Early permanent discontinuation of mFOLFOX6 | Primary window remains anchored to actual last mFOLFOX6 + 3 months; fixed planned-horizon analysis may be supplementary/exploratory |
| CTCAE grade >=2 CIPN before death | Endpoint event, (Y=1) |
| Death before endpoint window ends, no prior CTCAE grade >=2 CIPN | CIPN endpoint becomes indeterminate/missing; death itself is not currently treated as CIPN |
| Loss to follow-up before endpoint can be determined | Missing/indeterminate endpoint; primary final analysis uses observed/evaluable cases |
| DFS / OS death handling | Separate oncologic-safety framework; death may be an event according to the endpoint definition |


| New anti-cancer treatment with clear clinically relevant CIPN risk before endpoint-window completion | Use CIPN data only up to its initiation; prior CIPN event remains Y=1; otherwise endpoint becomes indeterminate/missing |
| New anti-cancer treatment without clear clinically relevant CIPN risk | Does not by itself terminate primary CIPN follow-up |
