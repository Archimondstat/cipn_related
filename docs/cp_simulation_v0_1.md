# CP Stage 1 Simulation v0.1 — First Look

Date: 2026-09-21  
Status: exploratory calibration only

## Purpose

Start calibration of the conditional-power Stage 1 futility framework before adding accrual delay, overrun, safety, or a finalized Phase II Go rule.

This first look is deliberately provisional. It is intended to answer:

1. how aggressive/conservative a CP rule is under different assumptions about future outcomes;
2. how often a truly target-effective dose would be dropped;
3. how often an ineffective program would stop at Stage 1.

## Baseline CRC working assumptions

Based on the previous precision-based sample-size work:

- placebo event rate: (p_P=0.45);
- target active event rate: (p_T=0.30);
- target ARR: 0.15;
- final sample size: (N=44) per arm;
- first-look Stage 1 size: (n_1=22) per arm (50% of final N).

For v0.1 only, the final-Go event used inside CP is:

[
hat p_P-hat p_T ge 0.10.
]

This 10% value is **not** a frozen clinical threshold. It is only a working sensitivity value. The medical team currently views approximately 0-5% ARR as a weak-effect region and prefers a flexible development decision.

The first-look futility cutoff is:

[
c_F=0.10.
]

## Two future-data assumptions compared

### Design-alternative CP

Future placebo and active outcomes are generated under:

[
p_P^{future}=0.45,qquad p_T^{future}=0.30.
]

This asks whether the trial can still succeed if the remaining patients perform according to the original target effect.

### Current-trend CP

Future event rates are set equal to the Stage 1 observed event rates.

This is more responsive to the interim data but can be much more aggressive when Stage 1 estimates fluctuate.

## First-look operating characteristics

500,000 Monte Carlo replicates per scenario were used for the independent validation run.

| Future assumption | True scenario | Overall Stage 1 No-Go | Drop Low | Drop High | Both continue |
|---|---|---:|---:|---:|---:|
| Design alternative | Null: ARR (0%, 0%) | 10.2% | 22.4% | 22.3% | 65.4% |
| Design alternative | Weak both: ARR (5%, 5%) | 4.9% | 13.6% | 13.5% | 77.9% |
| Design alternative | Low target only: ARR (15%, 0%) | 2.2% | 3.4% | 22.3% | 76.4% |
| Design alternative | High target only: ARR (0%, 15%) | 2.2% | 22.4% | 3.4% | 76.4% |
| Design alternative | Both target: ARR (15%, 15%) | 0.7% | 3.4% | 3.4% | 93.9% |
| Current trend | Null: ARR (0%, 0%) | 39.6% | 56.0% | 56.0% | 27.7% |
| Current trend | Weak both: ARR (5%, 5%) | 26.4% | 42.6% | 42.6% | 41.2% |
| Current trend | Low target only: ARR (15%, 0%) | 15.8% | 18.8% | 56.0% | 41.0% |
| Current trend | High target only: ARR (0%, 15%) | 15.8% | 56.0% | 18.7% | 41.0% |
| Current trend | Both target: ARR (15%, 15%) | 8.2% | 18.8% | 18.7% | 70.7% |

## Immediate interpretation

The difference between the two CP assumptions is large.

- **Design-alternative CP is conservative for futility.**  
  It protects a target-effective dose well: in the one-target-dose scenario, the effective dose is dropped only about 3-4%, and overall false No-Go is about 2%.  
  However, under the global null only about 10% of studies stop at Stage 1 with this particular (n_1,c_F,delta_{Go}) combination.

- **Current-trend CP is much more aggressive.**  
  It stops about 40% of null studies, but it also drops a truly target-effective dose about 19% of the time and produces about 16% overall false No-Go when only one dose is truly target-effective.

This confirms that the future-data assumption is not a technical detail. It is a major design parameter.

## Stage 1 timing sensitivity

A first sensitivity check with design-alternative CP, provisional (delta_{Go}=10%), and (c_F=10%) showed:

| (n_1) per arm | Overall No-Go under null | Drop target-effective dose when only one dose is target-effective | Overall false No-Go when only one dose is target-effective |
|---:|---:|---:|---:|
| 18 | ~4% | ~2% | <1% |
| 22 | ~10% | ~3-4% | ~2% |
| 26 | ~19% | ~6% | ~4% |

This shows the expected trade-off: later Stage 1 timing improves futility efficiency but increases the amount of information/sample already spent before a decision.

## Current conclusion

No design parameter should be selected from v0.1.

The first simulation establishes three useful facts:

1. the CP framework is computationally straightforward for the binary endpoint;
2. **design-alternative versus current-trend CP materially changes false-futility behavior**;
3. (n_1), (c_F), and the final-Go definition must be calibrated jointly.

The next simulation step should introduce a **shrunken/intermediate future-effect assumption** between design-alternative and current-trend CP, because the first is likely too conservative for efficient futility stopping while the second appears too aggressive for protecting a truly effective dose.

After the statistical rule is narrowed, accrual delay and overrun/slowdown should be added as a separate operational module.
