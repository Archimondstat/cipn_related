# Competitor landscape: CIPN prevention trials

Date: 2026-09-19

## Why this comes before adaptive-design tuning

The Phase II design assumptions should not be fixed until the external evidence base is mapped. In particular, competitor trials can inform:

- expected control incidence of CTCAE grade >=2 CIPN;
- clinically credible absolute risk reduction;
- assessment horizon and whether the endpoint is cumulative ("ever by time X") or landmark;
- chemotherapy-backbone dependence of CIPN incidence;
- dose-selection patterns;
- handling of chemotherapy discontinuation, missing data, and treatment exposure;
- realistic attrition between randomization and endpoint-evaluable populations.

The working primary endpoint for drug C remains binary CTCAE grade >=2 CIPN, but its exact estimand is not yet frozen.

## Preliminary high-priority comparators

### Alliance A221805 — duloxetine prevention of oxaliplatin CIPN
- Phase II screening study with exactly three arms: duloxetine 30 mg, duloxetine 60 mg, placebo, randomized 1:1:1.
- Stage II/III colorectal cancer receiving FOLFOX or CAPOX.
- Drug/placebo started with oxaliplatin and continued for 17 weeks.
- Phase II objective was dose screening before possible Phase III.
- Simon two-stage selection design was applied separately to each duloxetine arm.
- Assumptions: historical placebo response 0.50, duloxetine response 0.70; one-sided alpha 0.05, 90% power.
- A dose was considered promising if >=32/54 evaluable subjects responded.
- If one dose passed, it advanced; if both passed, the higher observed response rate advanced; ties favored the lower dose; if neither passed, development stopped.
- Actual 2026 result: placebo response 68.0%, duloxetine 30 mg 65.2%, duloxetine 60 mg 66.0%; neither dose was promising.
- Important operational lesson: only 143/199 randomized subjects were evaluable for the primary endpoint (~72%).

Primary publication:
https://ascopubs.org/doi/10.1200/OA-25-00107
Protocol/SAP:
https://cdn.clinicaltrials.gov/large-docs/07/NCT04137107/Prot_SAP_000.pdf

### ART-123 — recombinant thrombomodulin prevention of oxaliplatin CIPN
- Randomized, double-blind Phase IIa, three arms: placebo, 1-day ART-123, 3-day ART-123.
- Stage II/III colon cancer, adjuvant mFOLFOX6.
- CTCAE grade >=2 sensory neuropathy was a key exploratory endpoint.
- At cycle 12: placebo 64.3%, 1-day ART-123 40.7%, 3-day ART-123 45.8%.
- Absolute differences versus placebo were about 23.5% and 18.5%, respectively.
- Small exploratory study (79 treated), so effect estimates are unstable, but highly relevant for plausible effect-size scenarios.

Publication:
https://pmc.ncbi.nlm.nih.gov/articles/PMC7561567/
Trial: NCT02792842

### GM1 prevention trial
- Randomized, double-blind, placebo-controlled Phase III in stage II/III colorectal cancer receiving adjuvant mFOLFOX6.
- Primary endpoint: rate of grade >=2 cumulative neurotoxicity by NCI-CTCAE.
- 196 randomized.
- Result: GM1 33.7% vs placebo 31.6%; no prevention benefit.
- Strong direct benchmark for the same CTCAE >=2 endpoint.

Publication:
https://pmc.ncbi.nlm.nih.gov/articles/PMC6943144/
Trial: NCT02251977

### POLAR-M / POLAR-A — calmangafodipir
- Drug given concurrently with mFOLFOX6.
- POLAR-M used low dose, high dose, and placebo in a 1:1:1 design.
- Phase III primary endpoint was patient-reported moderate-to-severe chronic CIPN at month 9, not CTCAE >=2.
- Planned sample-size assumption: reduction from 40% placebo to 20% active.
- Program stopped early after hypersensitivity reactions.
- Combined month-9 primary-endpoint event rates: 54.3% CaM 5 µmol/kg vs 40.3% placebo; no efficacy.
- Relevant mainly for three-arm dose architecture, delayed endpoint, concurrent dosing, and the risk of optimistic historical assumptions.

Publication:
https://pmc.ncbi.nlm.nih.gov/articles/PMC9678401/
Trials: NCT03654729 (POLAR-M), NCT04034355 (POLAR-A)

## Broader evidence on CTCAE grade >=2 OIPN

A 2025 systematic review of 20 randomized trials in colorectal cancer receiving oxaliplatin found:
- CTCAE grade >=2 OIPN was commonly assessed during treatment;
- median grade >=2 incidence in placebo/control arms at end of treatment (8–12 cycles) was 57.95%;
- range was very wide: 31.2% to 100%;
- 14 pharmacologic interventions were represented;
- large heterogeneity existed by regimen, timing, intervention, and trial quality.

This wide control-rate range is a warning against choosing a single p0 before chemotherapy backbone and endpoint horizon are fixed.

Source:
https://www.frontiersin.org/journals/oncology/articles/10.3389/fonc.2025.1642552/full

## Taxane prevention benchmarks

If the future drug-C trial includes paclitaxel/nab-paclitaxel, the control rate must be estimated separately from oxaliplatin.

Examples:
- A randomized phase III gabapentin prevention protocol uses CTCAE v5.0 grade >=2 CIPN as the primary endpoint in paclitaxel-treated patients (planned N=136).
- A 2026 randomized surgical-glove compression study reported grade >=2 sensory CIPN of 60.0% in placebo vs 26.3% with compression after four paclitaxel cycles.
- A current GM1 prophylaxis study in nab-paclitaxel breast cancer includes grade >=2 CTCAE CIPN at cycles 4 and 6 as a secondary endpoint.

These should be treated as a separate evidence stratum rather than pooled directly with oxaliplatin trials.

## Competitive-analysis extraction fields

For every relevant study we should extract:
1. agent / mechanism;
2. chemotherapy backbone;
3. tumor setting and line/intent;
4. treatment timing relative to chemotherapy;
5. dose arms and randomization ratio;
6. phase and sample size;
7. primary endpoint definition;
8. CTCAE version;
9. exact definition of grade >=2 endpoint;
10. assessment time/horizon;
11. placebo/control grade >=2 incidence;
12. active-arm incidence;
13. absolute risk difference;
14. relative risk / odds ratio if reported;
15. endpoint-evaluable fraction;
16. missing-data rule;
17. chemotherapy discontinuation/dose-reduction handling;
18. multiplicity / dose-selection / interim rule;
19. safety signals;
20. development outcome (advanced, stopped, failed, ongoing).

## Immediate implication

Do not yet lock p0, delta_min, delta_target, Stage-1 size, or Go/No-Go boundaries.

First stratify the competitor evidence by:
- oxaliplatin vs taxane vs other neurotoxic backbone;
- end-of-treatment cumulative CTCAE >=2 vs landmark CTCAE >=2;
- adjuvant vs metastatic setting;
- treatment duration / cumulative chemotherapy exposure.

Only then should historical scenarios be converted into simulation assumptions for FREQ-01 and BAYES-01.


## 2026 current-development update

The competitor landscape should distinguish **published historical benchmarks** from **currently active drug-development programs**. The latter are especially relevant for endpoint/regulatory choices, even when they do not yet provide mature effect estimates.

### PC-SOD (lecithinized superoxide dismutase) — PROSPER Phase III
- Sponsor/development group: Japanese multicenter program.
- Current status: Phase III program reported as ongoing/recruiting in 2026.
- Population: curatively resected stage II/III colorectal cancer, planned 12 cycles of adjuvant mFOLFOX6.
- Design: randomized, double-blind, placebo-controlled, approximately 350 participants, 1:1 allocation.
- **Primary endpoint: time to onset of CTCAE grade >=2 CIPN.**
- Key secondary endpoint: time to onset of DEB-NTC grade >=2 CIPN; oxaliplatin infusion-related reactions are also evaluated.
- Phase II predecessor (jRCT2031210466): 90 participants (PC-SOD 43, placebo 47); primary endpoint was number of cycles/time until NCI-CTCAE grade >=2 CIPN. The phase II primary endpoint was not met (HR 0.88, 95% CI 0.44-1.78), but the program nevertheless advanced to Phase III.
- **Design relevance:** among current programs this is one of the closest matches to our planned binary CTCAE >=2 prevention endpoint, except that PROSPER uses time-to-onset rather than a fixed-horizon binary endpoint.

Sources:
- Phase II publication: https://www.sciencedirect.com/science/article/pii/S2949819825001384
- Phase III PROSPER publication: https://pubmed.ncbi.nlm.nih.gov/42583153/
- Phase III trial abstract: https://ascopubs.org/doi/10.1200/JCO.2026.44.2_suppl.TPS257

### ART-123 (recombinant thrombomodulin) — Phase III
- Sponsor: Asahi Kasei Therapeutics.
- Trial: jRCT2051250045.
- Current status: recruiting; first enrollment in June 2025.
- Target sample size: 450.
- Population: oxaliplatin-treated patients; Phase II precedent used stage II/III colon cancer receiving adjuvant mFOLFOX6.
- Phase III primary endpoint: change from baseline in FACT/GOG-NTX4.
- Important secondary endpoint: proportion developing CTCAE grade >=2 peripheral sensory neuropathy.
- Phase IIa precedent: placebo / 1-day ART-123 / 3-day ART-123, with cumulative CTCAE grade >=2 sensory neuropathy at cycle 12 of 64.3%, 40.7%, and 45.8%, respectively.
- **Design relevance:** very relevant for plausible effect-size scenarios and 3-arm dose/schedule architecture, but its current Phase III program has moved the primary endpoint from CTCAE to a PRO endpoint.

Sources:
- Phase II publication: https://pmc.ncbi.nlm.nih.gov/articles/PMC7561567/
- Phase III registry: https://jrct.mhlw.go.jp/en-latest-detail/jRCT2051250045

### GM1 — Gypsophila Phase III in nab-paclitaxel breast cancer
- Sponsor: Qilu Pharmaceutical.
- Trial: NCT06994507 / QLGM1-CIPN-301.
- Current status: recruiting.
- Population: breast cancer receiving nab-paclitaxel in adjuvant/neoadjuvant treatment.
- Design: randomized, double-blind, placebo-controlled Phase III; planned N=352 (176 per group).
- Primary endpoint: at C4D21, proportion with FACT/GOG-NTX deterioration >12 points from baseline.
- **Design relevance:** current pharmacologic prevention competitor in the taxane stratum; should not be pooled with oxaliplatin control-rate assumptions.

Source:
- https://clinicaltrials.gov/study/NCT06994507

### AH-008 — early pipeline
- Sponsor: AnHorn Medicines.
- Current status: first-in-human Phase I in healthy volunteers began in 2026 (NCT07697560).
- Development intent: pharmacologic prevention of CIPN, with stated broad applicability across taxanes, platinum agents, and ADCs.
- No patient efficacy data are yet available.
- **Design relevance:** commercial/pipeline surveillance only at present; not suitable for p0 or effect-size calibration.

Sources:
- https://www.anhornmed.com/news/ah008-cipn-pain-prevention-fsfv/
- NCT07697560

## Important reclassification of Alliance A221805

Alliance A221805 is highly relevant as a **dose-screening design precedent**, but it should not be treated as a direct randomized active-versus-placebo efficacy comparison for calibrating our CTCAE grade >=2 endpoint.

Key points:
- The Phase II portion was explicitly described as **noncomparative**.
- Placebo was included as a calibration arm and to facilitate transition to a possible Phase III.
- Simon's two-stage design was applied **separately to each duloxetine dose arm** against a historical response rate (p0=0.50; target p1=0.70; one-sided alpha 0.05; 90% power).
- A dose was promising if >=32/54 evaluable participants maintained minimal sensory symptoms.
- If both doses passed, the higher observed response rate was selected; a tie favored the lower dose.
- The primary outcome was a six-item EORTC QLQ-CIPN20 sensory composite, not CTCAE grade >=2.
- Only 143/199 randomized participants (71.8%) were primary-endpoint evaluable; the trial had assumed only ~3% missing postbaseline data, but 21.1% had missing postbaseline OIPN data.

**Implication:** use A221805 to inform Stage-1/Stage-2 screening logic, endpoint evaluability, and operational attrition. Do not use its placebo response rate directly as p0 for CTCAE grade >=2.

Source:
- https://pmc.ncbi.nlm.nih.gov/articles/PMC13120771/

## Evidence hierarchy for converting competitors into design assumptions

For the planned drug-C Phase II study, evidence should be weighted in the following order when estimating control incidence and plausible benefit:

1. **Same chemotherapy backbone + same CTCAE grade >=2 definition + same exposure horizon**
   - strongest source for p0 and delta scenarios;
2. **Same backbone + same CTCAE threshold but different time metric/horizon**
   - e.g. fixed-horizon cumulative incidence versus time-to-onset;
3. **Same backbone + different CIPN endpoint**
   - useful for architecture, evaluability, and timing, but not direct p0 calibration;
4. **Different neurotoxic backbone (e.g. taxane vs oxaliplatin)**
   - separate evidence stratum;
5. **Non-pharmacologic interventions / small exploratory studies**
   - useful as external context and for range checks, but should have low weight in quantitative assumptions.

The current evidence therefore supports building **backbone-specific p0 scenarios** rather than one global CIPN control rate.
