# Stage 1 indeterminate endpoints: available-case + consumed-slot CP

**Version:** 1.8  
**Date:** 25 September 2026  
**Status:** Method confirmed for Stage 1 handling of permanently indeterminate endpoints; retained as supporting derivation.

## 1. Confirmed Stage 1 structure

Current working design:

[
N=50/	ext{arm},qquad N_{total}=150.
]

Stage 1 cohort:

[
oxed{	ext{first 54 randomized participants overall}}
]

by randomization order.

Each Stage 1 participant ultimately has one of three statuses:

[
Y=1,qquad Y=0,qquad Y=	ext{indeterminate}.
]

An indeterminate participant is **analysis-ready** but is not endpoint-evaluable.

The remaining question is how such participants enter conditional power.

## 2. Why the existing CP formula is insufficient

The current CP engine uses:

[
n_j=	ext{mature/evaluable interim sample size}
]

and assumes:

[
N_j-n_j
]

future outcomes remain.

That is correct only when every randomized Stage 1 participant has an observed binary endpoint.

If one of 18 Stage 1 placebo participants is permanently indeterminate:

[
R_P=18,qquad E_P=17.
]

Only 32 additional placebo participants can still be randomized under a final cap of 50:

[
50-R_P=32,
]

not 33.

Therefore setting (n_P=17) in the existing formula would incorrectly treat the missing participant as if the randomized slot could be replaced.

## 3. Proposed bookkeeping

For arm (j), distinguish:

[
R_j=	ext{number already randomized / final-N slots consumed},
]

[
E_j=	ext{number with evaluable binary primary endpoint},
]

[
U_j=R_j-E_j=	ext{permanently indeterminate endpoints},
]

and:

[
F_j=N_j-R_j=	ext{future recruitment capacity}.
]

Thus:

[
E_j+U_j+F_j=N_j.
]

Under the candidate **available-case + consumed-slot** approach, the indeterminate (U_j) subjects:

- are not assigned an artificial event/non-event outcome;
- do not contribute to the observed endpoint numerator or denominator;
- remain consumed randomized slots;
- are not counted again as future participants.

Assuming all future recruited participants are evaluable, the final available-case denominator is:

[
E_j+F_j=N_j-U_j.
]

## 4. Candidate individual CP formula

For placebo and treatment:

[
Y_Psim Bin(F_P,q_P),
]

[
Y_Tsim Bin(F_T,q_T),
]

where the current design future-data assumptions remain:

[
q_P=45%,qquad q_T=30%.
]

The candidate CP is:

[
CP^{AC-CS}
=
Pleft[
rac{x_P+Y_P}{E_P+F_P}
-
rac{x_T+Y_T}{E_T+F_T}
ge 10%
mid D_1
ight].
]

Equivalently, conditional on a future placebo event count (Y_P=y_P):

[
Y_Tle
(E_T+F_T)
left{
rac{x_P+y_P}{E_P+F_P}
-0.10
ight}
-x_T.
]

The integer threshold is obtained by taking the floor.

When (U_P=U_T=0), this reduces exactly to the existing CP formula.

## 5. Why "consumed-slot" matters

Consider a nominal Stage 1 comparison near the current Go boundary.

With no missing endpoint:

[
x_P=8/18,qquad x_T=6/18.
]

The individual CP is:

[
72.73%.
]

Now suppose one placebo Stage 1 participant is permanently indeterminate and the observed data are:

[
x_P=7/17,qquad x_T=6/18.
]

### Correct consumed-slot calculation

[
R_P=18,quad E_P=17,quad F_P=32.
]

The final available-case placebo denominator can reach only:

[
17+32=49.
]

The resulting CP is:

[
oxed{63.48%}.
]

### Incorrect "missing becomes future" calculation

If the existing CP formula were naively called with (n_P=17), it would use:

[
50-17=33
]

future placebo observations and return:

[
67.64%.
]

Thus it would overstate CP by approximately:

[
oxed{4.2	ext{ percentage points}}.
]

The discrepancy can be even larger when the indeterminate endpoint is in the treatment arm.

## 6. Worked examples

All examples below have 18 randomized/consumed slots per arm at Stage 1 and use CP cutoff 70%.

| Observed Stage 1 data | Indeterminate | Slot-adjusted CP | Naive missing-as-future CP | Go? |
|---|---:|---:|---:|---|
| P 8/18 vs T 6/18 | 0 | 72.73% | 72.73% | Yes |
| P 7/17 vs T 6/18 | 1 P | 63.48% | 67.64% | No |
| P 8/17 vs T 6/18 | 1 P | 72.73% | 76.28% | Yes |
| P 8/18 vs T 5/17 | 1 T | 72.73% | 78.26% | Yes |
| P 8/18 vs T 6/17 | 1 T | 63.48% | 69.95% | No |
| P 7/17 vs T 5/17 | 1 each | 72.73% | 73.69% | Yes |
| P 6/16 vs T 6/18 | 2 P | 53.67% | 62.29% | No |
| P 7/16 vs T 6/18 | 2 P | 63.98% | 71.53% | No |
| P 8/16 vs T 6/18 | 2 P | 73.41% | 79.51% | Yes |
| P 8/18 vs T 4/16 | 2 T | 80.62% | 83.01% | Yes |
| P 8/18 vs T 5/16 | 2 T | 72.73% | 75.77% | Yes |
| P 8/18 vs T 6/16 | 2 T | 63.48% | 67.10% | No |

The examples show that near the 70% boundary, one or two indeterminate endpoints can matter operationally.

They also show why the protocol rule should be the exact CP calculation rather than an event-count mnemonic once denominators become unequal.

## 7. Interpretation of the confirmed Stage 1 method

The method has three attractive properties:

1. **No replacement fiction.** A permanently indeterminate participant has already consumed one of the 50 randomized slots.
2. **No forced clinical reclassification.** Death or loss to follow-up is not artificially labeled as CIPN or no CIPN.
3. **Low complexity.** The method extends the existing exact-binomial CP formula without requiring multiple imputation at the interim.

However, it has an important limitation:

> The final CP success event is defined using an available-case denominator if permanent indeterminate outcomes exist.

Therefore this method is most internally coherent if the final primary analysis also has an available-case interpretation, or if CP is explicitly described as an operational decision-support approximation rather than as the exact predictive probability under the final missing-data analysis.

The final primary missing-data strategy has not yet been fixed, so the Stage 1 method is now confirmed; the final primary analysis remains observed/evaluable cases with separate sensitivity analyses.

## 8. Sensitivity around indeterminate outcomes

A simple way to protect the Stage 1 decision from dependence on the available-case assumption is to calculate sensitivity CPs by assigning indeterminate endpoints in directions unfavorable and favorable to AK135.

For a treatment-placebo comparison:

- treatment-arm indeterminate = CIPN event and placebo-arm indeterminate = non-event is unfavorable to AK135;
- treatment-arm indeterminate = non-event and placebo-arm indeterminate = event is favorable to AK135.

These values can provide a CP interval:

[
[CP_{worst},CP_{best}].
]

A possible governance rule would be to flag cases in which the Project Go/No-Go conclusion changes across this interval, rather than automatically adding a second numerical stopping boundary.

This should be evaluated before deciding whether available-case + consumed-slot CP is sufficient as the primary Stage 1 rule.

## 9. Next question

The next analysis should quantify, under realistic missing rates such as 0%, 5%, and 10% per arm:

- how often indeterminate endpoints change the Project Go/No-Go decision;
- how often the available-case decision disagrees with worst/best-case sensitivity;
- whether the current 70% CP cutoff remains operationally stable.

This will determine whether a simple slot-adjusted available-case CP is adequate or whether a formal interim missing-data model is necessary.
