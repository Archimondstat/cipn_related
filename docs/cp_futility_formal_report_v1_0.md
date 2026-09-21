> **Superseded on 2026-09-22.** Use `docs/cp_futility_formal_report_v1_1.md`. Version 1.1 adopts the three-region No-Go leaning / Consider / Go leaning efficacy framework and defines 10% as the Phase II promising threshold rather than a provisional computational rule.

# CIPN Randomized Phase II Study
## Conditional-Power-Based Stage 1 Futility Review Framework (CRC Scenario)

**Version:** 1.0  
**Date:** 21 September 2026  
**Status:** Working statistical design report; methodology established, final sample size / Stage 1 timing / operational decision policy not yet frozen

---

## 1. Purpose

This report documents the current statistical framework for a randomized Phase II CIPN study with two active doses and a concurrent placebo arm.

The purpose of the Stage 1 assessment is to provide an early **Go / No-Go decision-support framework** while avoiding an unnecessarily rigid efficacy stopping rule. The current proposal uses **conditional power (CP)** calculated from the actual Stage 1 data as the principal quantitative measure for futility review.

The report records:

1. the current CRC efficacy assumptions;
2. the proposed two-stage CP framework;
3. the role of Stage 1 information fraction and actual evaluable sample size;
4. the current simulation/calibration approach and representative results;
5. the planned non-binding decision process;
6. external trial precedents and methodological references;
7. remaining design questions.

This report does **not** select a final maximum sample size, a final Stage 1 timing, or an automatic CP stopping cutoff.

---

## 2. Current study framework

### 2.1 Randomized treatment structure

The working Phase II structure is:

- placebo;
- low-dose C;
- high-dose C;

with initial equal randomization.

A concurrent placebo arm is retained because the study is intended to make treatment decisions against the concurrently observed CIPN risk rather than rely on a fixed historical control rate.

### 2.2 Primary design endpoint

For the current design work, the binary endpoint is:

> **CTCAE grade >=2 CIPN**

The exact clinical assessment horizon remains to be finalized. The endpoint is expected to require approximately 4-6 months to mature.

A separate question has been left to the medical team: whether an earlier CIPN assessment can be clinically and predictively justified for Stage 1 futility review. Until that question is resolved, the statistical design assumes that Stage 1 is based on the prespecified mature endpoint cohort.

### 2.3 CRC efficacy assumptions

For the CRC scenario, the efficacy assumptions are currently frozen at:

[
p_{Placebo}=45%, qquad p_{Treatment}=30%.
]

Treatment effect is defined throughout this project as:

[
oxed{
Delta = p_{Placebo}-p_{Treatment}
}
]

so a positive value favors treatment.

The target treatment effect is therefore:

[
oxed{
Delta_{target}=15%.
}
]

Medical input to date suggests that a treatment effect of approximately 0%-5% would likely have limited development value. This is treated as a **weak-effect region**, not as a mandatory stopping boundary.

---

## 3. Statistical concept

### 3.1 Conditional power

At Stage 1, CP is calculated separately for low dose versus placebo and high dose versus placebo:

[
CP_L=P(	ext{final success for Low}mid D_1,	ext{future-data assumption}),
]

[
CP_H=P(	ext{final success for High}mid D_1,	ext{future-data assumption}).
]

Conditional power is a probability of achieving the prespecified final success criterion given the observed interim data and an assumption about the remaining data.

The primary working future-data assumption in the current simulation is the **original design alternative**:

[
p^{future}_{Placebo}=45%, qquad
p^{future}_{Treatment}=30%.
]

This choice is consistent with the general recommendation that design-alternative CP is more stable for futility monitoring than extrapolation of an unstable early observed trend [4].

### 3.2 Current final-success working rule

For the purpose of CP calculation only, the current simulation uses the provisional final event:

[
widehat{Delta}_{final}ge10%.
]

This value is a **computational working rule**, not a finalized clinical Go criterion and not the CRC treatment-effect assumption.

The final Phase II success definition may later be replaced without changing the general CP framework.

---

## 4. Stage 1 timing and sample-size framework

### 4.1 Maximum sample size is not fixed at 44 per arm

The earlier (N=44) per arm value originated from an estimation-precision calculation and remains a useful anchor. It is no longer treated as a fixed answer for the two-stage design.

The current sample-size calibration grid is:

[
N=36, 40, 44, 48, 52 quad 	ext{per arm}.
]

Final sample-size selection should consider the entire Phase II evidence requirement, including:

- final estimation precision;
- Stage 1 operating characteristics;
- maximum and expected sample size;
- development feasibility;
- operational overrun caused by endpoint delay.

### 4.2 Stage 1 information fraction

The nominal Stage 1 timing grid is:

[
f_1=40%, 50%, 60%.
]

For example, if (N=44) per arm, the nominal mature sample sizes are approximately:

| Stage 1 information | Nominal mature n/arm |
|---:|---:|
| 40% | 18 |
| 50% | 22 |
| 60% | 26 |

These numbers are **design-calibration targets**, not rigid operational requirements.

### 4.3 Actual interim analysis

At the actual Stage 1 review, CP should use the observed mature sample size and event count in each arm:

[
(n_P,x_P),quad(n_L,x_L),quad(n_H,x_H).
]

The operational R/SAS programs therefore need to support:

[
n_P
eq n_L
eq n_H.
]

The interim analysis should be initiated within a prospectively specified information window around the nominal target rather than wait for exactly equal mature sample sizes in all arms.

The time of review should not be changed in response to unblinded efficacy results.

---

## 5. Decision framework: CP as decision support, not an automatic stopping rule

The current proposal is a **non-binding CP-based futility review**.

At Stage 1:

1. calculate (CP_L) and (CP_H) from the actual unblinded mature data;
2. summarize the observed treatment effect for each dose;
3. place the observed result in the prespecified calibration / operating-characteristic context;
4. review prespecified safety and supportive efficacy information;
5. the designated independent review body makes a Go / No-Go recommendation.

A single numerical CP cutoff is therefore **not intended to function as an automatic efficacy stop** in the current framework.

The protocol/SAP should nevertheless predefine:

- timing / information window;
- CP formula and future-data assumption;
- final success event used in the CP calculation;
- information that may be considered in the review;
- responsibility for unblinded analysis and recommendation;
- possible actions following the review.

Safety stopping remains a separate layer and can override the efficacy decision.

### 5.1 Dose dropping remains an implementation option

Two operational policies have been explored:

**Policy A - dose-level futility / dose dropping**

- if only one active dose is judged futile, further randomization to that dose may stop;
- if both doses are judged futile, an overall No-Go review occurs.

**Policy B - project-level futility only**

- no individual active arm is dropped at Stage 1;
- overall No-Go is considered only when both doses are sufficiently unpromising.

The statistical CP framework is compatible with either policy. The final choice is an operational/development decision.

---

## 6. Calibration approach

### 6.1 Why reference treatment-effect values are displayed

For design discussion, the calibration tables do not treat a displayed treatment-effect value as an automatic stopping boundary.

Instead, a row such as:

[
widehat{Delta}_{1}=0%
]

answers questions such as:

- what CP would correspond to an interim result showing no numerical benefit?
- how often would an interim result this unfavorable occur if the true treatment effect were 0%, 5%, or 15%?
- how likely would meaningful final evidence still be under the working future-data assumption?

This follows the same decision-support logic used in the VITALITY-HFpEF SAP, which displayed operating characteristics for a range of candidate futility boundaries before selecting a non-binding DSMC guideline [7].

### 6.2 Equal-n event-count interpretation in design tables

When the design-calibration table assumes equal nominal sample size (n_1) per arm:

[
widehat{Delta}_{1}
=
rac{x_{P1}-x_{T1}}{n_1}.
]

Thus, at (n_1=22):

| Observed Stage 1 treatment effect | Event-count difference (x_P-x_T) |
|---:|---:|
| -4.55% | -1 |
| 0% | 0 |
| 4.55% | +1 |
| 9.09% | +2 |

This translation is included for interpretation only. The actual operational CP calculation will use the observed denominators in each arm.

---

## 7. Representative current results: N=44 per arm anchor

### 7.1 Focused VITALITY-style calibration table

The following table focuses on the clinically relevant region around no benefit, weak benefit, and moderate benefit.

**Design assumptions:** (p_P=45%), (p_T=30%), target treatment effect = 15%.

| Stage 1 | Nominal n/arm | Reference observed treatment effect | Event-count difference | Individual CP | Joint CP | P(both doses meet reference futility region), true effect 0% | true effect 5% | true effect 15% |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 40% | 18 | -5.56% | -1 | 32.32% | 46.26% | 27.00% | 17.12% | 4.94% |
| 40% | 18 | 0.00% | 0 | 43.34% | 58.85% | 40.34% | 28.23% | 10.36% |
| 40% | 18 | 5.56% | +1 | 54.86% | 70.60% | 54.85% | 41.89% | 19.07% |
| 40% | 18 | 11.11% | +2 | 65.95% | 80.53% | 68.68% | 56.56% | 31.16% |
| 50% | 22 | -4.55% | -1 | 24.52% | 36.49% | 27.57% | 16.67% | 4.09% |
| 50% | 22 | 0.00% | 0 | 35.49% | 49.99% | 39.65% | 26.46% | 8.24% |
| 50% | 22 | 4.55% | +1 | 47.76% | 63.51% | 52.76% | 38.47% | 14.93% |
| 50% | 22 | 9.09% | +2 | 60.19% | 75.54% | 65.53% | 51.66% | 24.46% |
| 60% | 26 | -3.85% | -1 | 16.45% | 25.59% | 28.01% | 16.21% | 3.39% |
| 60% | 26 | 0.00% | 0 | 26.68% | 39.22% | 39.13% | 24.98% | 6.65% |
| 60% | 26 | 3.85% | +1 | 39.30% | 54.33% | 51.16% | 35.73% | 11.88% |
| 60% | 26 | 11.54% | +3 | 66.43% | 80.93% | 73.77% | 59.86% | 29.40% |

**Interpretation:** these probabilities describe how frequently the displayed reference region would be reached under different assumed true effects. They do not define an automatic stopping rule.

### 7.2 Timing trade-off around an observed treatment effect of 0%

For the (N=44) anchor:

| Stage 1 timing | Nominal n/arm | P(reference region reached if true effect = 0%) | P(reference region reached if true effect = 15%) |
|---:|---:|---:|---:|
| 40% | 18 | 40.34% | 10.36% |
| 50% | 22 | 39.65% | 8.24% |
| 60% | 26 | 39.13% | 6.65% |

For the same reference observed treatment effect (0%), the probability of identifying a truly null program is similar across the three timings, while later assessment reduces the probability of seeing such an unfavorable result under the target effect.

The practical trade-off is therefore between:

- **earlier review**, leaving more opportunity to save enrollment/time; and
- **later review**, providing more mature information and lower false-futility risk.

No timing has been selected at this stage.

---

## 8. Delayed endpoint, pipeline subjects, and overrun

The expected 4-6 month endpoint maturation creates an operational gap between:

- the number randomized;
- the number with mature Stage 1 efficacy data;
- the number already enrolled but still in follow-up.

These groups should be distinguished prospectively.

The working operational concept is:

- define the Stage 1 analysis cohort prospectively;
- calculate Stage 1 CP only from that cohort;
- allow controlled continuation / slowdown of accrual while outcomes mature;
- patients enrolled during the analysis/maturation period remain in follow-up and contribute to the final Phase II evidence;
- do not retrospectively add pipeline subjects to the Stage 1 CP calculation.

PTG-100-02 provides a particularly relevant precedent: while approximately 60-80 Stage 1 subjects accumulated 12-week data, approximately 60 additional subjects were expected to be randomized; these “overrun” subjects were excluded from the interim analysis but included in final analyses [6].

The exact slowdown / overrun policy for the CIPN study remains to be modeled after the core statistical design is narrowed.

---

## 9. External trial precedents

### 9.1 PTG-100-02 / NCT02895100

PTG-100-02 was a **Phase 2b randomized, double-blind, placebo-controlled, parallel adaptive two-stage study** with three PTG-100 dose groups and placebo [6].

Relevant features:

- Stage 1 included three active doses plus placebo.
- Interim analysis was planned after approximately 60-80 subjects completed 12 weeks.
- Conditional power was calculated at the interim.
- A CP below 10% could support an ADRC recommendation to stop for futility after review of safety, efficacy, and exploratory information.
- One or two dose arms could be dropped.
- Approximately 60 overrun subjects were expected while Stage 1 data matured.
- Overrun subjects were excluded from the interim analysis but included in final analyses.
- Dose selection also considered safety and clinical judgment; the SAP states that no fully prespecified dose-selection algorithm would be used.

This trial supports the feasibility of:

[
oxed{
	ext{CP + adaptive dose review + overrun handling + clinical review}
}
]

in a Phase 2b setting.

### 9.2 VITALITY-HFpEF / NCT03547583

VITALITY-HFpEF was a randomized Phase 2b study of vericiguat 10 mg, 15 mg, and placebo. The final primary evaluation was at Week 24, while futility was assessed using Week 12 KCCQ information because prior data suggested Week 12 was sufficiently predictive of Week 24 and waiting for mature Week 24 data would make the interim analysis operationally late [7,8].

Its SAP presented a table of operating characteristics for candidate futility boundaries. A 0.6-point observed Week 12 treatment-effect boundary was selected, corresponding to approximately 14% individual CP and 23% joint CP under the assumed 5-point true effect. If both dose comparisons were below the boundary, the DSMC could consider a **non-binding** recommendation for early termination. If only one dose was futile, that dose was not dropped [7].

This trial is the closest precedent for the presentation and decision philosophy currently proposed for the CIPN study:

[
oxed{
	ext{calibrated reference boundaries + joint CP + non-binding overall futility review}
}
]

rather than a purely mechanical automatic stop.

### 9.3 TAK-555-3010 / NCT04759833

TAK-555-3010 is a **Phase 3** pediatric functional constipation study with low-dose prucalopride, high-dose prucalopride, and placebo [9].

Relevant features:

- 80 subjects per treatment arm were planned for Part A.
- The first interim analysis was conducted when 50% of the target population (120 subjects) had completed or withdrawn from Part A.
- CP was calculated separately for low dose versus placebo and high dose versus placebo.
- The prespecified stopping threshold was 20% for each dose comparison.
- The study stopped for futility only if **both** active-dose comparisons had CP <20%; otherwise all three arms continued.

The trial therefore provides a direct structural precedent for:

[
oxed{
	ext{Low + High + Placebo + 50% interim + two CPs + project-level futility}
}
]

although its Phase 3 confirmatory context and fixed 20% rule should not be copied directly into this exploratory Phase II study.

---

## 10. Methodological basis

The proposed approach sits within established two-stage and futility-monitoring methodology.

Simon (1989) established the classic two-stage Phase II framework, focusing on early termination of insufficiently active regimens while controlling design error probabilities [1].

Jung (2008) extended the two-stage concept to randomized Phase II trials with a prospective concurrent control and noted that the approach extends to multiple experimental arms sharing one control [3]. This is relevant to the need for concurrent placebo in the present study.

Lan and Wittes (1988) described use of the B-value and conditional power for interim monitoring under different assumptions about future data [2].

A recent tutorial on futility monitoring emphasizes that CP is the probability of reaching final success conditional on current data and an explicit future-data assumption; it also emphasizes that the future-effect assumption must be prespecified and that design-alternative CP is generally more stable for futility monitoring than current-trend CP [4].

These references support the use of CP as a formal decision-support metric, while the exact decision policy remains trial-specific.

---

## 11. Current conclusions

At the current stage, the following elements are sufficiently established to move forward:

1. **Concurrent randomized placebo control** is retained.
2. The CRC design assumption remains:
   [
   45%	ext{ placebo vs }30%	ext{ treatment},
   quad Delta_{target}=15%.
   ]
3. The study will use a **two-stage, CP-based futility review**.
4. CP will be calculated separately for low and high dose versus the shared placebo arm.
5. The primary CP calculation currently uses the **design-alternative future effect**.
6. Stage 1 timing will be calibrated around **40%, 50%, and 60% mature information** rather than a rigid fixed number of subjects.
7. The operational analysis will use **actual mature sample sizes and event counts**.
8. CP and observed treatment effect will be used as **non-binding decision support**, not as an automatic efficacy stopping rule.
9. Safety review remains separate and can override efficacy continuation.
10. Calibration tables will focus on interpretable observed treatment effects around **0%, approximately 5%, and approximately 10%**, with only limited display of strongly negative effects.
11. Pipeline / overrun subjects will be handled separately from the prespecified Stage 1 analysis cohort.
12. R code has been retained for exact calibration; final R and SAS implementation will support unequal actual Stage 1 sample sizes by arm.

---

## 12. Outstanding items

The following items remain open:

- final maximum efficacy-evaluable sample size (N);
- preferred nominal Stage 1 information region (40%, 50%, or 60%, or a narrower window);
- final Phase II success definition used in the CP calculation;
- whether single-dose dropping is permitted or Stage 1 is project-level Go/No-Go only;
- exact independent review structure and information firewall;
- operational enrollment slowdown / overrun policy;
- missing-data / non-evaluable-subject handling at Stage 1;
- whether an earlier CIPN measure can validly inform the interim review (medical question);
- final SAS implementation and independent QC against R.

---

## 13. Reproducible project code

Current relevant files in the project repository include:

- `simulation/cp_stage1_simulation.R`
- `simulation/cp_design_comparison.R`
- `simulation/cp_boundary_calibration_exact.R`
- `simulation/cp_sample_size_calibration_crc.R`
- `simulation/cp_crc_stage1_timing_boundary_screen.R`
- `simulation/cp_crc_vitality_style_analysis.R`
- `simulation/cp_crc_vitality_style_focused.R`

The current focused presentation is documented in:

- `docs/cp_crc_vitality_style_focused_v1_3.md`

---

## References

1. Simon R. Optimal two-stage designs for phase II clinical trials. *Controlled Clinical Trials*. 1989;10(1):1-10. doi:10.1016/0197-2456(89)90015-9. PMID: 2702835.
2. Lan KKG, Wittes J. The B-value: a tool for monitoring data. *Biometrics*. 1988;44(2):579-585. PMID: 3390511.
3. Jung SH. Randomized phase II trials with a prospective control. *Statistics in Medicine*. 2008;27(4):568-583. doi:10.1002/sim.2961. PMID: 17573688.
4. Ortega-Villa AM, et al. Futility Monitoring in Clinical Trials. *Statistics in Medicine*. 2025. doi:10.1002/sim.70157. PMID: 40497544.
5. Armstrong PW, Lam CSP, Anstrom KJ, et al. Effect of Vericiguat vs Placebo on Quality of Life in Patients With Heart Failure and Preserved Ejection Fraction: The VITALITY-HFpEF Randomized Clinical Trial. *JAMA*. 2020;324(15):1512-1521. doi:10.1001/jama.2020.15922.
6. Protagonist Therapeutics. PTG-100-02 (NCT02895100), Phase 2b randomized, double-blind, placebo-controlled, parallel adaptive 2-stage study. Protocol and Statistical Analysis Plan. ClinicalTrials.gov documents:
   - Protocol: https://cdn.clinicaltrials.gov/large-docs/00/NCT02895100/Prot_000.pdf
   - SAP: https://cdn.clinicaltrials.gov/large-docs/00/NCT02895100/SAP_001.pdf
7. Bayer. VITALITY-HFpEF (NCT03547583), Statistical Analysis Plan, Protocol BAY 1021189 / 19334. ClinicalTrials.gov:
   - SAP: https://cdn.clinicaltrials.gov/large-docs/83/NCT03547583/SAP_001.pdf
8. VITALITY-HFpEF (NCT03547583), Clinical Protocol. ClinicalTrials.gov:
   - Protocol: https://cdn.clinicaltrials.gov/large-docs/83/NCT03547583/Prot_000.pdf
9. Takeda Development Center Americas. TAK-555-3010 (NCT04759833), Phase 3 randomized study of two prucalopride doses versus placebo. ClinicalTrials.gov:
   - Protocol: https://cdn.clinicaltrials.gov/large-docs/33/NCT04759833/Prot_000.pdf
   - SAP: https://cdn.clinicaltrials.gov/large-docs/33/NCT04759833/SAP_001.pdf
