# Stage 1 No-Go Methods: Simon-Style vs Conditional Power

Date: 2026-09-20  
Status: working framework for internal departmental review

## Current decision objective

The current Phase II concept has three randomized arms:

- Placebo
- Low-dose C
- High-dose C

The primary endpoint for design purposes is binary: CTCAE grade >=2 CIPN.

The purpose of Stage 1 is **not dose selection**. The Stage 1 efficacy question is a project-level futility question:

> Are both active doses sufficiently unpromising that the Phase II program should stop early?

Therefore, the Stage 1 efficacy action is currently intended to be:

- **No-Go:** stop the program for efficacy futility.
- **Go:** continue to Stage 2.

Dose selection (Low vs High, or whether both remain of development interest) is reserved for the mature Phase II evidence package, unless safety independently requires earlier dose discontinuation.

This can be expressed generically as:

[
	ext{No-Go if both active doses satisfy the prespecified futility criterion.}
]

The two methods currently under consideration answer the **same clinical/operational decision problem**, but they use different statistical definitions of "futility."

---

## Method A: Simon-style two-stage futility

### Core idea

A Simon-style design uses the observed Stage 1 response/event count and a prespecified futility boundary.

For a favorable binary response endpoint, the classical form is:

[
X_{j1} le r_1 Rightarrow 	ext{dose }j	ext{ is futile}.
]

For an unfavorable endpoint such as CTCAE grade >=2 CIPN, the direction would be reversed or the endpoint can be re-expressed as a favorable response.

For the current project-level No-Go objective:

[
	ext{No-Go if both Low and High fall in their Stage 1 futility regions.}
]

The interim calculation itself is simple. The implications of Stage 2 are embedded in the design calibration rather than explicitly recomputed at interim.

### Important limitation for our study

The classical Simon two-stage design is naturally a **single-arm design against a fixed historical rate**. Applying it separately to Low and High is therefore straightforward if each active dose is screened against a historical benchmark.

However, our trial includes a concurrent placebo arm. If the Stage 1 decision is intended to depend directly on contemporaneous contrasts,

[
hat p_P-hat p_L,qquad hat p_P-hat p_H,
]

then the design is no longer a classical Simon design. It becomes a **Simon-style randomized screening design**, and its stopping boundaries and operating characteristics should be calibrated by simulation.

---

## Reference example for the Simon-style route: Alliance A221805

**Trial:** Alliance A221805 / NCT04137107  
**Setting:** prevention of oxaliplatin-induced CIPN  
**Phase II arms:** duloxetine 30 mg, duloxetine 60 mg, placebo, randomized 1:1:1.

The Phase II component used separate Simon-type two-stage rules for the two duloxetine dose arms, judged against a historical response rate of 50%.

Protocol details:

- Stage 1: 26 patients per duloxetine dose.
- If 13 or fewer of 26 responded, that dose arm was terminated.
- If the dose proceeded, 54 evaluable patients were studied at that dose.
- At final Phase II analysis, >=32/54 responders was considered sufficient activity to warrant further study.
- The Phase II component was explicitly described as non-comparative; the concurrent placebo arm served primarily as a check on the historical control assumption.
- The protocol stated that randomization would **not be suspended between Stage 1 and Stage 2**.
- Patients accrued beyond the target number for the stopping rule were **not used for the stopping rule or decision-making**, but could contribute to the Phase III evaluation if the program proceeded.

This trial is directly relevant to the current CIPN project because it demonstrates a practical combination of:

1. CIPN prevention;
2. two active doses plus placebo;
3. a two-stage screening structure;
4. delayed endpoint maturation;
5. continued accrual/overrun while Stage 1 outcomes mature.

It should not be copied mechanically because its Simon rules were based on historical control rates rather than concurrent active-vs-placebo treatment effects.

**Sources**

- Alliance A221805 protocol / SAP:  
  https://cdn.clinicaltrials.gov/large-docs/07/NCT04137107/Prot_SAP_000.pdf
- Phase II report:  
  https://pmc.ncbi.nlm.nih.gov/articles/PMC13120771/
- Trial overview:  
  https://www.cancer.gov/research/participate/clinical-trials-search/v?id=NCT04137107

---

## Method B: Conditional-power futility

### Core idea

Conditional power (CP) asks whether, given the Stage 1 result and an assumption about the remaining observations, the trial still has a meaningful chance of achieving the prespecified final success criterion.

For dose (j),

[
CP_j
=
P(	ext{final success for dose }j
mid D_1,	ext{future-data assumption}).
]

For the current project-level No-Go objective, a natural rule is:

[
max(CP_L,CP_H)<c_F
Rightarrow 	ext{No-Go}.
]

Equivalently, the program stops only if **both doses have conditional power below the futility threshold**. If at least one dose retains sufficient conditional power, the program proceeds to Stage 2.

This is different from using CP for interim dose selection.

### What must be specified

Conditional power is not determined by Stage 1 data alone. It requires:

1. the Stage 1 data;
2. the planned remaining sample/information;
3. a definition of final success;
4. an assumption about the treatment effect/event rates in future patients.

Common future-data assumptions include:

- the originally hypothesized treatment effect;
- the treatment effect currently observed at interim;
- an intermediate/shrunken assumption.

The choice matters materially. A current-trend CP can be unstable early in a trial, while CP under the original design alternative can be relatively optimistic if the observed data are weak.

For this reason, the CP threshold and future-data assumption should be calibrated by simulation rather than chosen by convention.

---

## Reference example for the conditional-power route: FIT-04

**Trial:** FIT-04 / NCT02510560  
**Setting:** enteral recombinant human insulin in preterm infants  
**Arms:** low-dose insulin, high-dose insulin, placebo.

The study planned a futility interim analysis using the first 225 randomized infants.

Key features reported in the publication:

- Conditional power was recalculated from the first 225 randomized infants.
- The prespecified futility threshold was 35%.
- Conditional power was below 35% for both insulin doses.
- The DSMB recommended discontinuation for futility, and the steering committee and sponsor accepted the recommendation.
- Enrollment continued while the DSMB analyzed and discussed the interim data.
- Consequently, 303 infants were randomized and included in the final ITT analysis.
- The final analysis subsequently showed statistically significant effects for both doses.
- The authors explicitly identified the 35% futility threshold as potentially too high and recommended a lower threshold in future trials to reduce the risk of erroneous early termination.

This example is especially relevant to our current Stage 1 concept because the observed decision structure was:

[
CP_L<c_F,quad CP_H<c_F
Rightarrow 	ext{project-level No-Go}.
]

It also illustrates two issues that are directly relevant to the CIPN study:

1. **Overrun during interim review:** patients may continue to enter while the Stage 1 analysis is being completed.
2. **False No-Go risk:** an aggressive CP threshold can terminate a program that later data would have supported.

A limitation is that the publication does not fully resolve how the study would have been handled if only one dose had CP below 35%. Therefore FIT-04 supports the "both doses futile -> overall stop" precedent, but should not be used as evidence for our exact rule when only one dose is futile.

**Source**

- Mank E, et al. *Efficacy and Safety of Enteral Recombinant Human Insulin in Preterm Infants: A Randomized Clinical Trial.* JAMA Pediatrics.  
  https://jamanetwork.com/journals/jamapediatrics/fullarticle/2789461

---

## Relationship between the two candidate methods

The current conclusion is:

[
oxed{	ext{Same decision objective, different statistical criterion.}}
]

Both methods can be configured to answer:

> Is the probability that either dose remains worth pursuing so low that the whole Phase II program should stop now?

But they operationalize futility differently.

| Feature | Simon-style | Conditional power |
|---|---|---|
| Stage 1 quantity | Observed response/event count or rate | Probability of final success conditional on interim data |
| Stage 2 explicitly projected at interim? | No; embedded in boundary calibration | Yes |
| Requires final success definition? | Not necessarily explicit at interim | Yes |
| Requires future-data assumption? | No | Yes |
| Classical natural setting | Single-arm vs fixed historical rate | Randomized comparison and planned final analysis |
| Concurrent placebo utilization | Requires randomized extension/modification | Natural |
| Interpretability | "Current result is below the activity threshold" | "Chance of eventual success is now too low" |
| Main risk | Historical benchmark may not transport; adaptation to concurrent control needed | CP depends strongly on assumed future effect and futility cutoff |

For our project, the methods should eventually be compared **after calibration to the same false-No-Go tolerance**.

A key operating characteristic is:

[
P(	ext{Stage 1 No-Go}mid 	ext{at least one dose truly has target activity}).
]

This is the error we most want to limit because Stage 1 No-Go terminates the whole development path.

After matching the two methods on this risk, comparison can focus on:

- (P(	ext{early No-Go}mid	ext{both doses ineffective}));
- expected sample size;
- expected duration;
- number of overrun/pipeline patients;
- sensitivity to the placebo event rate;
- operational complexity and interpretability.

---

## Accrual concept currently paired with the Stage 1 framework

The current working operational concept is:

1. accrue the prespecified Stage 1 cohort;
2. once sufficient Stage 1 enrollment is reached, **slow recruitment operationally rather than imposing an immediate hard stop**;
3. additional subjects are overrun/pipeline subjects;
4. overrun subjects do not enter the prespecified Stage 1 efficacy calculation;
5. their data remain part of the total Phase II evidence and may inform the subsequent decision to proceed to Phase III;
6. safety data remain continuously reviewable.

A221805 provides a direct precedent for excluding excess accrued patients from the Stage 1 stopping rule while retaining them for later evaluation. FIT-04 illustrates the practical occurrence of substantial overrun while a CP futility decision is being reviewed.

The exact slowdown mechanism or overrun cap is **not yet selected**.

---

## Design literature for internal review

### Two-stage / selection-design literature

1. **Simon R. (1989). Optimal two-stage designs for phase II clinical trials. Controlled Clinical Trials 10:1-10.**  
   Foundational Simon two-stage design: minimizes expected sample size under low activity subject to prespecified false-positive and false-negative constraints.  
   PMID 2702835  
   https://pubmed.ncbi.nlm.nih.gov/2702835/

2. **Simon R, Wittes RE, Ellenberg SS. (1985). Randomized phase II clinical trials. Cancer Treatment Reports 69:1375-1381.**  
   Introduces ranking-and-selection as an alternative Phase II objective to formal null-hypothesis testing and discusses randomized Phase II designs with early stopping.  
   PMID 4075313  
   https://pubmed.ncbi.nlm.nih.gov/4075313/

3. **Thall PF, Simon R, Ellenberg SS. (1989). A two-stage design for choosing among several experimental treatments and a control in clinical trials. Biometrics 45:537-547.**  
   Directly relevant to a multi-treatment setting: Stage 1 identifies whether the best experimental activity is sufficiently promising; if not, the trial terminates.  
   PMID 2765637  
   https://pubmed.ncbi.nlm.nih.gov/2765637/

4. **Yap C, Pettitt A, Billingham L. (2013). Screened selection design for randomised phase II oncology trials. BMC Medical Research Methodology 13:87.**  
   Combines Simon-style screening with randomized selection; useful background for extending a Simon concept beyond isolated single-arm studies.  
   https://pmc.ncbi.nlm.nih.gov/articles/PMC3726070/

5. **Optimal two-stage randomized phase II clinical trials. (2005).**  
   Discusses randomized two-stage Phase II designs in which multiple treatment arms can pass or fail the first stage and Stage 2 sample size depends on the number continuing.  
   PMID 16279574  
   https://pubmed.ncbi.nlm.nih.gov/16279574/

### Conditional-power / futility literature

6. **Futility Monitoring in Clinical Trials. Statistics in Medicine (2025).**  
   Practical tutorial reviewing conditional power, predictive power and other futility tools. It emphasizes that CP depends on the assumed future treatment effect and discusses original-design, current-trend and intermediate assumptions.  
   https://pmc.ncbi.nlm.nih.gov/articles/PMC12153251/

7. **Zhang Y, et al. A flexible futility monitoring method with time-varying conditional power boundary. (2010).**  
   Discusses the trade-off between aggressive and conservative CP futility thresholds and the resulting loss of overall power versus ability to stop inactive trials early.  
   https://pmc.ncbi.nlm.nih.gov/articles/PMC9036670/

8. **A systematic survey of randomised trials that stopped early for reasons of futility. (2020).**  
   Reviews real-world futility stopping practice and highlights variation in CP assumptions and frequent incomplete prespecification/documentation.  
   https://pmc.ncbi.nlm.nih.gov/articles/PMC6966801/

---

## Working conclusion for departmental review

At this stage, no method has been selected.

The two candidate Stage 1 frameworks should be presented as:

### A. Simon-style project futility
A fixed Stage 1 boundary, derived/calibrated before the trial, determines whether both doses are insufficiently promising.

### B. Conditional-power project futility
For each dose, calculate the conditional probability of achieving the final success criterion. Stop the entire program only if both doses fall below the prespecified futility threshold.

They are **alternative statistical implementations of the same Stage 1 business question**, not two different clinical objectives.

The next step is not to choose a cutoff. The next step is to complete the framework for internal review, then define the final Phase II success criterion and the clinically relevant (p_P), (delta_{min}), and (delta_{	ext{target}}) assumptions before any simulation-based calibration.
