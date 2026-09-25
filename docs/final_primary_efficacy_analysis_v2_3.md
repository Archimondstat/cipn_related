# Final primary efficacy analysis framework

**Version:** 2.3  
**Date:** 25 September 2026  
**Status:** Revised to a descriptive Phase II efficacy-analysis framework; no formal hypothesis testing.

## 1. Analysis population and treatment assignment

The primary efficacy analysis should be based on all randomized participants under their randomized treatment assignment.

Because the primary missing-data approach is observed/evaluable cases, the binary primary endpoint comparison will use the subset of randomized participants whose endpoint is determinate.

Thus the analysis should distinguish:

- randomized analysis population: all randomized participants, analyzed as randomized;
- endpoint-evaluable denominator: randomized participants with (Y=0) or (Y=1).

An indeterminate endpoint does not change randomized treatment assignment and must remain visible in disposition and missing-data summaries.

## 2. Arm-specific event rates

For arm (j):

[
hat p_j=rac{x_j}{E_j},
]

where:

- (x_j) = number of participants with CTCAE grade >=2 CIPN;
- (E_j) = number of participants with a determinate primary endpoint.

Report for placebo, low-dose AK135, and high-dose AK135:

- randomized N;
- endpoint-evaluable N;
- indeterminate N and percentage;
- event count;
- event proportion;
- two-sided 95% confidence interval for the event proportion.

A binomial exact Clopper-Pearson interval is acceptable for the arm-specific event proportion.

## 3. Primary treatment effects

The treatment-effect scale remains absolute risk difference:

[
Delta_L=p_P-p_L,
qquad
Delta_H=p_P-p_H.
]

Positive values favor AK135.

Estimate:

[
hatDelta_L=hat p_P-hat p_L,
qquad
hatDelta_H=hat p_P-hat p_H.
]

For each comparison, report:

- point estimate;
- two-sided 95% confidence interval.

A score-based interval such as the Miettinen-Nurminen/Newcombe family is preferred to a simple Wald interval because of the modest sample size.

## 4. Final exploratory efficacy classification

Dose-level classification:

[
hatDelta_j<5%
Rightarrow
	ext{No-Go leaning},
]

[
5%lehatDelta_j<10%
Rightarrow
	ext{Consider},
]

[
hatDelta_jge10%
Rightarrow
	ext{Go leaning}.
]

Project-level observed effect:

[
Delta_{max}
=
max(hatDelta_L,hatDelta_H).
]

The project-level classification is based on (Delta_{max}).

This is an exploratory Phase II development classification and not a confirmatory rejection of a null hypothesis.

## 5. Confidence intervals are descriptive uncertainty measures, not a second decision gate

The current design is calibrated around the observed risk-difference threshold rather than statistical significance.

Therefore the 95% confidence interval should be used to show precision and uncertainty, but should not create an additional rule such as:

[
	ext{lower 95% CI}>0
]

or:

[
	ext{two-sided }P<0.05.
]

With approximately 50 participants per arm, even a clinically interesting observed absolute risk difference may have a confidence interval crossing zero.

For example, with approximately 23/50 placebo events and 15/50 treatment events:

[
hatDelta=16%.
]

A score-type 95% interval is still roughly from a small negative value to above 30 percentage points. Requiring conventional statistical significance would therefore convert the current exploratory Phase II design into a substantially different and much larger design.

## 6. Multiplicity

Because no formal efficacy hypothesis testing is performed, confirmatory multiplicity control is not part of this Phase II design.

Both dose-placebo comparisons will be summarized descriptively.

The project-level efficacy classification may use the better observed risk difference:

\[
\Delta_{\max}=\max(\hat\Delta_L,\hat\Delta_H).
\]

The operating-characteristic simulations already evaluate this project-level rule using both active doses and the shared placebo.

No multiplicity-adjusted P-value or family-wise type-I-error procedure is required for the descriptive efficacy framework.

## 7. Important interpretation of the maximum effect

Because:

[
Delta_{max}=max(hatDelta_L,hatDelta_H),
]

the maximum of two noisy estimates is subject to upward selection bias.

Therefore the final report should not present (Delta_{max}) alone as an unbiased estimate of the selected dose's true treatment effect.

The report should always show:

[
hatDelta_L,qquad hatDelta_H
]

separately, together with their confidence intervals and event counts.

The maximum is used as a **screening/development statistic**, not as a bias-free treatment-effect estimator.

## 8. Stratification / covariate adjustment

Randomization stratification, if used, should be justified primarily for treatment-balance and operational reasons rather than for a formal hypothesis test.

The primary efficacy summaries can remain unadjusted descriptive quantities:

\[
\hat p_P,\hat p_L,\hat p_H,
\]

and:

\[
\hat\Delta_L,\hat\Delta_H.
\]

No adjusted inferential model is required merely because a stratification factor is used in randomization.

If clinically useful, stratified or covariate-adjusted summaries may be presented as supportive/exploratory analyses, but they are not necessary for the core descriptive Phase II framework.

## 9. Missing-data sensitivity

The primary analysis uses observed/evaluable cases.

Prespecified sensitivity analyses should include the missing-data scenarios already defined separately, such as:

- all indeterminate as event;
- differential worst case unfavorable to AK135;
- tipping-point/delta-adjusted analysis if warranted.

The primary observed-case risk-difference calculation is repeated under each completed sensitivity dataset.

## 10. Early Stage 1 termination

The final 5%/10% efficacy classification is intended for the scenario in which the study passes Stage 1 and continues toward the planned (N=50) per arm.

If the trial terminates at Stage 1 for futility, all subsequently available randomized-participant data will be summarized descriptively but will not be used to retrospectively overturn the binding Stage 1 No-Go decision.

## 11. Recommended core final table

For each dose-placebo comparison, the primary efficacy table should contain at minimum:

| Quantity | Placebo | AK135 dose | Difference |
|---|---:|---:|---:|
| Randomized N | | | |
| Evaluable N | | | |
| Indeterminate N (%) | | | |
| CTCAE >=2 CIPN, n (%) | | | |
| 95% CI for event proportion | | | |
| Risk difference (p_P-p_T) | | | |
| 95% CI for risk difference | | | |
| Exploratory classification | | | |

## 12. Deferred item: randomization stratification

Randomization stratification is intentionally deferred for now.

The current efficacy framework does not depend on resolving this item because the Phase II efficacy analysis is descriptive and can remain based on unadjusted arm-specific event proportions and risk differences.

If stratification is considered later, it should be justified primarily for treatment-balance and operational reasons rather than for formal hypothesis testing.
