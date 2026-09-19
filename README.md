# CIPN-related Phase II adaptive design

## Working structure

This repository contains two linked but separate workstreams:

1. **Design workstream** — the main focus of the current design discussion.
2. **Competitor-analysis workstream** — maintained separately and used to inform design assumptions.

The competitor review is archived in `docs/competitor_landscape.md`. A separate conversation will be used for expanding that landscape. The current design discussion should stay focused on the adaptive Phase II design itself and only import competitor-derived assumptions once they are sufficiently supported.

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

Because lower incidence is better, define benefit using absolute risk reduction:

- Delta_L = p0 - pL;
- Delta_H = p0 - pH.

The first simulation should use the same clinically meaningful thresholds under FREQ-01 and BAYES-01:

- delta_min = minimum worthwhile absolute risk reduction;
- delta_target = target absolute risk reduction.

## Current methodological position

The project will compare two primary adaptive frameworks:

- **FREQ-01:** inverse-normal combination testing + closed testing / Dunnett-type multiplicity control + adaptive dose selection + conditional-error-based sample-size reassessment.
- **BAYES-01:** weak-prior Bayesian binary model + posterior clinically worthwhile benefit + predictive probability of final success.

Both designs should permit the same Stage 1 actions:

- No-Go;
- Low only;
- High only;
- Both.

The designs should be compared under common clinical scenarios rather than under different treatment-effect definitions.

## Competitor evidence: archived, not yet converted into design assumptions

Initial competitor work indicates substantial heterogeneity in CTCAE grade >=2 CIPN control rates and observed treatment effects. These findings are intentionally **not yet** converted into fixed values of p0, delta_min, or delta_target.

See:

- `docs/competitor_landscape.md`

The competitor-analysis workstream will separately refine:
- chemotherapy-backbone-specific control rates;
- endpoint-horizon definitions;
- realistic absolute risk reductions;
- endpoint evaluability and attrition;
- design precedents for dose selection and Go/No-Go.

## Next design step

After the competitor-analysis workstream returns a sufficiently supported range for p0 and plausible treatment effects, the design workstream will:

1. freeze the binary estimand;
2. specify candidate p0, delta_min, and delta_target scenarios;
3. specify Stage 1 timing/information fraction;
4. define FREQ-01 interim decision rules;
5. define BAYES-01 posterior/PPoS decision rules;
6. compare operating characteristics by simulation.
