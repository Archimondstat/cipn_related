# Stage 1 No-Go: operational handling of ongoing and pipeline participants

**Version:** 2.2  
**Date:** 25 September 2026  
**Status:** Working operational wording based on the current project-level binding futility concept.

## 1. General principle

Stage 1 is a binding project-level futility assessment.

If:

[
max(CP_L,CP_H)<70%,
]

the Stage 1 decision is **Project No-Go**.

Once the No-Go decision becomes effective:

[
oxed{	ext{new randomization and new initiation of study treatment stop}}
]

The futility decision applies to the AK135/placebo study-treatment component and does not determine subsequent standard-of-care mFOLFOX6 management.

## 2. Participant handling at the time of No-Go

### 2.1 Screened but not randomized

Participants who have entered screening but have not yet been randomized will not be randomized after the No-Go decision becomes effective.

Their subsequent anti-cancer management will be determined according to routine clinical practice and the applicable study close-out procedures.

### 2.2 Randomized but not yet dosed

Participants who have been randomized but have not received the first dose of AK135/placebo at the time the No-Go decision becomes effective will not initiate study treatment.

These participants remain part of the randomized study population and should be accounted for in disposition and relevant analyses according to the prespecified analysis-set definitions.

### 2.3 Randomized and already receiving AK135/placebo

Participants who have already initiated AK135/placebo will discontinue study treatment after the No-Go decision becomes effective.

Discontinuation of AK135/placebo because of the project-level futility decision:

- is not itself a CTCAE grade >=2 CIPN event;
- does not terminate standard-of-care mFOLFOX6 treatment;
- does not by itself terminate study follow-up.

mFOLFOX6 treatment may continue or be modified according to the treating investigator's clinical judgment and standard clinical management.

### 2.4 Participants already in post-treatment follow-up

Participants who have already discontinued study treatment or entered follow-up will continue protocol-required safety and CIPN assessments whenever feasible, subject to the usual follow-up stopping conditions.

## 3. Endpoint follow-up after No-Go

The project-level No-Go decision should not automatically terminate endpoint collection for participants already randomized.

For participants whose primary CIPN endpoint has not yet been determined, follow-up should continue whenever feasible according to the prespecified primary-endpoint rules.

Thus:

[
oxed{	ext{Stop study treatment}
eq	ext{Stop endpoint follow-up}}
]

Early discontinuation of AK135/placebo after a No-Go decision is handled consistently with the treatment-policy strategy already defined for study-treatment discontinuation.

## 4. Pipeline / overrun participants

Participants randomized after the first 54 Stage 1 participants but before the Stage 1 decision becomes effective are considered **pipeline/overrun participants**.

They:

- do not replace any member of the first-54 Stage 1 cohort;
- do not contribute to the Stage 1 CP calculation;
- do contribute to the overall safety and disposition summaries;
- may contribute to descriptive efficacy summaries if their endpoint data become available.

Their data do not retrospectively alter the prespecified Stage 1 Go/No-Go decision.

## 5. Consequence for the planned final efficacy classification

The planned final efficacy classification:

[
Delta_{max}<5%:	ext{ No-Go leaning},
]

[
5%leDelta_{max}<10%:	ext{ Consider},
]

[
Delta_{max}ge10%:	ext{ Go leaning},
]

is intended for the scenario in which the trial passes Stage 1 and proceeds toward the planned final sample size of 50 participants per arm.

If the trial terminates early for Stage 1 futility, the subsequently available data from already randomized participants should be summarized descriptively and should not be used to retrospectively overturn the binding Stage 1 No-Go decision.

## 6. Suggested protocol/SAP wording

> 当第1阶段期中分析结果未达到预设的项目继续标准，即两剂量组与安慰剂组比较的条件把握度均低于70%时，研究将因疗效无效性（futility）作出项目层面的No-Go决定。No-Go决定生效后，将停止新的受试者随机及新的试验用药启动。对于已随机但尚未接受试验用药的受试者，不再开始AK135或安慰剂治疗；对于已开始接受AK135或安慰剂治疗的受试者，将停止试验用药。mFOLFOX6后续治疗由研究者根据受试者临床情况及常规临床实践决定。
>
> 项目No-Go及由此导致的试验用药停止本身不判定为CTCAE >=2级CIPN事件。对于已随机受试者，在可行的情况下应继续按照方案规定完成安全性及CIPN相关随访，以获得尽可能完整的终点信息。
>
> 第1阶段分析仅基于预先确定的前54名随机受试者。第1阶段队列之后、期中分析决定生效之前已随机的受试者不替代第1阶段队列成员，也不纳入第1阶段条件把握度计算；其数据将在研究总结中用于安全性、受试者处置及适当的描述性疗效分析。
>
> 若研究因第1阶段No-Go决定提前终止，则后续获得的数据不用于追溯性改变已按预设规则作出的第1阶段No-Go决定。

## 7. Items to confirm later

Detailed implementation still requires alignment with protocol operations on:

1. the exact effective time of the No-Go decision;
2. handling of participants randomized shortly before the decision but with study treatment already dispensed;
3. required minimum safety follow-up after discontinuation of AK135/placebo;
4. site communication and close-out procedures;
5. whether any treatment may continue temporarily for logistical/safety reasons before formal discontinuation.

These are implementation details and do not change the current statistical principle.
