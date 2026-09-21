# Final Phase II Efficacy-Classification Operating Characteristics v1.1

Date: 2026-09-22

## Fixed framework

Treatment effect is:

[
Delta=p_P-p_T,
]

with positive values favoring treatment.

The current three-region Phase II efficacy framework is:

[
egin{cases}
Delta_{max}<5% & 	ext{No-Go leaning}\
5%le Delta_{max}<10% & 	ext{Consider}\
Delta_{max}ge10% & 	ext{Go leaning}
end{cases}
]

where:

[
Delta_{max}=max(widehatDelta_L,widehatDelta_H).
]

The three fixed development quantities are:

- target treatment effect = 15%;
- weak-effect boundary = 5%;
- promising threshold = 10%.

These are efficacy classifications, not automatic development decisions.

## Exact calculation

The result file `simulation/results/cp_final_classification_grid_v1_1.csv` contains exact binomial probabilities for:

[
N=36,40,44,48,52
]

per arm and true treatment effects:

[
0%,5%,10%,15%,20%.
]

Both active doses are assigned the same true effect in this initial grid, with (p_P=45%).

The shared placebo arm is handled explicitly.

## Important consequence of the non-binding Stage 1 framework

These **final** classification probabilities do not depend on the Stage 1 information fraction.

This is because the current Stage 1 review is non-binding and no deterministic interim stopping rule has been specified. If all randomized patients can contribute to the final analysis, the marginal final distribution depends on final (N) and the true event rates, not on whether the review occurred at 40%, 50%, or 60% information.

Stage 1 timing still affects:

- the distribution of interim observed effects;
- individual and joint CP values;
- the probability of falling into selected interim reference regions;
- operational opportunity to stop or slow enrollment.

A full design-level probability of early termination / total sample size cannot be calculated until an explicit review action rule is specified.

## Selected results

For the current (N=44) per-arm anchor:

| True treatment effect | P(No-Go leaning) | P(Consider) | P(Go leaning) |
|---:|---:|---:|---:|
| 0% | 56.23% | 17.11% | 26.66% |
| 5% | 36.07% | 18.57% | 45.36% |
| 10% | 18.94% | 15.57% | 65.49% |
| 15% | 7.79% | 9.89% | 82.32% |
| 20% | 2.38% | 4.61% | 93.01% |

The relatively high probability of a **Go-leaning efficacy classification under a true 0% effect** is a direct consequence of using the better of two active doses and a pure observed-effect threshold without a formal significance requirement.

This does not imply a 26.66% probability of an automatic development Go, because the F framework is explicitly contextual and also considers uncertainty, safety, dose pattern, and other prespecified information.

Nevertheless, this operating characteristic should be reviewed explicitly when the final development-decision charter is drafted.

## Discreteness

Because the endpoint is binary, the 5% and 10% thresholds map to different attainable event-count differences at different (N). Therefore the classification probabilities do not change monotonically with (N).

This is expected and should be considered when selecting the final sample size.
