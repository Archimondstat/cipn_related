# CP Engine Cross-Validation Cases v1.0

Date: 2026-09-21

These fixed values are intended for regression testing and R/SAS cross-validation.

The values were independently recomputed from the exact binomial formulas documented in:

`docs/cp_futility_derivation_v1_0.md`

The primary implementation files are:

- `simulation/cp_futility_engine.R`
- `simulation/cp_futility_engine.sas`

## Key checks

For (N=44), nominal Stage 1 (n_1=22), design-alternative future assumptions (q_P=0.45,q_T=0.30), and working final success criterion (widehat{Delta}_{final}ge0.10):

- (D=0): individual CP = 0.3549137605; joint CP = 0.4999095300.
- (D=2), corresponding to observed treatment effect (2/22=9.09%): individual CP = 0.6019411641; joint CP = 0.7554491695.
- (D=-1), corresponding to observed treatment effect (-1/22=-4.55%): individual CP = 0.2451685272; joint CP = 0.3648833940.

For the 0% displayed reference effect at (n_1=22), the exact probability that both active doses fall at or below the reference region is:

- true effect 0%: 0.3965002713;
- true effect 5%: 0.2645703173;
- true effect 15%: 0.0824218199.

The unequal-n checks confirm that the operational engine does not rely on equal mature interim sample sizes.
