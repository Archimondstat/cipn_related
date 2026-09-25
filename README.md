# CIPN-related Phase II design

This repository contains statistical-design work for the AK135 CIPN program.

## Current design

The current Cohort 1 design is archived in:

- **docs/current_design_master_v2_4.md**

That document is the authoritative working design summary as of 25 September 2026.

Core features:

- randomized 1:1:1: AK135 low dose / AK135 high dose / placebo;
- colon-cancer patients receiving adjuvant mFOLFOX6 after curative surgery;
- binary primary endpoint: CTCAE grade >=2 CIPN through 3 months after the **actual last mFOLFOX6 treatment**;
- final sample size: **50 per arm / 150 total**;
- Stage 1 cohort: **first 54 randomized participants overall**;
- Stage 1 decision: **Project Go if max(CP_L, CP_H) >= 70%**, otherwise binding Project No-Go;
- both AK135 doses continue after Go; no Stage 1 dose dropping;
- CP future assumptions: placebo 45%, active treatment 30%;
- final efficacy analysis is descriptive, based on observed/evaluable cases;
- final descriptive effect-size framework: <5% No-Go leaning, 5% to <10% Consider, >=10% Go leaning.

The 45% versus 30% planning scenario implies a 15-percentage-point absolute risk difference. The 15% value is a **design alternative implied by the planning rates**, not an assumed invariant AK135 treatment effect.

## Current code

The central calculation engines are:

- simulation/cp_futility_engine.R
- simulation/cp_futility_engine.sas

A current-design regression/validation script is:

- simulation/current_design_validation_v2_0.R

The R engine implements exact individual conditional power, available-case + consumed-slot CP for permanently indeterminate Stage 1 endpoints, the project-level Stage 1 rule based on max(CP_L, CP_H), final descriptive efficacy classification, and exact operating-characteristic utilities.

## Important supporting analyses

Current-design development analyses include:

- docs/N50_stage1_full_design_oc_v1_3.md
- docs/N50_why_35_not_40_v1_4.md
- docs/N50_IA35_CP70_joint_rate_robustness_v1_6.md
- docs/active_rate_30pct_external_plausibility_v1_7.md
- docs/stage1_indeterminate_consumed_slot_v1_8.md
- docs/stage1_indeterminate_stress_v1_9.md
- docs/final_primary_missing_data_strategy_v2_0.md
- docs/stage1_nogo_operational_handling_v2_2.md
- docs/final_primary_efficacy_analysis_v2_3.md

## Historical analyses

Earlier exploratory files are retained for the design audit trail. They include work on N=44 candidate designs, alternative Stage 1 timing grids, three-region CP rules, dose-selection ideas, non-binding futility formulations, Bayesian alternatives, and fixed-risk-difference placebo robustness.

These files are historical and should not be treated as the current design when they conflict with docs/current_design_master_v2_4.md.

## Competitor evidence

The separate competitor evidence archive remains in:

- docs/competitor_landscape.md

Competitor/control literature is used to motivate plausible planning scenarios and sensitivity ranges; it is not used as a substitute for the concurrent randomized placebo arm.
