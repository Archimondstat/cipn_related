# CIPN Phase II Conditional-Power Simulation
## Statistical Derivation and R/SAS Implementation Notes

**Version:** 1.1  
**Date:** 22 September 2026  
**Scope:** CRC working scenario; binary CTCAE grade >=2 CIPN endpoint

---

## 1. Purpose

This note gives the mathematical derivation used by the R and SAS implementations after adoption of the three-region Phase II efficacy framework:

[
egin{cases}
Delta_{max}<5% & 	ext{No-Go leaning}\
5%leDelta_{max}<10% & 	ext{Consider}\
Delta_{max}ge10% & 	ext{Go leaning}
end{cases}
]

The Stage 1 conditional-power calculation is non-binding decision support.

---

## 2. Notation

For a binary unfavorable endpoint:

[
Y=1
]

denotes CTCAE grade >=2 CIPN.

Treatment effect is:

[
oxed{Delta=p_P-p_T}
]

where (p_P) is the placebo event probability and (p_T) is the active-treatment event probability.

Positive values favor treatment.

For CRC:

[
p_P=0.45,qquad p_T=0.30,
]

and therefore:

[
oxed{Delta_{mathrm{target}}=0.15}.
]

The development quantities are:

[
oxed{Delta_{mathrm{weak}}=0.05}
]

and:

[
oxed{Delta_{mathrm{promising}}=0.10}.
]

These quantities have different roles:

- 15% = target treatment effect;
- 5% = weak-effect boundary;
- 10% = promising threshold.

---

## 3. Final Phase II efficacy classification

For Low and High:

[
widehatDelta_L
=
widehat p_P-widehat p_L,
]

[
widehatDelta_H
=
widehat p_P-widehat p_H.
]

Define:

[
widehatDelta_{max}
=
max(
widehatDelta_L,
widehatDelta_H
).
]

Then:

[
oxed{
egin{cases}
widehatDelta_{max}<0.05
&
	ext{No-Go leaning}\[2mm]
0.05lewidehatDelta_{max}<0.10
&
	ext{Consider}\[2mm]
widehatDelta_{max}ge0.10
&
	ext{Go leaning}
end{cases}
}
]

This is an efficacy classification only and is not a confirmatory hypothesis test.

---

## 4. Final promising event used inside CP

For one active dose, let Stage 1 contain:

[
(x_P,n_P),qquad(x_T,n_T),
]

with planned final sample sizes:

[
N_P,qquad N_T.
]

The observed Stage 1 effect is:

[
widehatDelta_1
=
rac{x_P}{n_P}
-
rac{x_T}{n_T}.
]

For the remaining patients:

[
m_P=N_P-n_P,
qquad
m_T=N_T-n_T.
]

Under the future-data assumption:

[
Y_Psim Bin(m_P,q_P),
]

[
Y_Tsim Bin(m_T,q_T).
]

The primary working future assumption is:

[
q_P=0.45,qquad q_T=0.30.
]

The final Phase II promising event is:

[
oxed{
rac{x_P+Y_P}{N_P}
-
rac{x_T+Y_T}{N_T}
ge0.10
}
]

The 10% threshold is no longer a provisional computational value; it is the prespecified promising threshold in the current Phase II efficacy framework.

---

## 5. Exact individual conditional power

For a single active dose:

[
CP
=
Pleft(
rac{x_P+Y_P}{N_P}
-
rac{x_T+Y_T}{N_T}
geDelta_{mathrm{promising}}
mid
D_1,	heta_{mathrm{future}}
ight).
]

Condition on:

[
Y_P=y_P.
]

Then success requires:

[
rac{x_P+y_P}{N_P}
-
rac{x_T+Y_T}{N_T}
geDelta_{mathrm{promising}}.
]

Rearrange:

[
Y_T
le
N_T
left(
rac{x_P+y_P}{N_P}
-
Delta_{mathrm{promising}}
ight)
-
x_T.
]

Define:

[
K_T(y_P)
=
leftlfloor
N_T
left(
rac{x_P+y_P}{N_P}
-
Delta_{mathrm{promising}}
ight)
-
x_T
ightfloor.
]

Therefore:

[
P(	ext{promising final result}mid Y_P=y_P)
=
F_{mathrm{Bin}}
left(
K_T(y_P);
m_T,q_T
ight).
]

The exact CP is:

[
oxed{
CP
=
sum_{y_P=0}^{m_P}
P(Y_P=y_P)
F_{mathrm{Bin}}
left(
K_T(y_P);
m_T,q_T
ight)
}
]

where:

[
P(Y_P=y_P)
=
{m_Pchoose y_P}
q_P^{y_P}
(1-q_P)^{m_P-y_P}.
]

This is implemented in both R and SAS.

---

## 6. Joint conditional power for Low and High doses

Let:

[
(x_L,n_L),qquad(x_H,n_H)
]

be the active-arm Stage 1 observations.

The future variables are:

[
Y_Psim Bin(N_P-n_P,q_P),
]

[
Y_Lsim Bin(N_L-n_L,q_L),
]

[
Y_Hsim Bin(N_H-n_H,q_H).
]

For a fixed future placebo count (Y_P=y_P), define:

[
Q_L(y_P)
=
P(
widehatDelta_{L,F}ge0.10
mid
Y_P=y_P,D_1
),
]

[
Q_H(y_P)
=
P(
widehatDelta_{H,F}ge0.10
mid
Y_P=y_P,D_1
).
]

Conditional on the common (Y_P), future Low and High outcomes are independent.

Hence:

[
P(
	ext{at least one dose is final-promising}
mid
Y_P=y_P
)
]

is:

[
1-
[1-Q_L(y_P)]
[1-Q_H(y_P)].
]

Thus:

[
oxed{
CP_{mathrm{joint}}
=
sum_{y_P=0}^{m_P}
P(Y_P=y_P)
left{
1-
[1-Q_L(y_P)]
[1-Q_H(y_P)]
ight}
}
]

The common placebo arm is therefore handled directly rather than treating the two comparisons as independent.

---

## 7. Equal-n interim reference effects

For design presentation only, suppose:

[
n_P=n_T=n_1.
]

Then:

[
widehatDelta_1
=
rac{x_P-x_T}{n_1}.
]

Define:

[
D=x_P-x_T.
]

The displayed interim reference effect is:

[
oxed{
Delta_{mathrm{ref}}
=
rac{D}{n_1}
}
]

A row such as:

[
Delta_{mathrm{ref}}=9.09%
]

at:

[
n_1=22
]

corresponds to:

[
D=2.
]

That means placebo has two more observed CIPN events than treatment.

This is a calibration/reference point, not an automatic futility boundary.

---

## 8. Exact probability of entering an interim reference region

For equal nominal Stage 1 sample size (n_1), both active doses are at or below a reference event-count difference (D) if:

[
x_P-x_Lle D
]

and:

[
x_P-x_Hle D.
]

Equivalently:

[
x_Lge x_P-D,
]

[
x_Hge x_P-D.
]

Therefore:

[
oxed{
P(	ext{both at/below reference})
=
sum_{x_P=0}^{n_1}
f_{mathrm{Bin}}(x_P;n_1,p_P^{true})
}
]

[
oxed{
qquad	imes
left[
1-F_{mathrm{Bin}}
(x_P-D-1;n_1,p_L^{true})
ight]
left[
1-F_{mathrm{Bin}}
(x_P-D-1;n_1,p_H^{true})
ight]
}
]

Because the Stage 1 review is non-binding, this probability should not automatically be labeled a stopping probability.

---

## 9. Exact final No-Go / Consider / Go probabilities

At the final analysis with equal sample size (N) per arm:

[
X_Psim Bin(N,p_P),
]

[
X_Lsim Bin(N,p_L),
]

[
X_Hsim Bin(N,p_H).
]

For a realization ((x_P,x_L,x_H)):

[
widehatDelta_L
=
rac{x_P-x_L}{N},
]

[
widehatDelta_H
=
rac{x_P-x_H}{N},
]

and:

[
widehatDelta_{max}
=
max(
widehatDelta_L,
widehatDelta_H
).
]

Let the classification function be:

[
C(widehatDelta_{max})
=
egin{cases}
N & widehatDelta_{max}<0.05\
C & 0.05lewidehatDelta_{max}<0.10\
G & widehatDelta_{max}ge0.10
end{cases}.
]

Then for class (cin{N,C,G}):

[
oxed{
P(C=c)
=
sum_{x_P=0}^{N}
sum_{x_L=0}^{N}
sum_{x_H=0}^{N}
I{C(widehatDelta_{max})=c}
}
]

[
oxed{
qquad	imes
f_{mathrm{Bin}}(x_P;N,p_P)
f_{mathrm{Bin}}(x_L;N,p_L)
f_{mathrm{Bin}}(x_H;N,p_H)
}
]

This exact enumeration is implemented in both the R and SAS engines.

---

## 10. Why final classification probabilities do not depend on Stage 1 timing

Under the current framework:

- Stage 1 is non-binding;
- there is no deterministic rule that truncates the final analysis population;
- the final classification is based on the complete final Phase II data.

Therefore:

[
P(
	ext{Final No-Go / Consider / Go}
)
]

depends on:

[
N,quad
p_P,quad
p_L,quad
p_H,
]

but not directly on:

[
f_1.
]

The Stage 1 information fraction affects the distribution of CP and the practical value of the interim review.

If a mechanical early-stop or dose-drop rule is later introduced, the full design operating characteristics will depend on (f_1), and the simulation must explicitly model that rule.

---

## 11. Discreteness of the 5% and 10% regions

Because:

[
x_P-x_T
]

is integer-valued, the attainable observed effects are:

[
rac{D}{N}.
]

The thresholds 5% and 10% therefore correspond to different integer event-count requirements across candidate sample sizes.

For example, at (N=44):

- (D=2) gives 4.55%;
- (D=3) gives 6.82%;
- (D=4) gives 9.09%;
- (D=5) gives 11.36%.

Thus:

- No-Go leaning corresponds to (Dle2);
- Consider corresponds to (D=3) or (4);
- Go leaning begins at (Dge5).

This discreteness explains why classification probabilities can change non-monotonically across nearby values of (N).

---

## 12. Current exact operating-characteristic grid

The initial final-classification grid uses:

[
N=36,40,44,48,52
]

and true effects:

[
0%,5%,10%,15%,20%.
]

For (N=44):

| True effect | P(No-Go leaning) | P(Consider) | P(Go leaning) |
|---:|---:|---:|---:|
| 0% | 56.23% | 17.11% | 26.66% |
| 5% | 36.07% | 18.57% | 45.36% |
| 10% | 18.94% | 15.57% | 65.49% |
| 15% | 7.79% | 9.89% | 82.32% |
| 20% | 2.38% | 4.61% | 93.01% |

These are efficacy-classification probabilities and not automatic development-decision probabilities.

---

## 13. R/SAS cross-validation

The existing fixed CP regression checks remain valid because the 10% final promising threshold equals the previous computational threshold.

For:

[
N=44,qquad n_1=22,
]

[
q_P=0.45,qquad q_T=0.30,
]

the following values should be reproduced:

- (D=0):
  - individual CP = 0.3549137605;
  - joint CP = 0.4999095300;
- (D=2) (9.09%):
  - individual CP = 0.6019411641;
  - joint CP = 0.7554491695;
- (D=-1) (-4.55%):
  - individual CP = 0.2451685272;
  - joint CP = 0.3648833940.

The unequal-n tests remain required for operational validation.

---

## 14. Assumptions and limitations

The current implementation assumes:

1. independent binary outcomes between participants;
2. explicit shared-placebo handling in joint CP;
3. design-alternative future rates of 45% vs 30%;
4. 10% as the final Phase II promising threshold;
5. 5% as the weak-effect boundary;
6. 15% as the target treatment effect;
7. no automatic safety override inside the CP formula;
8. no missing-data model in the current core engine;
9. no deterministic interim stop/dose-drop rule;
10. Stage 1 based on the prespecified mature efficacy cohort.

Future extensions may add:

- overrun and delayed-endpoint simulation;
- enrollment slowdown;
- missing/non-evaluable outcomes;
- asymmetric true effects for Low and High;
- explicit contextual review rules;
- dose dropping if ultimately selected.

---

## 15. Implementation files

R:

`simulation/cp_futility_engine.R`

SAS:

`simulation/cp_futility_engine.sas`

Final classification results:

`simulation/results/cp_final_classification_grid_v1_1.csv`

Formal report:

`docs/cp_futility_formal_report_v1_1.md`

---

## References

1. Lan KKG, Wittes J. The B-value: a tool for monitoring data. *Biometrics*. 1988;44(2):579-585.
2. Jung SH. Randomized phase II trials with a prospective control. *Statistics in Medicine*. 2008;27(4):568-583.
3. Ortega-Villa AM, et al. Futility Monitoring in Clinical Trials. *Statistics in Medicine*. 2025.
4. VITALITY-HFpEF (NCT03547583), Statistical Analysis Plan.
5. PTG-100-02 (NCT02895100), Protocol and Statistical Analysis Plan.
6. TAK-555-3010 (NCT04759833), Protocol and Statistical Analysis Plan.
