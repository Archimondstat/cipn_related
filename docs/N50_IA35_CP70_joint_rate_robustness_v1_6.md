# Revised placebo-incidence robustness: model treatment incidence separately

**Version:** 1.6  
**Date:** 25 September 2026  
**Status:** Replaces the v1.5 fixed-risk-difference analysis as the primary robustness interpretation.

## 1. Correction to the previous robustness framing

Version 1.5 varied the true placebo incidence while holding the true absolute risk difference fixed.

That analysis answers:

> If the drug always reduces the CTCAE grade >=2 CIPN event rate by the same absolute percentage-point amount, how sensitive are the operating characteristics to baseline risk?

This is mathematically valid, but it is not the preferred clinical interpretation.

The planning assumptions should instead be separated into:

[
p_P^{design}=45%
]

and

[
p_T^{design}=30%.
]

The corresponding:

[
45%-30%=15%
]

is a **derived absolute risk difference under the central design scenario**, rather than a drug effect assumed to remain exactly 15 percentage points when the placebo incidence changes.

Accordingly, v1.6 treats the AK135-group event rate as its own scenario parameter.

## 2. Competitor-informed placebo uncertainty

The previous competitor-analysis discussion showed substantial variability in relevant control/reference rates:

- GM1 postoperative mFOLFOX6 placebo/control: cumulative CTCAE grade >=2 neurotoxicity about 31.6%;
- POLAR-M placebo: approximately 40% for its non-identical chronic CIPN endpoint;
- IDEA 6-month FOLFOX reference: CTCAE grade >=2 neurotoxicity about 47.7% during treatment through approximately one month after treatment;
- ART-123 phase IIa placebo: cumulative CTCAE grade >=2 sensory neuropathy about 64.3% at cycle 12;
- a previously reviewed CRC/oxaliplatin systematic review reported a control median around 57.95%, with broad study-level heterogeneity.

These values are not directly exchangeable with the current primary endpoint because populations, endpoint definitions, timing, and follow-up differ.

They support treating 45% as a central planning value rather than a precisely known placebo incidence, and justify a broad sensitivity analysis.

## 3. Working design held fixed

[
N=50/	ext{arm},
qquad
n_1=18/	ext{arm};(35%	ext{ IA}),
]

[
max(CP_L,CP_H)ge70%
Rightarrow
	ext{Project Go}.
]

No dose dropping is performed after Project Go.

The final promising criterion remains:

[
max(widehatDelta_L,widehatDelta_H)ge10%.
]

Conditional power continues to use the **design future-data assumptions**:

[
q_P=45%,qquad q_T=30%.
]

## 4. Primary revised scenario

For the main robustness analysis:

- one dose is assumed inactive and tracks the true placebo incidence;
- one target-active AK135 dose is assumed to have a fixed true CTCAE >=2 CIPN incidence of 30%.

Thus:

[
p_L=p_P,
qquad
p_H=30%.
]

The true absolute effect is then implied by the actual placebo rate:

[
Delta_{true}=p_P-30%.
]

## 5. Main result

| True placebo | Target-dose true incidence | Implied true RD | P(Stage 1 Go) | P(Stage 1 Go and Final Go) | P(Final Go without IA) |
|---:|---:|---:|---:|---:|---:|
|30%|30%|0%|42.9%|18.9%|25.8%|
|35%|30%|5%|51.4%|29.6%|39.5%|
|40%|30%|10%|60.9%|44.2%|57.2%|
|45%|30%|15%|70.3%|60.0%|74.6%|
|50%|30%|20%|79.0%|73.8%|87.7%|
|55%|30%|25%|86.2%|84.2%|95.2%|
|60%|30%|30%|91.8%|91.1%|98.6%|
|65%|30%|35%|95.5%|95.4%|99.7%|

This is very different from the v1.5 fixed-risk-difference result.

If the treatment incidence remains near 30%, placebo-rate uncertainty changes the actual treatment contrast itself.

For example:

[
p_P=35%
Rightarrow
Delta=5%,
]

so the current whole-design probability of reaching final promising status is only about 30%.

At:

[
p_P=40%,
]

the implied effect is 10%, and the probability is about 44%.

At the central:

[
45%ightarrow30%
]

scenario, the previously calculated approximately 60% whole-design probability is recovered.

## 6. Two-dimensional sensitivity

The 30% treatment incidence is itself uncertain.

Therefore the more useful robustness object is a two-dimensional grid in:

[
(p_P,p_T).
]

Below is:

[
P(	ext{Stage 1 Go and Final Go})
]

for one inactive dose and one active dose.

| True placebo | Active pT=25% | Active pT=30% | Active pT=35% |
|---:|---:|---:|---:|
|35%|44.1%|29.6%|20.0%|
|40%|60.4%|44.2%|30.3%|
|45%|74.5%|60.0%|44.4%|
|50%|84.8%|73.8%|59.7%|
|55%|91.5%|84.2%|73.4%|

The design performance is therefore driven primarily by the **joint pair of event rates**, not by either placebo incidence or a fixed absolute difference alone.

## 7. Interpretation

The correct design statement is:

[
oxed{
p_P^{design}=45%,
quad
p_T^{design}=30%,
quad
Delta^{design}=15%	ext{ is implied}
}
]

rather than:

[
Delta=15%	ext{ is assumed invariant across populations.}
]

Likewise, the final 10% promising threshold remains a **decision threshold on the observed risk-difference scale**; it is conceptually different from the 15% difference implied by the central planning rates.

## 8. Design implication

The previous conclusion that "placebo incidence uncertainty is not important" should not be carried forward.

The revised conclusion is:

> Uncertainty in the placebo incidence is important because, for a given AK135-group event rate, it directly changes the treatment contrast available to the trial. The central 45% placebo assumption therefore matters scientifically, even though the CP algorithm itself remains well defined when the realized placebo rate differs.

The competitor literature supports substantial uncertainty in the placebo/control rate. Therefore the mature design should present operating characteristics over a joint range of plausible placebo and AK135 event rates rather than rely only on a single 45% versus 30% scenario.
