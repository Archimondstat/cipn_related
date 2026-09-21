# CP Engine Cross-Validation Cases v1.1

Date: 2026-09-22

These fixed values are intended for regression testing and R/SAS cross-validation after adoption of the three-region Phase II efficacy framework.

The 10% value used in CP is now the prespecified **Phase II promising threshold**.

The fixed CRC quantities are:

- weak-effect boundary = 5%;
- promising threshold = 10%;
- target treatment effect = 15%.

The mathematical derivation is documented in:

`docs/cp_futility_derivation_v1_1.md`

Primary implementations:

- `simulation/cp_futility_engine.R`
- `simulation/cp_futility_engine.sas`

## CP regression checks

For (N=44), nominal Stage 1 (n_1=22), future assumptions (q_P=0.45,q_T=0.30), and final promising criterion:

[
widehatDelta_{final}ge0.10,
]

the expected exact values are:

- (D=0): individual CP = 0.3549137605; joint CP = 0.4999095300.
- (D=2), corresponding to (2/22=9.09%): individual CP = 0.6019411641; joint CP = 0.7554491695.
- (D=-1), corresponding to (-1/22=-4.55%): individual CP = 0.2451685272; joint CP = 0.3648833940.

For the 0% displayed reference effect at (n_1=22), the exact probability that both active doses are at or below the reference region is:

- true effect 0%: 0.3965002713;
- true effect 5%: 0.2645703173;
- true effect 15%: 0.0824218199.

The unequal-n regression checks remain unchanged and confirm that the operational engine does not rely on equal mature interim sample sizes.

## Final classification QC

The exact final-classification grid is stored in:

`simulation/results/cp_final_classification_grid_v1_1.csv`

For (N=44) and true treatment effect 15% in both active arms:

- P(No-Go leaning) = 0.0779057337;
- P(Consider) = 0.0989395304;
- P(Go leaning) = 0.8231547360.

For (N=44) and true treatment effect 0%:

- P(No-Go leaning) = 0.5623167814;
- P(Consider) = 0.1710845591;
- P(Go leaning) = 0.2665986595.

These final classification probabilities are independent of Stage 1 timing under the current non-binding framework because no deterministic early-stop rule is applied.
