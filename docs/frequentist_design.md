# Frequentist Phase II decision design (working note)

Date: 2026-09-19

## Positioning

This Phase II is currently treated as a **decision-oriented dose-selection study**, not a confirmatory hypothesis-testing study.

There are two active-vs-placebo treatment contrasts,

- Delta_L = p_P - p_L
- Delta_H = p_P - p_H

where p denotes the probability of the binary primary endpoint, CTCAE grade >=2 CIPN, and larger Delta means greater prevention benefit.

The existence of two contrasts does **not** by itself require formal testing of two null hypotheses. The primary design goal is to support:

- No-Go
- continue/select Low
- continue/select High
- continue Both at interim if warranted

and ultimately identify whether at least one dose has sufficient development value.

Formal combination testing / closed testing is retained only as an optional upgrade if a later regulatory strategy requires confirmatory inference from the same study.

## Primary endpoint

Binary primary endpoint:

**CTCAE grade >=2 CIPN**

The precise estimand remains to be frozen, especially whether the endpoint is cumulative ("ever by time X") or a landmark assessment.

## Final Phase II decision criterion: proposed structure

The final criterion should be based on clinical effect size and uncertainty rather than p<0.05.

Define:

- delta_min = minimum worthwhile absolute risk reduction (ARR)
- delta_target = target ARR

For dose j, the observed ARR is:

Delta_hat_j = p_hat_P - p_hat_j

A practical final decision framework is:

1. **Minimum-effect gate:** Delta_hat_j must be at least delta_min.
2. **Evidence/uncertainty gate:** the amount of statistical uncertainty must be acceptable.
3. **Benefit-risk gate:** safety and chemotherapy-delivery considerations can override efficacy continuation.

The exact evidence gate should be calibrated by simulation, rather than chosen by convention. Candidate implementations include:

- a lower confidence-bound criterion;
- a prespecified event-count / risk-difference boundary;
- a standardized score boundary calibrated directly to decision operating characteristics.

The preferred calibration targets are decision errors rather than confirmatory Type-I error:

- study-level false-Go probability when both active doses are ineffective;
- probability of correctly selecting an effective dose;
- false No-Go probability;
- probability of selecting the clinically better dose;
- expected sample size and trial duration.

## Stage 1 decision information

At interim, for each dose j use:

- observed event rates p_hat_P, p_hat_j;
- observed ARR Delta_hat_j;
- uncertainty interval for Delta_j;
- conditional probability of meeting the final Go criterion under a prespecified working assumption for future data.

Because this is not a confirmatory hypothesis test, the classical phrase "conditional power" can be misleading. In working documents, prefer:

**conditional probability of final Go**

and state the assumption used for future outcomes.

Candidate assumptions to compare:

- design-assumption CP: future data follow the target effect;
- observed-effect CP: future data follow the interim estimated effect;
- conservative shrinkage CP: future effect is shrunk toward delta_min or zero.

The interim futility rule should be non-binding unless safety/benefit-risk requires stopping.

## Interim decision regions

Each dose can be classified as:

- Futile
- Gray zone
- Promising

using a combination of Delta_hat_j and conditional probability of final Go.

This yields the operational actions:

- (Futile, Futile) -> No-Go
- (Promising, Futile) -> Low only
- (Futile, Promising) -> High only
- (Promising, Promising) -> Both may continue or a dose-selection rule may be applied
- gray-zone configurations -> prespecified medical review using supportive safety/PK/PD information

Safety may override an efficacy-based continuation recommendation.

## Delayed endpoint and accrual

The primary endpoint is expected to mature after approximately 4-6 months. Therefore the interim trigger should be based on **mature primary-endpoint observations**, not simply randomized subjects.

Operational options:

- hard pause;
- capped overrun;
- unrestricted continuous accrual.

The preferred option to study is capped overrun: allow a limited number of additional randomized subjects while waiting for Stage 1 outcomes, then pause if the cap is reached before interim maturity.

Pipeline subjects do not contribute to the Stage 1 efficacy decision unless their primary endpoint is mature.

## Next methodological task

Before choosing Stage 1 cutoffs, define the final Phase II Go criterion precisely.

Recommended order:

1. choose the clinical effect metric: ARR;
2. obtain plausible p_P, delta_min, delta_target from the competitor-analysis workstream;
3. define the final dose-level Go rule;
4. calibrate its evidence threshold by simulation to acceptable false-Go / correct-Go behavior;
5. derive Stage 1 conditional-probability and futility boundaries from that final rule;
6. evaluate hard pause vs capped-overrun operating characteristics.
