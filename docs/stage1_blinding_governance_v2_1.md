# Stage 1 blinding and governance framework

**Version:** 2.1  
**Date:** 25 September 2026  
**Status:** Working proposal for confirmation.

## 1. Why unblinded access is required

The Stage 1 decision is based on treatment-specific conditional power:

[
M=max(CP_L,CP_H).
]

Therefore the Stage 1 analysis cannot be performed from pooled blinded data. Treatment assignments must be available to a limited unblinded analysis function.

At the same time, the trial is randomized and placebo-controlled, and the primary endpoint is investigator-assessed CTCAE neuropathy. Knowledge of interim comparative efficacy could affect subsequent assessment, recruitment, treatment management, or interpretation. Access to comparative interim results should therefore be restricted.

## 2. External precedent

PTG-100-02 used an unblinded interim analysis performed by an Independent Statistical Centre. Only the Adaptive Design Review Committee and the Independent Statistical Centre were unblinded; the sponsor representative participating in the adaptive review was not involved in direct study conduct.

FDA adaptive-design guidance likewise recommends limiting comparative interim results to independent personnel with a need to know and maintaining a firewall between the unblinded interim-analysis function and those conducting or managing the trial.

ICH E20 draft guidance similarly recommends that an independent statistical group conduct analyses of accumulating unblinded data for an IDMC, with unblinded interim results kept from the operational study team whenever possible.

## 3. Features of the current AK135 design that simplify governance

The current Stage 1 adaptation is deliberately narrow:

- one prespecified Stage 1 cohort;
- one prespecified CP algorithm;
- one prespecified 70% cutoff;
- one project-level Go/No-Go decision;
- no dose dropping;
- no sample-size re-estimation;
- no change to randomization ratio;
- no alteration of the primary endpoint based on interim data.

Thus the efficacy adaptation itself requires very little discretionary interpretation.

## 4. Recommended minimum governance structure

### Blinded study team

The following should remain blinded to treatment-specific interim efficacy results:

- investigators and site staff;
- participants;
- sponsor clinical operations personnel;
- blinded data-management personnel;
- blinded medical/statistical personnel involved in ongoing trial conduct;
- others whose behavior could influence recruitment, endpoint assessment, or data handling.

### Independent unblinded statistician / statistical group

An independent unblinded statistician or independent statistical group should:

1. receive the Stage 1 analysis dataset and treatment code;
2. confirm the first-54 randomized-participant cohort;
3. derive Event / Non-event / Indeterminate status;
4. calculate slot-adjusted available-case CP using the prespecified program;
5. perform prespecified QC;
6. determine whether:

[
max(CP_L,CP_H)ge70%.
]

The unblinded statistician/group should not otherwise participate in ongoing blinded trial conduct.

### Designated sponsor recipient

A designated sponsor representative who is separated from direct study conduct should receive only the operational conclusion needed to implement the adaptation:

[
oxed{	ext{Continue enrollment / Stop enrollment for futility}}
]

The routine blinded study team should not receive:

- placebo event rate;
- low-dose event rate;
- high-dose event rate;
- dose-specific CP values;
- which AK135 dose generated the larger CP;
- treatment-specific safety summaries from the efficacy IA unless separately required for safety governance.

## 5. Is a full independent DMC required?

A full DMC is one acceptable implementation, and if an independent safety-monitoring committee is already planned for the study, it is operationally clean to use that committee for the Stage 1 review.

However, the current efficacy adaptation is fully algorithmic and exploratory. From a statistical-operational perspective, the minimum necessary structure could instead be:

[
oxed{
	ext{Independent unblinded statistician}
ightarrow
	ext{designated firewalled sponsor representative}
ightarrow
	ext{binary operational instruction}
}
]

provided:

- the rule is completely prespecified;
- there is no discretionary reinterpretation of the efficacy result;
- safety governance is handled separately and adequately;
- the protocol/SAP/IA charter specifies data access, confidentiality, QC, and communication procedures.

Whether local regulatory/organizational policy requires a formal IDMC is a governance question rather than a mathematical requirement of the CP rule itself.

## 6. What should be communicated after Stage 1?

### If Go

The blinded operational team should be told only that the prespecified continuation criterion was met and enrollment/treatment should continue according to the unchanged protocol.

Because both AK135 doses continue, there is no operational need to reveal:

- which dose performed better;
- whether one or both doses crossed 70%;
- the numerical CP;
- observed arm-specific event counts.

This is a major advantage of the current project-level-only rule.

### If No-Go

The blinded operational team should be told that the prespecified futility criterion was met and the trial should implement the protocol-specified early-termination procedure.

Detailed comparative interim results should remain restricted until the appropriate unblinding point, except where information is required for participant safety or formal sponsor decision-making.

## 7. Recommended documentation

The following should be prespecified before the Stage 1 database snapshot:

- Stage 1 cohort definition;
- analysis-ready rules;
- handling of indeterminate endpoints;
- CP formula and software/program version;
- 70% project-level cutoff;
- data-cleaning requirements;
- roles permitted access to treatment codes;
- independent-analysis QC procedure;
- exact contents of the communication to the sponsor;
- operational actions following Go and No-Go;
- treatment of participants already randomized when the Stage 1 decision is issued.

An Interim Analysis Charter or equivalent controlled document is the natural place for the firewall and communication details.

## 8. Working recommendation

For the current study, the preferred low-complexity model is:

[
oxed{
egin{aligned}
&	ext{Sites / participants / operational sponsor team remain blinded}\
&downarrow\
&	ext{Independent unblinded statistician computes exact prespecified CP}\
&downarrow\
&	ext{Firewalled sponsor recipient receives only Go/No-Go instruction}\
&downarrow\
&	ext{Both AK135 doses continue if Go}
end{aligned}}
]

If an independent DMC is required or already planned for safety oversight, the same statistical output can instead be routed through the DMC without changing the statistical design.

## 9. Next unresolved operational question

The remaining issue directly linked to governance is what happens to participants already randomized or already receiving treatment when a binding Stage 1 No-Go decision is issued.

This should distinguish:

- participants screened but not randomized;
- participants randomized but not yet dosed;
- participants already receiving AK135/placebo;
- pipeline/overrun participants randomized after the first 54;
- continued endpoint and safety follow-up after early project termination.
