# CIPN Phase II Cohort 1
## Estimand and Intercurrent-Event Working Note

**Version:** 0.1  
**Date:** 23 September 2026  
**Status:** Working draft; several strategies remain to be confirmed by the project team.

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

### Open item

The project team should confirm whether this remains the intended primary strategy and whether a sensitivity analysis using an alternative fixed/planned treatment horizon is needed to assess robustness to early chemotherapy discontinuation.

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
- other circumstances preventing determination of the endpoint.

The missing-data strategy is **not yet finalized**.

A simple rule such as classifying every incomplete participant as a CIPN event may be excessively conservative, especially when incompleteness is unrelated to CIPN.

Potential sensitivity-analysis approaches discussed include:

- observed/evaluable cases;
- multiple imputation;
- tipping-point / delta-adjusted analyses.

The primary missing-data assumption and its relationship to the Stage 1 CP analysis remain to be defined.

---

## 7. Consequence for Stage 1 timing

Stage 1 membership remains based on **randomization order**, rather than selecting whichever participants become analyzable first.

However, permanent loss to follow-up or death can prevent a participant from ever obtaining an observed (Y=0/1) under a strict "endpoint determined" definition.

Therefore, the Stage 1 trigger should distinguish between:

- **Stage 1 membership**: defined prospectively by randomization order; and
- **analysis-ready status**: the participant has either:
  - already experienced CTCAE grade >=2 CIPN;
  - completed the required primary-endpoint observation without the event; or
  - reached the point at which the endpoint can no longer be observed and is therefore classified as missing/indeterminate.

This prevents a permanently missing participant from indefinitely delaying Stage 1 while preserving the randomization-order rule.

The corresponding missing endpoint must then be handled according to the prespecified Stage 1 analysis rule rather than replaced by a later randomized participant.

---

## 8. Items still to be decided

The following remain open:

1. Exact estimand strategy for early permanent discontinuation of mFOLFOX6.
2. Whether an alternative fixed/planned chemotherapy horizon should be included as a sensitivity analysis.
3. Formal strategy for death before completion of the CIPN observation window.
4. Primary missing-data assumption for an indeterminate binary CIPN endpoint.
5. Sensitivity analyses for missing endpoint data.
6. How missing/indeterminate Stage 1 outcomes enter the CP calculation.
7. Whether new anti-cancer treatment should be defined as a separate intercurrent event and, if so, which estimand strategy should apply.
8. Whether oncologic endpoints such as DFS/OS should be explicitly grouped under "oncologic safety" in the study endpoint hierarchy.

---

## 9. Current working summary

| Event / circumstance | Current working treatment |
|---|---|
| Early discontinuation of AK135 | Treatment-policy strategy; continue endpoint follow-up; discontinuation itself is not a CIPN event |
| Early permanent discontinuation of mFOLFOX6 | Anchor primary window to actual last mFOLFOX6 + 3 months; strategy still requires project-team confirmation |
| CTCAE grade >=2 CIPN before death | Endpoint event, (Y=1) |
| Death before endpoint window ends, no prior CTCAE grade >=2 CIPN | CIPN endpoint becomes indeterminate/missing; death itself is not currently treated as CIPN |
| Loss to follow-up before endpoint can be determined | Missing/indeterminate endpoint; missing-data method to be prespecified |
| DFS / OS death handling | Separate oncologic-safety framework; death may be an event according to the endpoint definition |

