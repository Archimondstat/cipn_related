# Conditional-Power Two-Stage Phase II Framework

Date: 2026-09-21  
Status: working framework for internal departmental review

## Current strategic position

Two design conclusions are now close to fixed:

1. A Bayesian adaptive design is not preferred because it introduces additional implementation and operating complexity that is not necessary for the current development question.
2. A concurrent placebo arm is required because historical CIPN incidence is considered insufficiently stable for the Stage 1 decision to rely on a historical control alone.

The current preferred frequentist candidate is therefore a **randomized two-stage conditional-power futility design with concurrent placebo**.

The trial has three randomized arms:

- Placebo
- Low-dose C
- High-dose C

The primary endpoint for design is binary:

**CTCAE grade >=2 CIPN**

The exact endpoint horizon/estimand remains to be finalized.

## Stage 1 objective

Stage 1 is used for both:

- **dose-level futility assessment**, and
- **overall program Go/No-Go**.

For each active dose (j), calculate conditional power:

[
CP_j=P(	ext{dose }j	ext{ achieves the final Phase II success criterion}mid D_1,	ext{future-data assumption}).
]

The Stage 1 action matrix is:

| Low dose | High dose | Stage 1 action |
|---|---|---|
| non-futile | non-futile | continue Low + High + placebo |
| futile | non-futile | consider/drop Low; continue High + placebo |
| non-futile | futile | consider/drop High; continue Low + placebo |
| futile | futile | overall No-Go review |

A dose enters the statistical futility region when:

[
CP_j<c_F,
]

where (c_F) is a prespecified futility threshold calibrated by simulation.

## Flexibility / non-binding futility

The medical team has indicated that an observed absolute reduction in CTCAE grade >=2 CIPN of only approximately **0-5 percentage points** would likely have limited development value, but does **not** want an overly rigid stopping threshold.

Therefore, the 0-5% range should **not** be converted directly into a mandatory Stage 1 ARR stopping rule.

Instead:

- 0-5% ARR is treated as a clinically weak-effect reference region;
- the Stage 1 quantitative decision is based on conditional power;
- the CP boundary is calibrated to control false futility;
- efficacy futility can be non-binding, with a prespecified review process for borderline/gray-zone situations.

Any flexibility must be prospective rather than ad hoc. The protocol should specify which supportive information may be considered after a futility signal, for example:

- magnitude and uncertainty of the primary endpoint effect;
- safety;
- PK/PD;
- supportive CIPN efficacy measures;
- chemotherapy completion, dose reduction or delay.

Safety stopping remains separate and may override an efficacy-based continuation recommendation.

## Stage 1 timing

Because the primary endpoint is expected to require approximately 4-6 months to mature, Stage 1 should be triggered by a **prespecified mature primary-endpoint cohort**, rather than simply by the number randomized.

Notation:

[
n_{1P},quad n_{1L},quad n_{1H}.
]

Once the Stage 1 enrollment target is reached, an immediate site-wide recruitment stop may be operationally difficult. The working approach is therefore:

1. reach the prespecified Stage 1 accrual target;
2. slow recruitment while waiting for Stage 1 outcomes to mature;
3. classify additional randomized subjects as overrun/pipeline subjects;
4. exclude those overrun subjects from the prespecified Stage 1 efficacy calculation;
5. retain their mature efficacy and safety data for the full Phase II evidence package and subsequent Phase III development decision.

If a dose is dropped at Stage 1, no new subjects are randomized to that dose after the decision.

## Medical effect assumptions currently available

Previous sample-size work used the following scenarios:

### CRC

- placebo/control event rate: (p_P=45%)
- target treatment event rate: 30% or 25%
- target ARR: 15% or 20%

### BC

- placebo/control event rate: (p_P=30%)
- target treatment event rate: 20% or 15%
- target ARR: 10% or 15%

Medical input on the lower end of development value:

- an ARR of only approximately 0-5% is considered likely to have limited development value;
- this is a **range**, not a fixed mandatory stopping threshold.

## Conditional-power inputs that remain TBD

The CP framework requires the following to be specified prospectively:

1. **Final Phase II success criterion**  
   What event defines "success" when calculating CP.

2. **Future-data assumption**  
   Candidate approaches include:
   - original/design alternative;
   - current-trend assumption;
   - conservative/shrunken assumption.

3. **Stage 1 information/sample size** (n_1)

4. **Futility threshold** (c_F)

The pair ((n_1,c_F)) should be calibrated jointly by simulation.

## Key operating characteristics

The simulation should prioritize decision errors rather than conventional confirmatory power alone.

At minimum evaluate:

[
P(	ext{drop dose }jmid Delta_j=delta_{	ext{target}})
]

[
P(	ext{overall Stage 1 No-Go}mid 	ext{at least one dose is truly effective})
]

[
P(	ext{overall Stage 1 No-Go}mid 	ext{both doses are ineffective})
]

and also:

- probability of dropping exactly one dose;
- probability both doses continue;
- expected Stage 2 sample size;
- sensitivity to the true placebo event rate;
- sensitivity to weak effects (0-5% ARR);
- later, accrual delay and overrun/pipeline burden.

## Relevant design precedents

### PTG-100-02 / NCT02895100

Adaptive two-stage Phase IIb with multiple doses plus placebo, conditional-power futility review, dose dropping, committee discretion, and overrun subjects accrued while Stage 1 outcomes matured. Overrun subjects were excluded from the interim decision and retained for final analysis.

Protocol/SAP:
https://cdn.clinicaltrials.gov/large-docs/00/NCT02895100/SAP_001.pdf

### TAK-555-3010 / NCT04759833

Low dose + high dose + placebo design using arm-wise conditional power. The overall study could stop when both active-vs-placebo comparisons met the futility condition.

Protocol:
https://cdn.clinicaltrials.gov/large-docs/33/NCT04759833/Prot_000.pdf

### VITALITY-HFpEF / NCT03547583

Phase IIb multi-dose placebo-controlled trial using a non-binding futility recommendation and simulation-based operating-characteristic calibration.

SAP:
https://cdn.clinicaltrials.gov/large-docs/83/NCT03547583/SAP_001.pdf

## Current conclusion

The preferred working framework is:

[
oxed{
	ext{concurrent placebo}
+	ext{two stages}
+	ext{arm-wise CP futility}
+	ext{dose dropping}
+	ext{overall No-Go when both doses are futile}
+	ext{non-binding review}
+	ext{controlled overrun}
}
]

The next step is simulation. The first simulation version should deliberately keep the final-Go definition as a sensitivity parameter rather than prematurely hard-code a single clinical cutoff.
