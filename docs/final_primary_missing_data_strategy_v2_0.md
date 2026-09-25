# Final primary-endpoint missing-data strategy

**Version:** 2.0  
**Date:** 25 September 2026  
**Status:** Primary analysis approach confirmed; detailed SAP wording and tipping-point implementation remain to be finalized.

## 1. Context already fixed

For Cohort 1, the primary endpoint is the binary indicator of whether CTCAE grade >=2 CIPN occurs from baseline through 3 months after the participant's actual last mFOLFOX6 adjuvant treatment.

A participant is classified as:

[
Y=1
]

if CTCAE grade >=2 CIPN occurs during the window, and:

[
Y=0
]

if the full required observation window is completed without such an event.

If the required observation cannot be completed and no event has already occurred, the endpoint is **indeterminate/missing** rather than automatically classified as event or non-event.

The project currently expects permanent indeterminate endpoints to be uncommon, but no numerical missing-rate assumption is considered sufficiently evidence-based to be used as a design parameter.

## 2. Regulatory/statistical principle

The treatment-policy/intercurrent-event definition and the missing-data method should remain conceptually separate.

ICH E9(R1) distinguishes intercurrent events from missing data and emphasizes that data that would be relevant to the estimand but are not collected create a missing-data problem requiring explicit assumptions and sensitivity analysis.

Therefore:

- AK135 discontinuation or early mFOLFOX6 discontinuation does not itself determine the binary endpoint;
- if the endpoint remains observable, follow-up continues according to the estimand strategy;
- if the endpoint ultimately cannot be determined, a missing-data method is required.

## 3. Closest disease-area precedent

The POLAR SAP, in a closely related oxaliplatin/CIPN prevention setting, did not force a single deterministic clinical classification for missing primary endpoints.

For its binary primary endpoint it prespecified:

1. observed cases;
2. missing treated as non-responder;
3. tipping-point analysis, including a multiple-imputation style MAR analysis followed by increasingly unfavorable assumptions for the experimental arm.

This supports keeping the clinical endpoint definition separate from the statistical missing-data sensitivity framework.

## 4. Candidate approaches for AK135

### Option A: observed/evaluable cases as the primary analysis

For each arm:

[
hat p_j=
rac{x_j}{E_j},
]

where (E_j) is the number of participants with a determinate binary endpoint.

Advantages:

- very simple;
- directly aligned with the current Stage 1 available-case CP;
- transparent for an exploratory Phase II trial;
- if permanent missingness is truly very small, numerical impact should be limited.

Limitation:

- the treatment comparison is valid for the randomized target population only under a strong assumption that missingness does not distort the event-rate comparison;
- differential or informative missingness can bias the observed-case risk difference.

### Option B: multiple imputation under a primary MAR assumption

Indeterminate binary outcomes are imputed under a prespecified missing-at-random model, and the treatment-arm event proportions/risk differences are calculated in each completed dataset and combined across imputations.

Advantages:

- keeps all randomized participants in the primary analysis;
- provides a more explicit statistical assumption for missing outcomes;
- naturally supports delta-adjusted/tipping-point sensitivity analyses.

Limitations:

- more complicated than the rest of the current exploratory design;
- model specification may be unstable or arbitrary if the number of missing outcomes is very small;
- partial follow-up means the missing binary endpoint is not identical to a simple missing fixed-visit Bernoulli observation.

### Option C: deterministic imputation as the primary analysis

Examples include imputing all indeterminate participants as CIPN events or using differential worst-case assignment.

This is not preferred.

It conflates missingness with a clinical outcome and can be excessively conservative or directionally biased. It is better suited to sensitivity analysis.

## 5. Working recommendation

Given:

- the exploratory Phase II purpose;
- the current expectation that permanent indeterminate endpoints will be uncommon;
- the desire to keep the two-stage rule operationally simple;
- the disease-area precedent from POLAR;

the current leading proposal is:

[
oxed{	ext{Primary final analysis: observed/evaluable cases}}
]

with prespecified missing-data sensitivity analyses.

This is not because observed-case analysis is assumption-free. Its assumption should be stated explicitly and the amount/reasons for missingness should be reported by treatment group.

## 6. Proposed sensitivity hierarchy

### Sensitivity 1: all-missing-as-event

Assign all indeterminate endpoints as CTCAE grade >=2 CIPN events in all groups.

This answers a simple conservative question about the absolute event rates, although it is not necessarily conservative for the between-group contrast if missingness differs by arm.

### Sensitivity 2: differential worst case for AK135

For each AK135-placebo comparison:

- indeterminate AK135 participants -> event;
- indeterminate placebo participants -> non-event.

This is deliberately unfavorable to AK135 and provides an easily interpretable extreme bound.

The reverse assignment may be shown as a best-case bound if useful, but should not be part of the primary decision rule.

### Sensitivity 3: tipping-point / delta-adjusted analysis

If the number of indeterminate endpoints is non-negligible, progressively increase the assumed probability of CIPN among missing AK135 participants relative to missing placebo participants until the efficacy interpretation changes.

This is the most informative MNAR sensitivity analysis and mirrors the logic used in POLAR.

The detailed implementation can be prespecified in the SAP rather than the protocol.

## 7. Relationship to the Stage 1 CP analysis

Stage 1 can remain:

[
oxed{	ext{available-case + consumed-slot CP}}
]

even if the final analysis includes richer missing-data sensitivity analyses.

Stage 1 CP is an operational decision-support tool, not the final estimator.

The Stage 1 method should therefore be described as an approximation based on the currently determinate endpoint information and true remaining recruitment capacity.

The final primary analysis and its missing-data sensitivities answer a different question: robustness of the final treatment-effect estimate and efficacy classification.

## 8. Proposed final reporting structure

For each randomized arm, report:

- randomized N;
- endpoint-determinate N;
- indeterminate N and percentage;
- reasons for indeterminate endpoint;
- observed CTCAE grade >=2 CIPN events;
- observed-case event proportion;
- treatment-placebo risk difference and confidence interval.

Then present the prespecified missing-data sensitivities alongside the primary result.

No participant with an indeterminate endpoint should be silently excluded from disposition reporting.

## 9. Decision still required

The key remaining choice is whether to lock:

[
oxed{	ext{observed/evaluable case as the primary final analysis}}
]

or use a formal MAR multiple-imputation analysis as primary.

The current balance of simplicity, expected low missingness, and the exploratory Phase II objective favors observed cases, provided robust sensitivity analyses are prespecified.
