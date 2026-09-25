# Observed interim treatment effect and conditional power

**Version:** 0.7  
**Date:** 25 September 2026  
**Status:** Working calibration for Stage 1 interpretation.

## 1. Purpose

The candidate Stage 1 information range is now restricted to:

- 35%;
- 40%;
- 45%.

The purpose of this calibration is to interpret CP in terms of the **observed Stage 1 treatment effect**, rather than selecting CP cutoffs without reference to what the interim data actually look like.

For equal nominal interim sample size per arm:

[
D=x_P-x_T,
qquad
widehat\Delta_1=D/n_1.
]

Positive values favor AK135.

The CP definition remains based on the design-alternative future-data assumption:

[
p_P^{future}=0.45,qquad
p_T^{future}=0.30,
]

and the final promising event:

[
widehat\Delta_F\ge10\%.
]

## 2. Key mapping

The table below shows individual CP for event-count differences close to observed effects of 0%, 5%, 10%, and 15%. Values in parentheses are the **attainable observed effect** after rounding to an integer event-count difference.

| N/arm | IA | n/arm | Around 0% | Around 5% | Around 10% | Around 15% |
|---:|---:|---:|---:|---:|---:|---:|
|44|35%|15|48.6% (0.0%)|59.4% (6.7%)|69.6% (13.3%)|69.6% (13.3%)|
|44|40%|18|43.3% (0.0%)|54.9% (5.6%)|65.9% (11.1%)|75.8% (16.7%)|
|44|45%|20|39.5% (0.0%)|51.5% (5.0%)|63.2% (10.0%)|73.8% (15.0%)|
|48|35%|17|51.8% (0.0%)|62.2% (5.9%)|71.7% (11.8%)|79.9% (17.6%)|
|48|40%|19|48.6% (0.0%)|59.4% (5.3%)|69.6% (10.5%)|78.4% (15.8%)|
|48|45%|22|43.3% (0.0%)|54.9% (4.5%)|65.9% (9.1%)|75.8% (13.6%)|
|52|35%|18|46.2% (0.0%)|56.3% (5.6%)|65.9% (11.1%)|74.6% (16.7%)|
|52|40%|21|41.3% (0.0%)|51.8% (4.8%)|62.2% (9.5%)|71.7% (14.3%)|
|52|45%|23|37.8% (0.0%)|48.6% (4.3%)|59.4% (8.7%)|69.6% (13.0%)|

## 3. Interpretation

A Stage 1 result showing no observed treatment effect, (D=0), gives an individual CP between approximately 38% and 52% across the current candidate designs.

Therefore a CP around 50% does **not** represent a strong positive efficacy signal in this framework. In some designs it corresponds almost exactly to no observed difference between AK135 and placebo.

The reason is structural: the future portion of the CP calculation continues to assume the target design alternative of 45% versus 30%.

Consequently:

- CP below roughly 40-50% generally requires the observed Stage 1 result to be unfavorable to AK135;
- CP around 50-60% often corresponds to only a small favorable event-count difference;
- CP around 65-75% more often corresponds to an observed effect near the 10-15% range.

## 4. Event-count interpretation

A direct event-count view is more stable than nominal effect labels.

For example:

| N/arm | IA | n/arm | D=0 CP | D=+1 CP | D=+2 CP | D=+3 CP |
|---:|---:|---:|---:|---:|---:|---:|
|44|35%|15|48.6%|59.4%|69.6%|78.4%|
|44|40%|18|43.3%|54.9%|65.9%|75.8%|
|44|45%|20|39.5%|51.5%|63.2%|73.8%|
|48|35%|17|51.8%|62.2%|71.7%|79.9%|
|48|40%|19|48.6%|59.4%|69.6%|78.4%|
|48|45%|22|43.3%|54.9%|65.9%|75.8%|
|52|35%|18|46.2%|56.3%|65.9%|74.6%|
|52|40%|21|41.3%|51.8%|62.2%|71.7%|
|52|45%|23|37.8%|48.6%|59.4%|69.6%|

This table shows why a universal 50% upper CP threshold is difficult to interpret consistently.

## 5. Upper-boundary screen

If project-level favorable status is defined as:

[
max(CP_L,CP_H)>c_U,
]

the exact probabilities under true effects 0% and 15% are:

| N/arm | IA | Upper CP | P(favorable | Δ=0) | P(favorable | Δ=15%) |
|---:|---:|---:|---:|---:|
|44|35%|60%|43.1%|76.7%|
|44|35%|70%|28.3%|62.2%|
|44|35%|80%|16.5%|45.7%|
|44|40%|60%|45.1%|80.9%|
|44|40%|70%|31.3%|68.8%|
|44|40%|80%|19.7%|54.3%|
|44|45%|60%|46.3%|83.2%|
|44|45%|70%|33.0%|72.5%|
|44|45%|80%|21.6%|59.2%|
|48|35%|60%|59.4%|89.0%|
|48|35%|70%|44.5%|79.7%|
|48|35%|80%|18.7%|51.6%|
|48|40%|60%|45.7%|82.1%|
|48|40%|70%|32.2%|70.7%|
|48|40%|80%|20.7%|56.9%|
|48|45%|60%|47.2%|85.1%|
|48|45%|70%|34.5%|75.5%|
|48|45%|80%|23.3%|63.5%|
|52|35%|60%|45.1%|80.9%|
|52|35%|70%|31.3%|68.8%|
|52|35%|80%|19.7%|54.3%|
|52|40%|60%|46.8%|84.2%|
|52|40%|70%|33.8%|74.1%|
|52|40%|80%|13.7%|47.5%|
|52|45%|60%|35.1%|76.9%|
|52|45%|70%|24.1%|65.5%|
|52|45%|80%|15.3%|52.4%|

The 60% threshold remains fairly permissive under the null. The 80% threshold is substantially more selective but often requires observed Stage 1 effects greater than the final 10% promising threshold. A 70% threshold lies between these two behaviors and is worth retaining as a candidate for further calibration, but is not selected here.

## 6. Current implication

The current design should not interpret CP in isolation from the event-count difference that produced it.

A practical Stage 1 presentation should therefore show, for each candidate N and IA timing:

1. the observed event-count difference (D=x_P-x_T);
2. the corresponding observed risk difference;
3. the individual CP;
4. the project-level Low / Gray / Favorable region.

This is especially important because the same nominal CP threshold can correspond to different observed effects across N and IA timings.
