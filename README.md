# CIPN-related Phase II adaptive design

## Current design question

Three-arm randomized Phase II study of drug C given concurrently with neurotoxic chemotherapy:

- Low-dose C
- High-dose C
- Placebo

A two-stage Go/No-Go design is required. Interim decisions should allow flexibility in dose continuation/selection.

## Primary endpoint for design and sample size

**Binary primary endpoint: CTCAE grade >=2 CIPN.**

The exact estimand still needs to be frozen, especially:
- assessment horizon (e.g. Month 4, Month 6, or cumulative through a fixed horizon);
- whether the endpoint is "CTCAE grade >=2 at the landmark visit" or "ever developed CTCAE grade >=2 by the horizon";
- handling of death, discontinuation, chemotherapy discontinuation, missing assessment, and competing/intercurrent events.

## Candidate statistical frameworks

### FREQ-01

Two-stage adaptive multi-arm frequentist design with:

- Low vs placebo and High vs placebo comparisons;
- stagewise binary-endpoint tests;
- inverse-normal combination test;
- strong family-wise type I error control using closed testing / Dunnett-type multiplicity adjustment;
- adaptive dose selection after Stage 1;
- conditional-error-based sample-size reassessment;
- non-binding futility / clinically defined gray zone for medical flexibility.

Allowed interim actions:
- No-Go;
- continue Low only;
- continue High only;
- continue both;
- reassess Stage 2 sample size within a prespecified maximum.

### BAYES-01

Bayesian binary-endpoint model with:

- initially weakly informative priors;
- separate Low and High treatment effects versus shared placebo;
- no monotonic dose-response assumption in the first version;
- posterior probability of clinically worthwhile benefit;
- predictive probability of final trial success for interim Go/No-Go and dose selection;
- optional Stage 2 sample-size adaptation.

## Common clinical quantities to define before simulation

Let

- p0 = placebo probability of CTCAE grade >=2 CIPN;
- pL = low-dose probability;
- pH = high-dose probability.

Because lower incidence is better, define benefit for dose j as either

- absolute risk reduction: Delta_j = p0 - p_j, or
- risk ratio / odds ratio if clinically preferred.

The first simulation should use the same clinically meaningful thresholds under FREQ-01 and BAYES-01:

- delta_min = minimum worthwhile absolute risk reduction;
- delta_target = target absolute risk reduction.

## Next step

Freeze the binary estimand and plausible values for p0, delta_min, and delta_target before choosing Stage 1 information fraction, interim rules, and maximum sample size.
