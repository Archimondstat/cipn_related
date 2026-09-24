# CP interim timing under different accrual speeds

**Version:** 0.1  
**Date:** 25 September 2026  
**Status:** Working literature + operational note; no Stage 1 timing selected.

---

## 1. Question

For the current three-arm CIPN Phase II design, determine how the Stage 1 conditional-power (CP) analysis should be timed when recruitment speed varies.

The key issue is that the primary endpoint is delayed. A nominal "40% information" interim does **not** imply that only 40% of the total trial has been randomized when the decision is made.

This note therefore separates:

1. **statistical information time**: the number of participants with mature primary-endpoint data used in the CP calculation;
2. **operational decision time**: the calendar time at which that mature information becomes available;
3. **randomized fraction at decision**: how much of the maximum trial has already been enrolled by the time the CP decision can actually be made.

The current operational working assumption is continuous recruitment without a design-level hard pause or formal overrun cap.

---

## 2. Recent evidence relevant to timing

### 2.1 CP timing is not independent of the future-effect assumption

Edwards, Walters and Julious (Trials, 2023) re-analysed 21 outcomes from 14 completed trials and examined CP as outcome information accumulated.

Their practical conclusion was:

- when CP is used primarily for **futility** and the future data are assumed to follow the **current observed trend**, an interim analysis at about **30% mature outcome data** may be reasonable;
- when more optimistic confidence-limit assumptions are used, later timing around **60-70% mature data** was suggested where logistically feasible.

This is important for the present project because the current calibration uses a **design/target-effect future assumption**, not the observed interim trend. Therefore, the paper's "30%" result cannot simply be imported as our timing rule.

### 2.2 ICH E20 explicitly links interim timing to accrual and endpoint delay

The 2025 ICH E20 Step 2b draft states that interim timing should be justified using factors such as:

- probability of early stopping;
- expected and maximum sample size / number of events;
- whether enough follow-up exists for a reliable decision.

It also notes that adaptive designs may provide little benefit when participant enrollment is fast relative to the time required to observe the adaptation endpoint.

Thus the relevant quantity is not only the nominal Stage 1 information fraction.

### 2.3 Pipeline patients are a primary design issue with delayed endpoints

Recent work on delayed outcomes emphasizes that participants can be randomized after the Stage 1 cohort has entered but before their endpoints mature.

Baayen et al. (Statistics in Medicine, 2025) give a tutorial on group-sequential trials with delayed repeated outcomes and explicitly treat these participants as pipeline patients.

Schüürhuis et al. (Statistics in Medicine, 2024) likewise note that sequential methods with delayed responses either create pipeline patients or require recruitment to be paused.

For this project, because a formal design-level pipeline cap is currently not assumed, these participants must be treated as an expected operational consequence rather than an exception.

### 2.4 Endpoint delay can erase much of the efficiency benefit

Grayling et al. (Statistics in Medicine, 2025) studied endpoint delay in MAMS trials. Their setting is not identical to ours, but the operational result is directly relevant: when endpoint delay exceeds roughly one third of the total recruitment duration, more than half of the expected efficiency gain from adaptation is typically lost.

This is useful as a warning metric, not as a formal boundary for this trial.

### 2.5 Very recent CP design work explicitly incorporates overrun

Anderson and Pedley (arXiv, August 2026) compare two-stage group-sequential and conditional-power sample-size-re-estimation designs using **gsDesign**. Their example evaluates a 50% interim together with a prespecified enrollment overrun.

The main practical lesson for this note is that expected sample size and interim timing should be evaluated **including enrollment that occurs before the interim decision is available**, not only using the nominal Stage 1 sample.

---

## 3. Current design quantities

Current anchor:

- three randomized arms;
- maximum sample size: **N = 44 per arm = 132 total**;
- binary primary endpoint;
- primary endpoint maturity delay: approximately **4-6 months**;
- existing Stage 1 grid: **35%, 40%, 45%, 50% mature information**.

The existing nominal mature sample sizes are:

| Nominal Stage 1 information | Mature n/arm | Mature total N1 |
|---:|---:|---:|
| 35% | 15 | 45 |
| 40% | 18 | 54 |
| 45% | 20 | 60 |
| 50% | 22 | 66 |

Let:

- (r) = total recruitment rate, participants/month across all three arms;
- (L) = time from randomization to primary-endpoint maturity, months;
- (N_1) = mature Stage 1 target.

Under approximately constant recruitment:

[
t_{IA} approx rac{N_1}{r}+L.
]

If recruitment continues while Stage 1 outcomes mature, the number randomized by the time the interim decision is available is approximately:

[
N_{rand,IA}
=
minleft(N,;N_1+rLight).
]

Define the **operational decision fraction**:

[
q_{op}
=
rac{N_{rand,IA}}{N}.
]

This is distinct from the statistical information fraction.

A second useful quantity is:

[
ho=rac{rL}{N}.
]

It measures endpoint delay as a fraction of the entire recruitment duration. Larger (ho) means more patients enter the trial while waiting for Stage 1 outcomes to mature.

---

## 4. Working accrual grid: 6-month endpoint maturity

The table below uses the conservative end of the current 4-6 month endpoint window: **L = 6 months**.

| Recruitment rate (total/month) | Stage 1 info | Mature N1 | Approx. IA month | Randomized by IA | Fraction randomized by IA |
|---:|---:|---:|---:|---:|---:|
| 3 | 35% | 45 | 21.0 | 63 | 48% |
| 3 | 40% | 54 | 24.0 | 72 | 55% |
| 3 | 45% | 60 | 26.0 | 78 | 59% |
| 3 | 50% | 66 | 28.0 | 84 | 64% |
| 6 | 35% | 45 | 13.5 | 81 | 61% |
| 6 | 40% | 54 | 15.0 | 90 | 68% |
| 6 | 45% | 60 | 16.0 | 96 | 73% |
| 6 | 50% | 66 | 17.0 | 102 | 77% |
| 9 | 35% | 45 | 11.0 | 99 | 75% |
| 9 | 40% | 54 | 12.0 | 108 | 82% |
| 9 | 45% | 60 | 12.7 | 114 | 86% |
| 9 | 50% | 66 | 13.3 | 120 | 91% |
| 12 | 35% | 45 | 9.8 | 117 | 89% |
| 12 | 40% | 54 | 10.5 | 126 | 95% |
| 12 | 45% | 60 | 11.0 | 132 | 100% |
| 12 | 50% | 66 | 11.5 | 132 | 100% |

### Immediate interpretation

At **3/month**, even a 50% mature-data interim still occurs when only about 64% of the maximum trial has been randomized. The CP interim can materially save current-trial enrollment.

At **6/month**, 35-40% mature information corresponds to approximately 61-68% randomized at decision. A 50% information interim is operationally much later: about 77% randomized.

At **9/month**, a 35% mature-data interim is already made after about 75% of the maximum trial has been randomized. Later nominal information fractions quickly lose current-trial sample-saving value.

At **12/month**, 45-50% mature-data interims would occur only after full accrual. Even 35% mature information would not produce a decision until about 89% of the maximum sample has entered.

---

## 5. Sensitivity: 4-month endpoint maturity

If the endpoint can be treated as mature at **4 months**, the situation improves substantially.

| Recruitment rate (total/month) | 35% info: randomized fraction at IA | 40% info | 45% info | 50% info |
|---:|---:|---:|---:|---:|
| 3 | 43% | 50% | 55% | 59% |
| 6 | 52% | 59% | 64% | 68% |
| 9 | 61% | 68% | 73% | 77% |
| 12 | 70% | 77% | 82% | 86% |

Therefore the final Stage 1 timing decision cannot be separated from the exact endpoint horizon. A Month-4 endpoint and a Month-6 endpoint lead to materially different adaptive value even if the same nominal information fraction is used.

---

## 6. Proposed way to choose the interim time

### Principle 1: trigger on mature endpoint information, not calendar date

The primary trigger should remain:

> conduct the Stage 1 efficacy/futility analysis when the prespecified number of randomized-order Stage 1 participants have mature primary-endpoint data.

Calendar time is a derived operational quantity.

### Principle 2: choose the mature information fraction jointly with accrual speed

The timing should not be fixed as "50%" before the expected recruitment rate is known.

A working screen is:

- **slow accrual**: later Stage 1 timing (40-50%) can still save meaningful enrollment;
- **moderate accrual**: 35-40% should receive priority;
- **fast accrual relative to endpoint maturity**: even a 35% interim may occur after most participants are randomized.

For the current N=132 and L=6 months:

[
ho = rac{6r}{132}.
]

So:

| r/month | rho |
|---:|---:|
| 3 | 0.14 |
| 6 | 0.27 |
| 9 | 0.41 |
| 12 | 0.55 |

Once recruitment is around **9/month or faster**, endpoint delay exceeds one third of the total recruitment duration. This enters the range where recent delayed-endpoint work suggests large losses in adaptive efficiency.

### Principle 3: do not automatically move the CP look earlier than its statistical reliability supports

The 2023 CP study provides evidence that an interim around 30% can work for futility **when future outcomes are assumed to follow the current observed trend**.

Our current CP calibration instead uses the design/target future assumption:

[
p_P^{future}=0.45,qquad p_T^{future}=0.30.
]

That assumption is intentionally optimistic for future treatment performance and can make early futility harder to trigger.

Therefore:

> fast recruitment is not, by itself, a sufficient reason to move the current CP rule to 30%.

If 30-35% timing is considered, it must be recalibrated jointly with the future-effect assumption and CP cutoff.

### Principle 4: distinguish two roles for the interim

If recruitment is sufficiently fast that most or all N=132 will already be randomized before mature Stage 1 data are available, the interim can still have value for:

- dose selection;
- stopping further treatment/program expansion;
- deciding whether to proceed to the next development stage;
- safety / benefit-risk review.

But it should no longer be sold primarily as a mechanism to reduce the number randomized in the current Phase II trial.

---

## 7. Initial working interpretation for this project

No final timing is selected, but the present evidence suggests the following direction.

### If recruitment is approximately 3/month

40-50% mature information remains operationally plausible.

### If recruitment is approximately 6/month

35-40% mature information is more attractive than 50%.

At L=6 months:

- 35% information -> about 61% already randomized;
- 40% information -> about 68%;
- 50% information -> about 77%.

### If recruitment is approximately 9/month

35% should be the first timing to evaluate.

Even then, about 75% of the maximum sample is expected to have been randomized by the decision if L=6 months.

The design should be evaluated primarily for decision quality rather than expected sample-size savings.

### If recruitment is approximately 12/month

A conventional mature-endpoint CP interim has little ability to reduce current-trial enrollment under a 6-month endpoint.

In this setting, the project has only three real options:

1. accept that Stage 1 is mainly a development/dose-selection decision rather than a sample-saving device;
2. move the look earlier, but only if simulation shows acceptable false-No-Go behavior;
3. use valid partial/short-term outcome information at interim, which would be a materially different design.

---

## 8. Next simulation layer

The next operating-characteristic simulation should explicitly add calendar accrual.

Recommended first grid:

- total recruitment rate: **3, 6, 9, 12 participants/month**;
- endpoint maturity: **4, 5, 6 months**;
- Stage 1 mature information: **30%, 35%, 40%, 45%, 50%**;
- CP cutoff: **25%, 30%, 35%**;
- CP future-data assumption:
  - current target-effect assumption;
  - observed-current-trend assumption;
  - optional shrinkage assumption.

For each scenario report:

1. probability of project-level Stage 1 No-Go under the global null;
2. false No-Go probability under the 15% target effect;
3. probability of correct dose continuation/selection;
4. calendar month of interim decision;
5. number and fraction randomized when the decision is available;
6. number of participants whose randomization can actually be avoided after a futility decision;
7. expected total randomized sample size;
8. probability that full accrual is completed before the interim decision;
9. final Go / Consider / No-Go classification operating characteristics.

This should be the basis for selecting Stage 1 timing. The timing should not be chosen from the nominal information fraction alone.

---

## 9. References

1. Edwards JM, Walters SJ, Julious SA. *A retrospective analysis of conditional power assumptions in clinical trials with continuous or binary endpoints.* Trials. 2023;24. PMID: 36949524.
2. ICH E20. *Adaptive Designs for Clinical Trials*, Step 2b draft. 2025.
3. Baayen C, et al. *Design and Analysis of Group Sequential Trials for Repeated Measurements When Pipeline Data Occurs: A Tutorial.* Statistics in Medicine. 2025;44:e70130.
4. Schüürhuis A, et al. *A two-stage group-sequential design for delayed treatment responses with the possibility of trial restart.* Statistics in Medicine. 2024.
5. Grayling MJ, et al. *Impact of Endpoint Delay on the Efficiency of Multi Arm Multi Stage Trials.* Statistics in Medicine. 2025.
6. Anderson KM, Pedley A. *Two-Stage Design with Sample Size Re-estimation Using gsDesign.* arXiv:2608.03456. 2026.

---

## 10. Bottom line

The Stage 1 timing problem should be rewritten as:

[
oxed{	ext{Choose mature information fraction }f_1	ext{ conditional on accrual rate }r	ext{ and endpoint delay }L}
]

rather than:

[
oxed{	ext{Choose }f_1	ext{ alone}.}
]

For this trial, the operationally relevant quantity is:

[
oxed{N_{rand,IA}approx N_1+rL}
]

because it tells us how much of the current trial is already committed before CP can change recruitment.
