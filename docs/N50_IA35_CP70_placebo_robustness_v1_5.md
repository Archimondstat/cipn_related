# Robustness to the true placebo CIPN incidence

**Version:** 1.5  
**Date:** 25 September 2026  
**Status:** Working robustness analysis for the current main design.

> **SUPERSEDED INTERPRETATION:** This analysis holds the true absolute risk difference fixed while varying the placebo rate. The current design instead treats placebo and active-arm event rates as separate scenario parameters. See `docs/N50_IA35_CP70_joint_rate_robustness_v1_6.md` and `docs/current_design_master_v2_4.md`.

## 1. Current design held fixed

This analysis holds the current working design fixed:

[
N=50/	ext{arm},
qquad
n_1=18/	ext{arm};(35%	ext{ IA}),
]

with project-level Stage 1 rule:

[
max(CP_L,CP_H)ge70%Rightarrow	ext{Project Go}.
]

No dose is dropped after a Project Go.

The final efficacy-classification rule remains:

[
max(widehatDelta_L,widehatDelta_H)ge10%.
]

Conditional power is always calculated using the prespecified design future-data assumptions:

[
q_P=45%,qquad q_T=30%.
]

The question here is different: how do the operating characteristics change if the **true** placebo event rate is not 45%?

## 2. Why the placebo-rate range should not be narrow

The prior competitor-analysis discussion found substantial variation in relevant control/reference incidences.

The values carried forward from that discussion include:

- GM1 postoperative mFOLFOX6 study: control CTCAE grade >=2 cumulative incidence about 31.6%;
- POLAR-M: placebo incidence about 40%;
- IDEA 6-month FOLFOX reference: about 47.7%;
- ART-123 phase IIa placebo arm: CTCAE grade >=2 sensory neuropathy about 64.3% at cycle 12;
- a CRC/oxaliplatin systematic review discussed previously: control median about 57.95%, with a very wide study-level range.

These studies do not use an endpoint identical to the current endpoint (baseline through actual last mFOLFOX6 +3 months), so their event rates should not be pooled or treated as interchangeable estimates of the true AK135 placebo rate.

They are useful, however, for selecting a realistic robustness range.

Accordingly:

[
35%-55%
]

is treated as the primary robustness range, with:

[
30%-65%
]

used as a stress range.

The central planning value remains 45%.

## 3. Primary robustness result: one effective dose with 15% absolute effect

The key planning scenario remains:

[
(Delta_L,Delta_H)=(0,15%).
]

| True placebo incidence | True active incidence for target dose | P(Stage 1 Go) | P(Stage 1 Go and Final Go) | P(Final Go without IA) |
|---:|---:|---:|---:|---:|
|35%|20%|70.92%|61.20%|76.05%|
|40%|25%|70.55%|60.44%|75.20%|
|45%|30%|70.33%|59.96%|74.64%|
|50%|35%|70.20%|59.68%|74.31%|
|55%|40%|70.17%|59.56%|74.15%|

Across the full primary 35%-55% range:

[
P(	ext{Stage 1 Go})
]

changes by less than 1 percentage point, and:

[
P(	ext{Stage 1 Go and Final Go})
]

ranges only from approximately 59.6% to 61.2%.

Thus the current design is not materially dependent on the true placebo incidence being exactly 45%, provided the treatment effect is interpreted on the prespecified **absolute risk-difference scale**.

## 4. Stress range

For the same ((0,15%)) scenario:

| True placebo incidence | P(Stage 1 Go) | P(Stage 1 Go and Final Go) | P(Final Go without IA) |
|---:|---:|---:|---:|
|30%|71.51%|62.37%|77.33%|
|35%|70.92%|61.20%|76.05%|
|45%|70.33%|59.96%|74.64%|
|55%|70.17%|59.56%|74.15%|
|65%|70.32%|59.77%|74.33%|

Even over 30%-65%, the Stage 1 continuation probability remains about 70%-72%, and the full-design final-Go probability remains about 60%-62%.

## 5. Other true absolute effects

For the one-effective-dose configuration, the exact full-design probabilities
(P(	ext{Stage 1 Go and Final Go})) over the primary placebo range are:

| True placebo | Δ=0% | Δ=5% | Δ=10% | Δ=15% | Δ=20% |
|---:|---:|---:|---:|---:|---:|
|35%|20.03%|29.63%|44.07%|61.20%|77.20%|
|40%|20.81%|30.33%|44.23%|60.44%|75.58%|
|45%|21.29%|30.78%|44.36%|59.96%|74.49%|
|50%|21.49%|31.02%|44.45%|59.68%|73.80%|
|55%|21.42%|31.06%|44.50%|59.56%|73.42%|

The 15% target-effect scenario is particularly stable.

## 6. Why the robustness is strong

At (N=50), (n_1=18), and with the fixed CP future-data assumptions (45%ightarrow30%), the 70% CP cutoff corresponds under equal Stage 1 allocation to:

[
x_P-x_Tge2.
]

Therefore the Stage 1 rule is effectively driven by an observed **absolute event-count difference**, not by the absolute placebo rate itself.

If the true placebo incidence shifts but the true absolute treatment effect remains 15%, both true arm rates move together. The distribution of the event-count difference changes only moderately through the binomial variances.

This explains why the OC is much more stable than might be expected from the broad range of placebo/control incidences seen across the competitor literature.

## 7. Important limitation

This robustness result is conditional on defining treatment effect as an **absolute risk difference**:

[
Delta=p_P-p_T.
]

It does not imply robustness if the biological effect is better represented by a fixed relative risk or odds ratio. For example, a fixed relative reduction would correspond to different absolute effects when the placebo rate changes.

The current design assumption is explicitly the absolute-effect framework, so the analysis above is aligned with the working estimand and efficacy target.

## 8. Current conclusion

The prior competitor evidence supports treating 45% as a central reference rather than a precisely known placebo rate.

The current:

[
oxed{
N=50/	ext{arm},
quad
35%	ext{ IA},
quad
CPge70%,
quad
	ext{project-level Go/No-Go}
}
]

shows good operating-characteristic robustness to plausible variation in the true placebo incidence.

Therefore uncertainty in the placebo incidence alone does **not** currently provide a reason to change the 35% IA timing, the 70% CP cutoff, or the N=50/arm sample-size anchor.

The more consequential remaining robustness question is whether the target effect should remain modeled as a fixed 15% absolute risk reduction across the plausible placebo-rate range.
