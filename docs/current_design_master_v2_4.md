# AK135 CIPN Cohort 1 — Current Phase II Statistical Design

**Design archive version:** 2.4  
**Date:** 25 September 2026  
**Status:** Current working design master. This document supersedes earlier exploratory design notes where inconsistent.

## 1. Trial objective and population

Cohort 1 is an exploratory randomized Phase II study in patients with colon cancer after curative surgery who are planned to receive approximately 6 months of mFOLFOX6 adjuvant chemotherapy.

Randomization is 1:1:1 to AK135 low dose + mFOLFOX6, AK135 high dose + mFOLFOX6, or placebo + mFOLFOX6. A concurrent placebo arm is retained; historical controls are not used as a substitute for the randomized placebo group.

Randomization stratification is deferred and is not required for the current descriptive efficacy framework.

## 2. Primary endpoint and effect measure

The primary endpoint is whether CTCAE grade >=2 CIPN occurs from baseline through 3 months after the participant's **actual last mFOLFOX6 treatment**.

The treatment-effect scale is absolute risk difference:

\[
\Delta_L=p_P-p_L,
\qquad
\Delta_H=p_P-p_H,
\]

where positive values favor AK135.

## 3. Planning assumptions and descriptive efficacy thresholds

Central planning event rates are:

\[
\boxed{p_P^{design}=45\%}
\]

and:

\[
\boxed{p_T^{design}=30\%}.
\]

Thus:

\[
\boxed{\Delta^{design}=45\%-30\%=15\%}
\]

is the absolute risk difference implied by the central planning scenario. It is not an evidence-based forecast of AK135 efficacy and is not assumed to remain constant if the placebo event rate changes.

The final descriptive efficacy framework uses:

\[
\Delta_{\max}=\max(\hat\Delta_L,\hat\Delta_H).
\]

Classification:

- \(\Delta_{\max}<5\%\): No-Go leaning.
- \(5\%\le\Delta_{\max}<10\%\): Consider.
- \(\Delta_{\max}\ge10\%\): Go leaning.

The 10% value is the promising observed risk-difference threshold. The 5% value is the weak-effect boundary. These are exploratory development classifications, not confirmatory hypothesis-test boundaries.

## 4. Final sample size

\[
\boxed{N=50\text{ per arm},\qquad N_{total}=150}.
\]

The design accepts the loss in statistical recognition probability associated with this practical sample-size constraint.

## 5. Stage 1 cohort

Stage 1 uses the:

\[
\boxed{\text{first 54 randomized participants overall}}
\]

according to randomization order.

Later randomized participants must not replace an earlier Stage 1 participant merely because their endpoint matures sooner.

Under exact equal allocation, the nominal Stage 1 size is approximately 18/18/18. The actual calculation uses realized arm-specific numbers.

## 6. Stage 1 participant status

Each Stage 1 participant ultimately has one of three statuses:

\[
\boxed{Y=1,\quad Y=0,\quad Y=\text{indeterminate}}.
\]

A participant is analysis-ready once one of these states is final. Thus an indeterminate endpoint is analysis-ready even though it is not endpoint-evaluable.

## 7. Conditional power

For one AK135 dose versus placebo, conditional power is the conditional probability that the final observed risk difference reaches the 10% promising threshold.

Future-data assumptions used inside CP are fixed at:

\[
\boxed{q_P=45\%,\qquad q_T=30\%}.
\]

These are design assumptions used for projection, not updated estimates of true treatment effect.

## 8. Indeterminate endpoints: available-case + consumed-slot CP

For arm \(j\), define:

\[
R_j=\text{number randomized / final-N slots consumed},
\]

\[
E_j=\text{number with a determinate binary endpoint},
\]

\[
U_j=R_j-E_j,
\qquad
F_j=N_j-R_j.
\]

An indeterminate participant does not contribute an artificial event or non-event, remains a consumed randomized slot, and is not treated as a future replaceable participant.

The current Stage 1 CP is:

\[
CP^{AC-CS}
=
P\left[
\frac{x_P+Y_P}{E_P+F_P}
-
\frac{x_T+Y_T}{E_T+F_T}
\ge0.10
\mid D_1
\right],
\]

with:

\[
Y_P\sim Bin(F_P,q_P),
\qquad
Y_T\sim Bin(F_T,q_T).
\]

## 9. Stage 1 project-level decision

For each active dose calculate \(CP_L\) and \(CP_H\), then define:

\[
\boxed{M=\max(CP_L,CP_H)}.
\]

The binding rule is:

\[
\boxed{M\ge70\%\Rightarrow Project\ Go}
\]

and:

\[
\boxed{M<70\%\Rightarrow Project\ No-Go}.
\]

If Project Go, both AK135 doses continue. There is no Stage 1 dose dropping, randomization-ratio adaptation, or sample-size re-estimation.

The equal-allocation event-count shorthand is only a calibration aid. The operational rule is the exact CP based on actual arm-specific counts and denominators.

## 10. Accrual during Stage 1 maturation

Accrual may continue at a reduced rate while Stage 1 endpoints mature. Participants randomized after the first 54 and before the Stage 1 decision are pipeline/overrun participants.

The current operational budget principle is:

\[
P\left(N_{IA}\ge\lceil0.70N_{total}\rceil\right)\le0.05.
\]

Pipeline participants do not enter Stage 1 CP and do not replace Stage 1 participants, but remain part of the randomized study population.

## 11. Project No-Go operational handling

If Stage 1 produces Project No-Go:

- stop new randomization once the decision becomes effective;
- randomized participants who have not started AK135/placebo do not initiate study treatment;
- participants already receiving AK135/placebo discontinue study treatment under the current working rule;
- mFOLFOX6 management remains a clinical decision;
- already randomized participants continue safety and CIPN follow-up whenever feasible.

Stopping AK135/placebo because of Project No-Go is not itself a CIPN event. Pipeline data collected after the binding No-Go may be summarized descriptively but do not retrospectively overturn the prespecified decision.

## 12. Final primary efficacy analysis

The final Phase II efficacy analysis is descriptive. No formal efficacy hypothesis testing is planned.

For each arm:

\[
\hat p_j=\frac{x_j}{E_j},
\]

where \(E_j\) is the number of randomized participants with a determinate primary endpoint.

Report randomized N, endpoint-evaluable N, indeterminate N and percentage, CTCAE grade >=2 CIPN event count and percentage, observed risk differences versus placebo, and descriptive confidence intervals if included.

No efficacy P-value, statistical-significance boundary, or confirmatory multiplicity adjustment is required.

Both dose-placebo comparisons must be shown separately. The maximum risk difference is a development-screening statistic and should not be presented as an unbiased estimate of the selected dose effect.

## 13. Final missing-data strategy

The final primary analysis uses:

\[
\boxed{\text{observed/evaluable cases}}.
\]

Indeterminate endpoints are not automatically imputed as events or non-events. Their amount and reasons are reported by treatment group.

Supporting sensitivity analyses may include all indeterminate endpoints assigned as events, differential worst-case assignment unfavorable to AK135, and tipping-point/delta-adjusted analysis if the amount of missing data makes it meaningful.

## 14. Intercurrent events

### 14.1 Early AK135/placebo discontinuation

Treatment-policy strategy. Discontinuation itself is not a CIPN event; continue primary-endpoint follow-up whenever feasible.

### 14.2 Early permanent mFOLFOX6 discontinuation

The primary observation window remains anchored to actual last mFOLFOX6 treatment + 3 months. Early chemotherapy discontinuation is not itself a CIPN event.

Actual mFOLFOX6 exposure should be described using treatment cycles, cumulative oxaliplatin dose, relative dose intensity, and early-discontinuation reasons.

A fixed planned-treatment-horizon analysis may be retained as a supplementary/exploratory analysis, not as a core primary sensitivity analysis.

### 14.3 Death

If CTCAE grade >=2 CIPN occurs before death, Y=1. If death occurs before completion of the endpoint window without a prior event and prevents endpoint determination, Y=indeterminate.

### 14.4 New anti-cancer treatment with clear CIPN risk

Only a new anti-cancer treatment with a clearly established clinically relevant risk of inducing CIPN triggers truncation of primary endpoint ascertainment.

If a qualifying neurotoxic treatment starts after a prior CTCAE grade >=2 CIPN event, Y=1. If no prior event has occurred and the primary window is incomplete, Y=indeterminate.

Other subsequent anti-cancer treatments do not automatically terminate CIPN follow-up merely because they are anti-cancer treatments. The exact qualifying drug classes are a Medical confirmation item.

## 15. Key operating-characteristic findings

At N=50 per arm and without binding interim futility, the one-effective-dose central scenario (0.45, 0.45, 0.30) has approximately 74.6% probability of meeting the final 10% project-level promising criterion.

At nominal Stage 1 18/18/18:

- one-target-dose scenario: Stage 1 Go about 70.3%;
- Stage 1 Go and Final Go about 60.0%;
- null scenario: Stage 1 Go about 45.1%;
- null Stage 1 Go and Final Go about 21.3%.

The placebo and treatment planning rates must be treated separately. Design robustness should therefore be interpreted through joint \((p_P,p_T)\) scenarios rather than a constant 15-point drug effect.

## 16. Deferred / cross-functional items

The following do not change the current statistical core:

- randomization stratification;
- Stage 1 blinding/governance structure;
- exact operational list of subsequent anti-cancer treatments with clinically relevant CIPN risk — Medical decision;
- detailed fixed-horizon supplementary-analysis timing;
- detailed tipping-point implementation;
- operational close-out details after Project No-Go.

## 17. Current implementation files

Current engines:

- simulation/cp_futility_engine.R
- simulation/cp_futility_engine.sas

Current-design validation:

- simulation/current_design_validation_v2_0.R

Important supporting analyses:

- simulation/N50_stage1_full_design_oc_v1_3.R
- simulation/N50_IA35_40_imbalance_robustness_v1_4.R
- simulation/N50_IA35_CP70_joint_rate_robustness_v1_6.R
- simulation/stage1_indeterminate_consumed_slot_v1_8.R
- simulation/stage1_indeterminate_stress_v1_9.R

Historical exploratory files remain in the repository for audit trail but do not define the current design.

## 18. Explicitly superseded concepts

The current design no longer uses N=44 as the working final sample size, 50% Stage 1 timing, non-binding CP merely as decision support, three-region interim rules, Stage 1 dose dropping, sample-size re-estimation, Bayesian interim decision rules, confirmatory efficacy hypothesis testing, multiplicity-adjusted efficacy P-values, or a fixed 15-percentage-point drug effect across all placebo rates.

Where an older file conflicts with this master document, this document defines the current working design.
