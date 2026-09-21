# CIPN Phase II Conditional-Power Simulation
## Statistical Derivation and R/SAS Implementation Notes

**Version:** 1.0  
**Date:** 21 September 2026  
**Scope:** CRC working scenario; binary CTCAE grade >=2 CIPN endpoint

---

## 1. Purpose

This note provides the mathematical derivation used by the accompanying R and SAS programs.

The implementation is intended for two related tasks:

1. **design calibration / simulation**, including VITALITY-style reference tables; and
2. **actual Stage 1 calculation**, where mature sample sizes may differ across placebo, low-dose, and high-dose arms.

The current framework treats conditional power as **non-binding decision support**. A displayed reference treatment effect or CP value is not, by itself, an automatic stopping boundary.

---

## 2. Notation

The binary endpoint is:

[
Y=1
]

if a participant experiences CTCAE grade >=2 CIPN.

Because the event is unfavorable, treatment effect is defined as:

[
oxed{
Delta=p_P-p_T
}
]

where:

- (p_P): placebo event probability;
- (p_T): active-treatment event probability.

Thus:

[
Delta>0
]

favors treatment.

For the current CRC working scenario:

[
p_P=0.45,qquad
p_T=0.30,
]

so:

[
Delta_{target}=0.15.
]

For one active dose at Stage 1, let:

- (n_P,n_T): mature/evaluable interim sample sizes;
- (x_P,x_T): observed CTCAE grade >=2 event counts;
- (N_P,N_T): planned final efficacy-evaluable sample sizes.

The observed Stage 1 treatment effect is:

[
widehat{Delta}_1
=
rac{x_P}{n_P}
-
rac{x_T}{n_T}.
]

For the remaining participants define:

[
m_P=N_P-n_P,
qquad
m_T=N_T-n_T.
]

Under the prespecified future-data assumption:

[
Y_Psim Bin(m_P,q_P),
]

[
Y_Tsim Bin(m_T,q_T).
]

The current primary working assumption is the original design alternative:

[
q_P=0.45,
qquad
q_T=0.30.
]

---

## 3. Final success event used for conditional power

The current computational working definition of final success is:

[
widehat{Delta}_{final}
=
rac{x_P+Y_P}{N_P}
-
rac{x_T+Y_T}{N_T}
gedelta_{Go}.
]

At present:

[
delta_{Go}=0.10.
]

This 10% is **not** the assumed true CRC treatment effect. The assumed target effect remains 15%.

The final success definition is isolated in the code so it can later be replaced.

---

## 4. Exact individual conditional power

Conditional power for one active dose is:

[
CP
=
Pleft(
rac{x_P+Y_P}{N_P}
-
rac{x_T+Y_T}{N_T}
gedelta_{Go}
mid
x_P,n_P,x_T,n_T
ight).
]

Condition on a possible future placebo event count (Y_P=y_P).

The final success inequality is:

[
rac{x_P+y_P}{N_P}
-
rac{x_T+Y_T}{N_T}
gedelta_{Go}.
]

Rearranging:

[
rac{x_T+Y_T}{N_T}
le
rac{x_P+y_P}{N_P}
-
delta_{Go},
]

and therefore:

[
Y_T
le
N_T
left(
rac{x_P+y_P}{N_P}
-
delta_{Go}
ight)
-
x_T.
]

Because (Y_T) is an integer, define:

[
K_T(y_P)
=
leftlfloor
N_T
left(
rac{x_P+y_P}{N_P}
-
delta_{Go}
ight)
-
x_T
ightfloor.
]

Then:

[
P(	ext{final success}mid Y_P=y_P)
=
F_{Bin}
left(
K_T(y_P);
m_T,q_T
ight),
]

where (F_{Bin}) is the binomial CDF.

Thus the exact individual CP is:

[
oxed{
CP
=
sum_{y_P=0}^{m_P}
P(Y_P=y_P)
F_{Bin}
left(
K_T(y_P);
m_T,q_T
ight)
}
]

with:

[
P(Y_P=y_P)
=
{m_Pchoose y_P}
q_P^{y_P}
(1-q_P)^{m_P-y_P}.
]

This is the formula implemented in both R and SAS.

---

## 5. Joint conditional power for Low and High doses

Let Low and High have interim observations:

[
(x_L,n_L),
qquad
(x_H,n_H),
]

with final planned sample sizes (N_L,N_H).

They share the same placebo arm.

For the future data:

[
Y_Psim Bin(N_P-n_P,q_P),
]

[
Y_Lsim Bin(N_L-n_L,q_L),
]

[
Y_Hsim Bin(N_H-n_H,q_H).
]

Conditional on (Y_P=y_P), define:

[
Q_L(y_P)
=
P(	ext{Low reaches final success}mid Y_P=y_P),
]

[
Q_H(y_P)
=
P(	ext{High reaches final success}mid Y_P=y_P).
]

Given (Y_P), future Low and High outcomes are independent. Therefore:

[
P(	ext{at least one dose succeeds}mid Y_P=y_P)
]

is:

[
1-
left(1-Q_L(y_P)ight)
left(1-Q_H(y_P)ight).
]

The exact joint CP is therefore:

[
oxed{
CP_{joint}
=
sum_{y_P=0}^{m_P}
P(Y_P=y_P)
left[
1-
(1-Q_L(y_P))
(1-Q_H(y_P))
ight]
}
]

This treatment of the shared placebo arm is important. It is not correct to calculate joint CP as if the two active-vs-placebo comparisons had independent placebo observations.

---

## 6. Equal-n reference treatment-effect table

For design presentation only, suppose Stage 1 has equal nominal sample size:

[
n_P=n_T=n_1.
]

Then:

[
widehat{Delta}_1
=
rac{x_P-x_T}{n_1}.
]

Define the event-count difference:

[
D=x_P-x_T.
]

A displayed reference treatment effect is therefore:

[
oxed{
Delta_{ref}
=
rac{D}{n_1}
}
]

and a reference region:

[
widehat{Delta}_1
le
Delta_{ref}
]

is equivalent to:

[
x_P-x_Tle D.
]

Example:

[
n_1=22,
qquad
D=2.
]

Then:

[
Delta_{ref}
=
rac{2}{22}
=
9.09%.
]

This means the displayed reference point corresponds to placebo having two more CTCAE grade >=2 events than treatment.

Again, in the current non-binding framework this is a **calibration point**, not an automatic stopping rule.

---

## 7. Exact probability of falling in a displayed reference region

For two active doses with equal nominal Stage 1 sample size (n_1), consider a reference count difference (D).

Both active doses fall in the displayed reference region if:

[
x_P-x_Lle D
]

and:

[
x_P-x_Hle D.
]

Conditional on the observed placebo count (x_P), these inequalities are:

[
x_Lge x_P-D,
]

[
x_Hge x_P-D.
]

If the true event probabilities are:

[
p_P^{true},
quad
p_L^{true},
quad
p_H^{true},
]

then:

[
P(	ext{both below reference})
=
sum_{x_P=0}^{n_1}
P(X_P=x_P)
]

[
	imes
P(X_Lge x_P-D)
P(X_Hge x_P-D).
]

Therefore:

[
oxed{
P(	ext{both below reference})
=
sum_{x_P=0}^{n_1}
f_{Bin}(x_P;n_1,p_P^{true})
left[
1-F_{Bin}(x_P-D-1;n_1,p_L^{true})
ight]
left[
1-F_{Bin}(x_P-D-1;n_1,p_H^{true})
ight]
}
]

This is what is reported in the VITALITY-style table for true treatment effects of:

[
0%,quad5%,quad15%.
]

For example:

- true effect 0%:
  [
  p_P=0.45,quad p_L=p_H=0.45;
  ]
- true effect 5%:
  [
  p_P=0.45,quad p_L=p_H=0.40;
  ]
- true effect 15%:
  [
  p_P=0.45,quad p_L=p_H=0.30.
  ]

Because the Stage 1 decision is currently non-binding:

[
P(	ext{both below reference})
]

should **not** automatically be described as the probability of stopping the study.

It is the probability that the interim data fall into that displayed reference region.

---

## 8. Why individual CP can be indexed by event-count difference under equal n

Under the special design-calibration case:

[
n_P=n_T=n_1,
]

[
N_P=N_T=N,
]

and fixed future assumptions (q_P,q_T), the final success inequality depends on interim data through:

[
x_P-x_T.
]

Therefore all interim count pairs with the same difference (D=x_P-x_T) have the same individual CP.

This property allows the VITALITY-style design table to map:

[
D
longleftrightarrow
Delta_{ref}
longleftrightarrow
CP.
]

This simplification does **not** hold in general when actual interim sample sizes differ.

For actual analysis:

[
n_P
eq n_T
]

is allowed, and the CP program uses the complete tuple:

[
(x_P,n_P,x_T,n_T).
]

---

## 9. Monte Carlo simulation algorithm

The R and SAS simulation modules can validate the exact calculations and support later operational extensions.

For each simulated trial:

1. Generate mature Stage 1 event counts:
   [
   X_Psim Bin(n_P,p_P^{true}),
   ]
   [
   X_Lsim Bin(n_L,p_L^{true}),
   ]
   [
   X_Hsim Bin(n_H,p_H^{true}).
   ]

2. Calculate observed treatment effects:
   [
   widehat{Delta}_L
   =
   X_P/n_P-X_L/n_L,
   ]
   [
   widehat{Delta}_H
   =
   X_P/n_P-X_H/n_H.
   ]

3. Calculate (CP_L) and (CP_H) using the exact formulas above.

4. Optionally classify whether both observed effects are at or below a displayed reference value such as:
   [
   0%,quad5%,quad10%.
   ]

5. Repeat for a large number of trials and summarize:
   - CP distributions;
   - observed-effect distributions;
   - probability of falling into each displayed reference region.

The current core simulation deliberately does not impose a mechanical Go/No-Go decision.

---

## 10. R/SAS cross-validation strategy

The R and SAS implementations should be validated against one another using fixed test cases.

Recommended tests include:

### Test A: equal nominal n

[
N=44,qquad
n_1=22,
]

[
q_P=0.45,qquad
q_T=0.30,
]

[
delta_{Go}=0.10.
]

For an interim event-count difference:

[
D=0,
]

the current exact values are approximately:

[
CP_{individual}=35.49%,
]

[
CP_{joint}=49.99%.
]

For:

[
D=2
]

which corresponds to:

[
2/22=9.09%,
]

the current exact values are approximately:

[
CP_{individual}=60.19%,
]

[
CP_{joint}=75.54%.
]

### Test B: unequal mature n

Use a fixed example such as:

[
x_P=10,quad n_P=23,
]

[
x_T=8,quad n_T=21,
]

with final:

[
N_P=N_T=44.
]

R and SAS should return the same exact CP to numerical precision.

### Test C: reference-region probability

For:

[
N=44,quad n_1=22,quad Delta_{ref}=0,
]

the exact probability that both active doses fall at or below the 0% reference treatment effect is approximately:

- true effect 0%:
  [
  39.65%;
  ]
- true effect 5%:
  [
  26.46%;
  ]
- true effect 15%:
  [
  8.24%.
  ]

These values are useful regression tests for future code changes.

---

## 11. Current assumptions and limitations

The current code assumes:

1. independent binomial outcomes between participants;
2. shared placebo arm handled explicitly in joint CP;
3. design-alternative future event rates:
   [
   45%	ext{ vs }30%;
   ]
4. provisional final success event:
   [
   widehat{Delta}_{final}ge10%;
   ]
5. no safety override inside the CP calculation;
6. no accrual-delay / overrun model in the core CP engine;
7. no missing-data model in the current calculation;
8. Stage 1 CP is based on the prespecified mature efficacy cohort.

The following can be added later without changing the core derivation:

- overrun / delayed endpoint simulation;
- enrollment slowdown;
- unequal planned final allocation;
- missing or non-evaluable outcomes;
- alternative final Go definition;
- alternative future-data assumptions;
- safety decision overlay.

---

## 12. Implementation files

R:

`simulation/cp_futility_engine.R`

SAS:

`simulation/cp_futility_engine.sas`

The formal design report is:

`docs/cp_futility_formal_report_v1_0.md`

---

## 13. Methodological references

1. Lan KKG, Wittes J. The B-value: a tool for monitoring data. *Biometrics*. 1988;44(2):579-585.
2. Jung SH. Randomized phase II trials with a prospective control. *Statistics in Medicine*. 2008;27(4):568-583.
3. Ortega-Villa AM, et al. Futility Monitoring in Clinical Trials. *Statistics in Medicine*. 2025.
4. VITALITY-HFpEF (NCT03547583), Statistical Analysis Plan.
5. PTG-100-02 (NCT02895100), Protocol and Statistical Analysis Plan.
6. TAK-555-3010 (NCT04759833), Protocol and Statistical Analysis Plan.
