# Stage 1 three-region CP operating characteristics

**Version:** 0.6  
**Date:** 25 September 2026  
**Status:** Working calibration; non-binding decision-support framework.

## 1. Design question

The Stage 1 framework is expanded from a single futility cutoff to three CP regions.

For the two active doses define:

[
M=max(CP_L,CP_H).
]

Candidate lower boundaries are:

[
c_L=25%,30%,35%.
]

The upper favorable boundary is provisionally:

[
50%.
]

The three regions are:

[
oxed{
egin{cases}
M<c_L & 	ext{Low / futility region}\
c_Lle Mle50% & 	ext{Intermediate / gray region}\
M>50% & 	ext{Favorable region}
end{cases}
}
]

These are **non-binding decision-support regions**. In particular, (M>50%) is not an automatic Go rule.

The current surviving Stage 1 timing candidates are 35% and 40% information, evaluated for (N=44,48,52) per arm.

The CP definition remains:

[
CP_j=P(widehatDelta_{j,F}ge10%mid D_1,	heta_{future}),
]

with design-alternative future assumptions:

[
p_P^{future}=0.45,qquad p_T^{future}=0.30.
]

## 2. Exact three-region OC: N=44 per arm

### 35% Stage 1 (n=15/arm)

| True effect | Lower CP | Low | Intermediate | Favorable (>50%) |
|---:|---:|---:|---:|---:|
|0%|25%|7.37%|33.67%|58.96%|
|0%|30%|14.99%|26.05%|58.96%|
|0%|35%|14.99%|26.05%|58.96%|
|15%|25%|0.72%|11.73%|87.55%|
|15%|30%|2.22%|10.23%|87.55%|
|15%|35%|2.22%|10.23%|87.55%|

### 40% Stage 1 (n=18/arm)

| True effect | Lower CP | Low | Intermediate | Favorable (>50%) |
|---:|---:|---:|---:|---:|
|0%|25%|16.26%|24.08%|59.66%|
|0%|30%|16.26%|24.08%|59.66%|
|0%|35%|27.00%|13.34%|59.66%|
|15%|25%|2.05%|8.31%|89.64%|
|15%|30%|2.05%|8.31%|89.64%|
|15%|35%|4.94%|5.42%|89.64%|

## 3. Exact three-region OC: N=48 per arm

### 35% Stage 1 (n=17/arm)

| True effect | Lower CP | Low | Intermediate | Favorable (>50%) |
|---:|---:|---:|---:|---:|
|0%|25%|8.29%|18.53%|73.17%|
|0%|30%|8.29%|18.53%|73.17%|
|0%|35%|15.87%|10.96%|73.17%|
|15%|25%|0.73%|4.45%|94.81%|
|15%|30%|0.73%|4.45%|94.81%|
|15%|35%|2.11%|3.08%|94.81%|

### 40% Stage 1 (n=19/arm)

| True effect | Lower CP | Low | Intermediate | Favorable (>50%) |
|---:|---:|---:|---:|---:|
|0%|25%|9.12%|31.02%|59.85%|
|0%|30%|16.63%|23.52%|59.85%|
|0%|35%|16.63%|23.52%|59.85%|
|15%|25%|0.73%|9.04%|90.23%|
|15%|30%|1.99%|7.78%|90.23%|
|15%|35%|1.99%|7.78%|90.23%|

## 4. Exact three-region OC: N=52 per arm

### 35% Stage 1 (n=18/arm)

| True effect | Lower CP | Low | Intermediate | Favorable (>50%) |
|---:|---:|---:|---:|---:|
|0%|25%|8.72%|31.62%|59.66%|
|0%|30%|16.26%|24.08%|59.66%|
|0%|35%|16.26%|24.08%|59.66%|
|15%|25%|0.73%|9.62%|89.64%|
|15%|30%|2.05%|8.31%|89.64%|
|15%|35%|2.05%|8.31%|89.64%|

### 40% Stage 1 (n=21/arm)

| True effect | Lower CP | Low | Intermediate | Favorable (>50%) |
|---:|---:|---:|---:|---:|
|0%|25%|17.29%|22.51%|60.20%|
|0%|30%|17.29%|22.51%|60.20%|
|0%|35%|27.44%|12.36%|60.20%|
|15%|25%|1.87%|6.85%|91.29%|
|15%|30%|1.87%|6.85%|91.29%|
|15%|35%|4.28%|4.43%|91.29%|

The full reproducible grid also includes true effects 5%, 10%, and 20%.

## 5. Important finding: the 50% upper boundary is highly discrete

The favorable-region probability does not depend on the selected lower CP boundary, but it depends strongly on the attainable CP values at a given (N) and interim (n).

For an individual dose let:

[
D=x_P-x_T.
]

Positive (D) favors AK135.

The individual CP values around (D=0) are:

| N/arm | IA | n/arm | CP at D=-1 | CP at D=0 | CP at D=+1 | CP>50% equivalent |
|---:|---:|---:|---:|---:|---:|---|
|44|35%|15|37.82%|48.60%|59.44%|(Dge1)|
|44|40%|18|32.32%|43.34%|54.86%|(Dge1)|
|48|35%|17|41.29%|51.82%|62.19%|(Dge0)|
|48|40%|19|37.82%|48.60%|59.44%|(Dge1)|
|52|35%|18|36.32%|46.18%|56.25%|(Dge1)|
|52|40%|21|31.32%|41.29%|51.82%|(Dge1)|

Thus, for most designs:

[
CP>50%iff x_Tle x_P-1,
]

i.e. the active arm has at least one fewer CIPN event than placebo.

However, for (N=48), 35% IA:

[
CP>50%iff x_Tle x_P.
]

Therefore merely tying placebo is already classified as favorable for an individual dose in that design.

This explains the unusually high null favorable-region probability:

[
P(M>50%midDelta=0)=73.17%
]

for (N=48), 35% IA, compared with approximately 59-60% in the other designs.

## 6. Interpretation

The lower boundary and upper boundary play different roles.

The lower boundary controls how difficult it is to enter the futility region. Because of discreteness, nominal 25%, 30%, and 35% boundaries often collapse to the same attainable stopping region.

The upper 50% boundary is **not** a strong efficacy threshold under the current design-alternative CP definition. Even under true effect 0%, approximately 59-60% of trials fall into (M>50%) in most designs, and 73% do so for (N=48), 35% IA.

This occurs because future observations inside CP are assumed to follow the target design alternative (45%) vs (30%). Consequently:

[
M>50%
]

should be interpreted only as an **encouraging/favorable continuation region**, not as evidence sufficient for Go.

## 7. Current design implication

A useful Stage 1 presentation is therefore:

- **Low region:** both doses have sufficiently low individual CP to raise futility concern;
- **Intermediate region:** neither the futility condition nor the favorable condition is met;
- **Favorable region:** at least one dose has (CP>50%), supporting continuation but not constituting an automatic Go.

The (N=48), 35% design deserves special attention because the nominal 50% upper CP boundary corresponds to a different event-count rule from the other candidate designs.

Before fixing an upper boundary, the project should decide whether it wants:

1. a common numerical CP threshold across designs; or
2. a common clinical/event-count interpretation across designs.

The two are not equivalent for this binary endpoint.
