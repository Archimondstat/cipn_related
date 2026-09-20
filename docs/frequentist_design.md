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


## Candidate operational strategy: Simon-style staged accrual with enrollment slowdown

A practical candidate for this project is a **Simon-style two-stage screening concept combined with controlled accrual slowdown**, inspired by the operational precedent of Alliance A221805 but adapted to this three-arm randomized study.

Working rule:

1. Enroll Stage 1 until the prespecified Stage 1 accrual/evaluable target has been reached.
2. Once the Stage 1 target cohort is fully accrued, **do not stop recruitment abruptly**. Instead, operationally slow recruitment while waiting for the 4-6 month primary endpoint to mature.
3. Subjects enrolled after the Stage 1 target cohort are treated as **overrun/pipeline subjects**.
4. The Stage 1 interim decision uses **only the prespecified Stage 1 cohort with mature primary-endpoint data**. Overrun/pipeline subjects are excluded from the interim efficacy calculation, even if some have already been randomized.
5. Overrun/pipeline subjects remain in follow-up and their mature efficacy and safety data are retained for the **overall Phase II evidence package and the subsequent decision on whether/how to proceed to Phase III**.
6. If an arm is dropped for efficacy futility, no new subjects are randomized to that arm after the interim decision. Subjects already randomized before the decision continue according to the prespecified follow-up/treatment rules unless safety/benefit-risk considerations require otherwise.
7. Safety information remains continuously reviewable and is not restricted to the Stage 1 efficacy cohort.

This strategy intentionally separates:

- **Stage 1 decision cohort**: fixed/prespecified and used for the interim Go/No-Go rule;
- **overrun/pipeline cohort**: excluded from the interim efficacy rule but retained as later supportive evidence.

The enrollment-slowdown intensity and any maximum permitted overrun remain to be calibrated using expected accrual speed and endpoint delay. This is currently a working operational option, not yet the final design.
