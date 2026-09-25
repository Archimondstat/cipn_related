# Single-boundary Stage 1 CP calibration: 65%, 70%, 75%

**Version:** 0.8  
**Date:** 25 September 2026  
**Status:** Working exact OC calibration.

## 1. Simplified Stage 1 rule

The prior lower-boundary / gray-zone framework is removed.

For the two AK135 doses define:

[
M=max(CP_L,CP_H).
]

A single candidate CP threshold (c) is used:

[
oxed{
egin{cases}
Mge c & 	ext{Go to Stage 2}\
M<c & 	ext{No-Go for insufficient efficacy}
end{cases}
}
]

Candidate thresholds:

[
c=65%,70%,75%.
]

Candidate information fractions:

[
35%,40%,45%.
]

Maximum sample-size assumptions:

[
N=44,48,52	ext{ per arm}.
]

The CP definition remains based on future event rates (45%) for placebo and (30%) for treatment and a final promising threshold of an observed risk difference of at least 10%.

## 2. Exact operating characteristics

The following table gives the probability that at least one dose reaches the Stage 1 CP threshold.

| N/arm | IA | n1/arm | CP | Min event difference for individual Go | Stage 1 observed effect | P(Go|0%) | P(Go|5%) | P(Go|10%) | P(Go|15%) | P(Go|20%) |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|44|35%|15|65%|2|13.3%|43.1%|54.9%|66.4%|76.7%|85.3%|
|44|35%|15|70%|3|20.0%|28.3%|38.9%|50.4%|62.2%|73.1%|
|44|35%|15|75%|3|20.0%|28.3%|38.9%|50.4%|62.2%|73.1%|
|44|40%|18|65%|2|11.1%|45.1%|58.1%|70.4%|80.9%|89.0%|
|44|40%|18|70%|3|16.7%|31.3%|43.4%|56.4%|68.8%|79.8%|
|44|40%|18|75%|3|16.7%|31.3%|43.4%|56.4%|68.8%|79.8%|
|44|45%|20|65%|3|15.0%|33.0%|46.0%|59.7%|72.5%|83.1%|
|44|45%|20|70%|3|15.0%|33.0%|46.0%|59.7%|72.5%|83.1%|
|44|45%|20|75%|4|20.0%|21.6%|32.6%|45.6%|59.2%|72.1%|
|48|35%|17|65%|2|11.8%|44.5%|57.1%|69.2%|79.7%|87.9%|
|48|35%|17|70%|2|11.8%|44.5%|57.1%|69.2%|79.7%|87.9%|
|48|35%|17|75%|3|17.6%|30.4%|42.0%|54.5%|66.8%|77.8%|
|48|40%|19|65%|2|10.5%|45.7%|59.0%|71.6%|82.1%|90.0%|
|48|40%|19|70%|3|15.8%|32.2%|44.8%|58.1%|70.7%|81.5%|
|48|40%|19|75%|3|15.8%|32.2%|44.8%|58.1%|70.7%|81.5%|
|48|45%|22|65%|2|9.1%|47.2%|61.5%|74.6%|85.1%|92.4%|
|48|45%|22|70%|3|13.6%|34.5%|48.3%|62.6%|75.5%|85.9%|
|48|45%|22|75%|3|13.6%|34.5%|48.3%|62.6%|75.5%|85.9%|
|52|35%|18|65%|2|11.1%|45.1%|58.1%|70.4%|80.9%|89.0%|
|52|35%|18|70%|3|16.7%|31.3%|43.4%|56.4%|68.8%|79.8%|
|52|35%|18|75%|4|22.2%|19.7%|29.7%|41.5%|54.3%|67.0%|
|52|40%|21|65%|3|14.3%|33.8%|47.2%|61.2%|74.1%|84.6%|
|52|40%|21|70%|3|14.3%|33.8%|47.2%|61.2%|74.1%|84.6%|
|52|40%|21|75%|4|19.0%|22.5%|34.0%|47.5%|61.4%|74.4%|
|52|45%|23|65%|3|13.0%|35.1%|49.4%|63.9%|76.9%|87.1%|
|52|45%|23|70%|4|17.4%|24.1%|36.6%|51.0%|65.5%|78.3%|
|52|45%|23|75%|4|17.4%|24.1%|36.6%|51.0%|65.5%|78.3%|

## 3. Main finding: 65%, 70%, and 75% frequently collapse to the same rule

Because Stage 1 event counts are discrete, a 5 percentage-point change in nominal CP threshold often does not change the actual decision rule.

Examples:

- N=44, IA=35%: 70% and 75% both require an individual event-count difference of at least 3.
- N=48, IA=35%: 65% and 70% both require a difference of at least 2.
- N=44, IA=45%: 65% and 70% both require a difference of at least 3.
- N=52, IA=40%: 65% and 70% both require a difference of at least 3.
- N=52, IA=45%: 70% and 75% both require a difference of at least 4.

Therefore the nominal CP percentage should not be interpreted without its attainable event-count rule.

## 4. Initial interpretation

A useful target-effect preservation criterion may be to examine whether:

[
P(GomidDelta=15%)
]

remains near or above approximately 80%.

Under that lens, several 65% rules remain relatively permissive, while many 70%-75% rules reduce target-effect Go probability to the 60%-70% range.

No final boundary is selected in this note. The purpose is to identify which nominal CP thresholds correspond to materially distinct event-count rules and operating characteristics.
