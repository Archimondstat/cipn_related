# Two Candidate Conditional-Power Designs for Internal Review

Date: 2026-09-21  
Status: working design framework

## Medical question deliberately left open

The final primary endpoint may require approximately 4-6 months to mature.

A potentially important alternative is to use an **earlier CIPN assessment** for Stage 1 futility, analogous in concept to VITALITY-HFpEF using Week 12 information to support a Week 24 futility decision.

This should **not** be adopted statistically until the medical team confirms whether an earlier CIPN measure/timepoint has sufficient clinical and predictive relevance for the final CTCAE grade >=2 CIPN endpoint.

Question for medical review:

> Is there an earlier timepoint or early CIPN signal (for example earlier CTCAE neuropathy status and/or another prespecified CIPN measure) that is clinically meaningful and sufficiently predictive of the final 4-6 month CTCAE grade >=2 CIPN outcome to support Stage 1 futility assessment?

Until this is resolved, both candidate designs below assume that Stage 1 is based on the prespecified mature endpoint cohort.

---

# Common design backbone

Both candidate designs share the following structure.

- Randomized Phase II
- Three initial arms: Placebo / Low-dose C / High-dose C
- Concurrent placebo required because historical CIPN incidence is considered unstable
- Binary primary endpoint: CTCAE grade >=2 CIPN
- Two-stage design
- Stage 1 uses conditional power (CP) for efficacy futility
- Stage 1 is triggered by a prespecified mature efficacy cohort
- Recruitment may be slowed after the Stage 1 accrual target is reached rather than abruptly stopped
- Patients accrued beyond the prespecified Stage 1 cohort are overrun/pipeline subjects
- Pipeline subjects are excluded from the prespecified Stage 1 efficacy calculation but retained for later Phase II evidence
- Safety stopping is separate and can override efficacy continuation
- Efficacy futility is intended to be non-binding, with any permitted clinical override prospectively specified
- The CP futility threshold is calibrated by simulation, not chosen by convention

For dose (jin{L,H}):

[
CP_j=P(	ext{dose }j	ext{ reaches the final Phase II success criterion}mid D_1,	ext{prespecified future-data assumption}).
]

Parameters still to be calibrated include:

- final Phase II success criterion;
- Stage 1 information size (n_1);
- CP futility cutoff (c_F);
- future-data assumption used for CP.

---

# Design A — Arm-wise CP futility with dose dropping

## Decision objective

Stage 1 evaluates both:

1. whether either individual dose is sufficiently futile to stop further randomization to that dose;
2. whether both doses are sufficiently futile to stop the entire program.

## Stage 1 rule

A dose is classified as statistically futile when:

[
CP_j<c_F.
]

Decision matrix:

| Low | High | Stage 1 action |
|---|---|---|
| non-futile | non-futile | Continue Low + High + placebo |
| futile | non-futile | Drop Low; continue High + placebo |
| non-futile | futile | Drop High; continue Low + placebo |
| futile | futile | Overall No-Go review |

The futility rule is preferably non-binding. A protocol-defined independent review may consider prespecified supportive information in borderline situations.

## Main reference precedent

**PTG-100-02 / NCT02895100**

Relevant design features:

- Phase 2b
- multiple active doses + placebo
- adaptive two-stage design
- interim futility assessment using conditional power
- dose dropping allowed
- safety/other efficacy/clinical judgment incorporated into the interim review framework
- overrun patients accrued while Stage 1 outcomes matured and retained for final analysis

Main value for our project:

[
oxed{	ext{CP futility + dose dropping + placebo + overrun + clinical review}}
]

## Main risks to quantify

- probability of wrongly dropping a truly effective dose;
- probability of overall false No-Go when one dose is effective;
- probability of correctly dropping an inactive dose;
- expected sample-size saving after dose dropping.

---

# Design B — Project-level CP futility only

## Decision objective

Stage 1 asks only whether the **overall program** is sufficiently futile to stop.

Individual dose CP values are calculated, but one low CP alone does not cause dose dropping.

## Stage 1 rule

[
CP_L<c_Fquad	ext{and}quad CP_H<c_F
]

triggers an overall futility review.

Otherwise:

[
	ext{Low + High + placebo all continue to Stage 2}.
]

Decision matrix:

| Low | High | Stage 1 action |
|---|---|---|
| non-futile | non-futile | Continue all 3 arms |
| futile | non-futile | Continue all 3 arms |
| non-futile | futile | Continue all 3 arms |
| futile | futile | Overall No-Go review |

Again, the futility recommendation may be non-binding if prospectively specified.

## Main reference precedent

**VITALITY-HFpEF / NCT03547583**

Relevant design features:

- Phase 2b
- two active doses + placebo, 1:1:1
- interim futility analysis
- the study-level futility signal required both dose comparisons to be below the futility boundary
- non-binding DSMC recommendation
- simulation-based calibration of the futility boundary and false-stop risk

Main value for our project:

[
oxed{	ext{Low + High + placebo + overall futility only + non-binding review}}
]

A supplementary precedent is **TAK-555-3010 / NCT04759833**, a Phase 3 Low + High + placebo trial in which both active-vs-placebo CP values had to fall below 20% for overall futility stopping.

## Main risks to quantify

- probability of overall false No-Go when at least one dose is effective;
- probability of early No-Go when both doses are inactive;
- sample-size inefficiency from retaining a clearly inactive dose through Stage 2.

---

# Comparison to be made by simulation

The two designs should be compared under the **same**:

- placebo event-rate assumptions;
- Low/High true-effect scenarios;
- final Phase II success rule;
- Stage 1 information fraction;
- CP calculation method;
- maximum sample size.

Key operating characteristics:

[
P(	ext{overall No-Go at Stage 1}midDelta_L=Delta_H=0),
]

[
P(	ext{overall false No-Go}mid	ext{at least one target-effective dose}),
]

[
P(	ext{wrongly drop an effective dose})
]

(for Design A only),

plus expected sample size and later operational overrun.

The current CRC working assumptions from previous sample-size work are:

[
p_P=45%,qquad delta_{target}=15%	ext{ or }20%.
]

Medical input currently suggests that an observed ARR of only approximately 0-5% would likely have limited development value, but this should be treated as a weak-effect region rather than a mandatory stopping threshold.

---

# Current development task

Build and calibrate **both** designs before selecting one:

1. **Design A:** CP + individual dose dropping + overall No-Go.
2. **Design B:** CP + overall No-Go only; no Stage 1 dose dropping.

Do not yet add the earlier-endpoint concept to the simulation. That question remains with the medical team.
