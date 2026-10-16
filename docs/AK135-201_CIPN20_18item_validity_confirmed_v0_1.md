# AK135-201 CIPN20 18-item QLQ-CIPN20 sum score有效问卷与方案写法——确认稿v0.1

**日期：** 2026-10-13  
**状态：** 用户明确采用此前参考的同类研究评分规则，正式锁定**18项中至少9项有效回答**；对“是否写入Protocol”，建议只写有效性原则一条，算法和缺失衍生细则放SAP。原始Word未改。


> **2026-10-16术语修正（此处最新）：** Kieffer 2017的Methods称该指标为`mean sum score`，Conclusion推荐名为**18-item QLQ-CIPN20 sum score**；论文中的`summary score`回指的是同一指标，而非另一套计分方法。今后Protocol/SAP统一用**18-item QLQ-CIPN20 sum score（0–100分）**，历史写法`18-item summary score`仅为旧称。
>
> **设计版本提醒：** 本文件在2026-10-13写下的“仅EOT当次”判定已被后续**CP-31累计发生（观察窗口内任一次有效访视达标）**覆盖，CP-35后续缺失处理亦优先适用。当前更新**不恢复旧EOT单点规则**，不修改原始Word。

## 1. 用户最新选择及既有设计

用户本轮：“第二项我们按照之前参考的同类型研究来做，并且归档。但是我有一个问题，这个是否要写在方案上？”

用户之前已确认（CP-10）：EORTC QLQ-CIPN20使用**前18项**的18-item QLQ-CIPN20 sum score，剔除条件性item 19/20，转换0–100分（高分为CIPN症状负担重）。主要PRO结局只在**EOT访视**按 `Score_EOT - Score_baseline >= 10` 二分类判定，治疗期各次评分用于描述性折线图，分母遵循CP-07已定observed/evaluable及indeterminate规则。不能再误称AK135-101为“CIPN20 ≥10分”的来源。此轮仅补足评分的**最低有效答题数**，不重开Stage 1的CTCAE CP及主要终点计分范围。

## 2. 同类发表研究原始依据

**Kieffer JM et al. (2017)**, *Quality of Life Research* 26:2999–3010, DOI [10.1007/s11136-017-1626-1](https://doi.org/10.1007/s11136-017-1626-1)，原始论文PDF：[Amsterdam UMC](https://pure.amsterdamumc.nl/ws/portalfiles/portal/159020278/Evaluation-of-the-psychometric-properties-of-the-eortc-chemotherapy-induced-peripheral-neuropathy-questionnaire-qlq-cip.pdf)。

- 其Methods部分（刊物页3002，PDF第6页附近）明确：18项summary作为**simple additive symptom checklist**，18项原始回答求均值，按EORTC symptom scale方法线性转至0–100，**受试者至少回答50%题目才计算该次sum score**。原始行文为：“This total score was calculated only if participants answered 50% or more items.”
- 其Results、Discussion说明18项排除具有条件适用性的item 19、20；这只是Kieffer发表研究所使用的**18-item QLQ-CIPN20 sum score**及缺失计分约定，**不是EORTC Draft三分量表指南所正式规定的18项总分标准**。项目提供的`CIPN20 Summary.pdf`是Draft评分指南，主要定义维度及条件题，并未给出当前18-item QLQ-CIPN20 sum score≥50%最低题数的项目规则。

**采纳：** 原始研究18项完成≥50%对应**9/18个有效条目**；我们采用此规则，应用于基线、EOT以及治疗期间要计算18项综合评分的每个计划访视。这里仅将已发表方法用于AK135-201，不宣称Kieffer已经验证“个体恶化≥10分”的临床阈值。


### 2026-10-16：原文术语、计分与证据边界

- **原文依据：** [Kieffer 2017原始PDF](https://pure.amsterdamumc.nl/ws/portalfiles/portal/159020278/Evaluation-of-the-psychometric-properties-of-the-eortc-chemotherapy-induced-peripheral-neuropathy-questionnaire-qlq-cip.pdf)，Methods刊物p.3003（PDF第6页）称为`single, mean sum score`，规定前18项的**raw mean**线性转换到0–100分，≥50%回答才计算；Conclusion刊物p.3007（PDF第10页）使用`our summary score`并明确推荐`18-item QLQ-CIPN20 sum score`。这两种称呼在该文内指同一指标。
- **不是直接累加的原始总分：** 设`n_valid`为18项中实际有效回答数（≥9），则`RS=sum(X_valid)/n_valid`，`Score=(RS-1)/3*100`。有效15项就除以15，**不能在存在缺失时固定除以18**；减1、除3来自1–4原始取值的0–100线性转换。部分缺失条目按实际回答的均值处理，参考[Fayers et al., EORTC QLQ-C30 Scoring Manual, 3rd ed. 2001](https://www.eortc.org/app/uploads/sites/2/2018/02/SCmanual.pdf)的symptom scales规则。此为**非缺失条目均值**，不是把所有缺失单项赋固定值，也不是`raw sum`。
- **命名要求：** Protocol/SAP正式名称`18-item QLQ-CIPN20 sum score（0–100分）`，同时明确数学算法，避免`sum`与简单原始和混淆；原先`18-item summary score`只是历史名称，不新增评分指标。
- **不能外推：** Kieffer 2017不支持“个体恶化≥10分已通过MCID验证”；纵向响应性尚待评价。既有≥10规则及观察窗口应按项目其他后续确认执行，不因本次术语澄清改变。

## 3. 确认的计分/可评价原则

1. **所用条目：** CIPN20 item 1–18，不计item19（驾驶）及item20（男性性功能）。18项均为1–4等级（有效选项）。
2. **单次评分完成要求：** 有效回答数 `n_valid >= 9`，否则该访视**18-item QLQ-CIPN20 sum score = missing**。有效回答包括值1、2、3、4；无回答/无效回答/条件性题目不进入有效分母；其余问卷/EDC特殊码映射SAP具体规定。
3. **实际得分：** `RS = sum(valid item scores 1:18) / n_valid`，`CIPN18 = (RS - 1)/3*100`，范围0–100；不对缺答的个别条目机械填0/1/均值，不擅自把条件项计入分母；采用可用题目的原始均值是已确定的scoring，而非逐人对缺题做模型插补。
4. **主要PRO结局：** 基线及**实际EOT**各自须有 `>=9` 项有效回答，才能计算`Δ = CIPN18_EOT − CIPN18_BL`；**Δ≥10**为事件，**Δ<10**为非事件。无有效基线和/或无有效EOT时，PRO主要终点**indeterminate**，按CP-07/CP-10的可评价分母与缺失敏感性框架处理；不能默认为非事件，也不凭其中某项CTCAE/救治情况自动构造PRO事件。
5. **期间数据：** 对同一18项评分按相同门槛计算各计划访视及描述曲线，报告当次有效N；治疗期曾经Δ≥10不自动替代EOT定点主要终点。
6. **不改变：** CTCAE EOT二分类终点、Stage1 CTCAE驱动Conditional Power、样本量、50/臂、医学/CRF访视安排均不因本次评分门槛决定而重新选择。已确认的CIPN挽救治疗+Treatment Policy逻辑保持独立。

## 4. 是否写入方案？

**建议写入Protocol §11.5.1一句（关键规则），而非只在SAP首次定义，也不需要在§2.2终点清单和统计章节多次重复：**

> EORTC QLQ-CIPN20采用18-item QLQ-CIPN20 sum score进行评价，每次评价至少需有18个计分条目中的9项有效回答，方可计算该次评分。具体评分算法及缺失数据处理方法将在SAP中规定。

**依据：** 该门槛直接决定主要PRO事件能否判定及observed/evaluable分母，故属于Protocol应预先规定的主要终点评价原则；但均值与0–100转换、条目代码有效值、缺失题如何处理、访视映射、统计显示格式等为SAP/衍生技术细节。推荐上述最简写法，不要求把公式和样例全部放进Protocol。

若医学希望§7“CIPN20计分方法”另列同一原则，则在§7或§11.5.1选一个主位置并交叉引用，**勿反复书写或引起不同阈值**。不要把≥9/18与另一个问题“研究用药前是否已完成整份问卷”混同。

**原始Word冻结状态：** 按项目已约定的“统计审阅全部完成、医学Comment整理完成后统一修改原Word”，当前只在GitHub归档上述规则和§11.5.1插入建议。

## 5. 用户确认Protocol与SAP分工（2026-10-13）

用户在被建议“Protocol §11.5.1只写9/18有效题数门槛，详细评分算法和缺失实现留到SAP；全部完成审阅后再统一修改Word”后明确回复：“我接受你的建议。”

**CP-29最终定案（含写作分工）：**
- **Protocol §11.5.1** 保留前述一条简洁的计分有效性原则：CIPN20 18-item QLQ-CIPN20 sum score每次评价须至少9/18项有效回答方可计算；不用在终点清单或其他章节反复展开公式。
- **SAP** 详细定义有效条目1–18（排除条件题19/20）、有效值判定、非缺失条目均值及0–100转换、基线/EOT缺失与indeterminate、衍生和展示。
- 该有效性门槛关系到EOT主要PRO结局的可评价分母，不因计分缺失将病例自动作为“未恶化”；既有CTCAE Stage 1 CP不变。
- **执行状态：** 本次只将用户明确同意写入GitHub审阅资料；原始`AK135-201方案 v0.1.docx`未修改，待全方案统计审阅完成及医学Comment整理后统一修改。

