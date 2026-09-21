/*=================================================================
  CIPN randomized Phase II
  Conditional-power engine and calibration utilities
  Version 1.1
  Date: 2026-09-22

  Endpoint:
    Y=1 if CTCAE grade >=2 CIPN (unfavorable event)

  Unified treatment-effect definition:
    Delta = p_placebo - p_treatment
    Positive Delta favors treatment.

  Current CRC design assumptions:
    p_placebo = 0.45
    p_treatment = 0.30
    target treatment effect = 0.15
    weak-effect boundary    = 0.05
    promising threshold     = 0.10

  Phase II efficacy classification (program level):
    max observed effect < 0.05          : No-Go leaning
    0.05 <= max observed effect < 0.10  : Consider
    max observed effect >= 0.10         : Go leaning

  IMPORTANT:
    Conditional power is NON-BINDING decision support.
    Reference treatment-effect values below are calibration values,
    not automatic stopping boundaries.

  This program uses Base SAS DATA step functions only.
  PROC IML is not required.
=================================================================*/


/*-----------------------------------------------------------------
  1. Exact individual CP using ACTUAL interim sample sizes

  Final Phase II promising event:
      (xp + YP)/NP - (xt + YT)/NT >= delta_go

  delta_go=0.10 is retained as the macro parameter name for backward
  compatibility; it represents the prespecified promising threshold.

  Future assumptions:
      YP ~ Bin(NP-np, qP)
      YT ~ Bin(NT-nt, qT)

  Output:
      one-row data set &out with variable CP
-----------------------------------------------------------------*/

%macro cp_individual_actual(
    xp=,
    np=,
    xt=,
    nt=,
    NP=,
    NT=,
    delta_go=0.10,
    qP=0.45,
    qT=0.30,
    out=cp_individual_out
  );

  data &out;
    length CP 8;
    mP = &NP - &np;
    mT = &NT - &nt;

    CP = 0;

    do yP = 0 to mP;

      p_yP = pdf(
        'BINOMIAL',
        yP,
        &qP,
        mP
      );

      max_yT = floor(
        &NT *
        ((&xp + yP) / &NP - &delta_go)
        - &xt
        + 1E-12
      );

      if max_yT < 0 then
        p_treatment_success = 0;
      else if max_yT >= mT then
        p_treatment_success = 1;
      else
        p_treatment_success = cdf(
          'BINOMIAL',
          max_yT,
          &qT,
          mT
        );

      CP + p_yP * p_treatment_success;
    end;

    keep CP;
  run;

%mend;


/*-----------------------------------------------------------------
  2. Exact joint CP for Low + High sharing one placebo arm

  Joint CP:
      P(at least one active dose reaches the final promising criterion
        | actual interim data, future assumptions)

  Given future placebo count YP, future Low and High counts are
  conditionally independent.
-----------------------------------------------------------------*/

%macro cp_joint_actual(
    xp=,
    np=,
    xL=,
    nL=,
    xH=,
    nH=,
    NP=,
    NL=,
    NH=,
    delta_go=0.10,
    qP=0.45,
    qL=0.30,
    qH=0.30,
    out=cp_joint_out
  );

  data &out;
    length Joint_CP 8;

    mP = &NP - &np;
    mL = &NL - &nL;
    mH = &NH - &nH;

    Joint_CP = 0;

    do yP = 0 to mP;

      p_yP = pdf(
        'BINOMIAL',
        yP,
        &qP,
        mP
      );

      max_yL = floor(
        &NL *
        ((&xp + yP) / &NP - &delta_go)
        - &xL
        + 1E-12
      );

      max_yH = floor(
        &NH *
        ((&xp + yP) / &NP - &delta_go)
        - &xH
        + 1E-12
      );

      if max_yL < 0 then pL_success = 0;
      else if max_yL >= mL then pL_success = 1;
      else pL_success = cdf(
        'BINOMIAL',
        max_yL,
        &qL,
        mL
      );

      if max_yH < 0 then pH_success = 0;
      else if max_yH >= mH then pH_success = 1;
      else pH_success = cdf(
        'BINOMIAL',
        max_yH,
        &qH,
        mH
      );

      p_any_success =
        1 -
        (1 - pL_success) *
        (1 - pH_success);

      Joint_CP + p_yP * p_any_success;
    end;

    keep Joint_CP;
  run;

%mend;


/*-----------------------------------------------------------------
  3. Build an exact CP lookup table for efficient simulation

  This supports unequal mature n and unequal final N.
-----------------------------------------------------------------*/

%macro build_cp_lookup(
    nP=,
    nT=,
    NP=,
    NT=,
    delta_go=0.10,
    qP=0.45,
    qT=0.30,
    out=cp_lookup
  );

  data &out;
    length xp xt 8 CP 8;

    mP = &NP - &nP;
    mT = &NT - &nT;

    do xp = 0 to &nP;
      do xt = 0 to &nT;

        CP = 0;

        do yP = 0 to mP;

          p_yP = pdf(
            'BINOMIAL',
            yP,
            &qP,
            mP
          );

          max_yT = floor(
            &NT *
            ((xp + yP) / &NP - &delta_go)
            - xt
            + 1E-12
          );

          if max_yT < 0 then
            p_treatment_success = 0;
          else if max_yT >= mT then
            p_treatment_success = 1;
          else
            p_treatment_success = cdf(
              'BINOMIAL',
              max_yT,
              &qT,
              mT
            );

          CP + p_yP * p_treatment_success;
        end;

        output;
      end;
    end;

    keep xp xt CP;
  run;

%mend;


/*-----------------------------------------------------------------
  4. Monte Carlo simulation of interim observed effects and CP

  This macro DOES NOT impose an automatic Go/No-Go rule.

  It returns:
    observed Low/High treatment effects;
    Low/High individual CP;
    indicator that BOTH observed treatment effects are at or below
    a displayed reference value.

  Separate lookup tables are built for Low and High so unequal
  mature sample sizes are supported.
-----------------------------------------------------------------*/

%macro simulate_interim_cp(
    nsim=100000,
    seed=20260921,
    pP_true=0.45,
    pL_true=0.30,
    pH_true=0.30,
    nP=22,
    nL=22,
    nH=22,
    NP=44,
    NL=44,
    NH=44,
    delta_go=0.10,
    qP=0.45,
    qL=0.30,
    qH=0.30,
    reference_effect=0,
    out=sim_cp
  );

  %build_cp_lookup(
    nP=&nP,
    nT=&nL,
    NP=&NP,
    NT=&NL,
    delta_go=&delta_go,
    qP=&qP,
    qT=&qL,
    out=_lookup_L
  );

  %build_cp_lookup(
    nP=&nP,
    nT=&nH,
    NP=&NP,
    NT=&NH,
    delta_go=&delta_go,
    qP=&qP,
    qT=&qH,
    out=_lookup_H
  );

  data _stage1;
    call streaminit(&seed);

    do sim = 1 to &nsim;

      xp = rand(
        'BINOMIAL',
        &pP_true,
        &nP
      );

      xL = rand(
        'BINOMIAL',
        &pL_true,
        &nL
      );

      xH = rand(
        'BINOMIAL',
        &pH_true,
        &nH
      );

      effect_L =
        xp / &nP -
        xL / &nL;

      effect_H =
        xp / &nP -
        xH / &nH;

      both_below_reference =
        (effect_L <= &reference_effect) and
        (effect_H <= &reference_effect);

      output;
    end;
  run;

  proc sql;
    create table &out as
    select
      a.*,
      b.CP as cpL,
      c.CP as cpH
    from _stage1 as a

    left join _lookup_L as b
      on a.xp = b.xp
     and a.xL = b.xt

    left join _lookup_H as c
      on a.xp = c.xp
     and a.xH = c.xt

    order by sim;
  quit;

%mend;


/*-----------------------------------------------------------------
  5. Exact probability that BOTH active doses fall at or below
     a displayed reference treatment effect

  Equal nominal n is used only for the design-calibration table.

  D = xP - xT

  Reference region:
      xP - xL <= D
      xP - xH <= D

  This probability is NOT automatically P(stop).
-----------------------------------------------------------------*/

%macro prob_both_reference_equal_n(
    D=,
    n1=,
    pP_true=,
    pL_true=,
    pH_true=,
    out=prob_reference_out
  );

  data &out;
    length Probability 8;
    Probability = 0;

    do xP = 0 to &n1;

      p_xP = pdf(
        'BINOMIAL',
        xP,
        &pP_true,
        &n1
      );

      min_xT = xP - (&D);

      if min_xT <= 0 then do;
        pL_region = 1;
        pH_region = 1;
      end;
      else if min_xT > &n1 then do;
        pL_region = 0;
        pH_region = 0;
      end;
      else do;

        pL_region =
          1 - cdf(
            'BINOMIAL',
            min_xT - 1,
            &pL_true,
            &n1
          );

        pH_region =
          1 - cdf(
            'BINOMIAL',
            min_xT - 1,
            &pH_true,
            &n1
          );
      end;

      Probability +
        p_xP *
        pL_region *
        pH_region;
    end;

    keep Probability;
  run;

%mend;




/*-----------------------------------------------------------------
  6. Exact final Phase II efficacy-classification probabilities

  Program-level efficacy classification:

      delta_max = max(delta_L, delta_H)

      delta_max < weak_effect_boundary
          -> No-Go leaning

      weak_effect_boundary <= delta_max < promising_threshold
          -> Consider

      delta_max >= promising_threshold
          -> Go leaning

  This is an efficacy classification, not an automatic development
  decision.

  IMPORTANT:
  Because the Stage 1 review is non-binding and no mechanical interim
  stop rule is specified, these FINAL probabilities depend on final N
  and true event rates, but not on the Stage 1 information fraction.
-----------------------------------------------------------------*/

%macro final_classification_oc_equal_n(
    N=,
    pP_true=0.45,
    pL_true=0.30,
    pH_true=0.30,
    weak_effect_boundary=0.05,
    promising_threshold=0.10,
    out=final_classification_oc
  );

  data &out;
    length
      P_NoGo_leaning
      P_Consider
      P_Go_leaning 8;

    P_NoGo_leaning = 0;
    P_Consider = 0;
    P_Go_leaning = 0;

    do xP = 0 to &N;

      p_xP = pdf(
        'BINOMIAL',
        xP,
        &pP_true,
        &N
      );

      do xL = 0 to &N;

        p_xL = pdf(
          'BINOMIAL',
          xL,
          &pL_true,
          &N
        );

        delta_L =
          (xP - xL) / &N;

        do xH = 0 to &N;

          p_xH = pdf(
            'BINOMIAL',
            xH,
            &pH_true,
            &N
          );

          delta_H =
            (xP - xH) / &N;

          delta_max =
            max(
              delta_L,
              delta_H
            );

          pr =
            p_xP *
            p_xL *
            p_xH;

          if delta_max <
             &weak_effect_boundary
          then
            P_NoGo_leaning + pr;

          else if delta_max <
                  &promising_threshold
          then
            P_Consider + pr;

          else
            P_Go_leaning + pr;

        end;
      end;
    end;

    N_per_arm = &N;
    pP_true = &pP_true;
    pL_true = &pL_true;
    pH_true = &pH_true;

    true_effect_low =
      pP_true - pL_true;

    true_effect_high =
      pP_true - pH_true;

    keep
      N_per_arm
      pP_true
      pL_true
      pH_true
      true_effect_low
      true_effect_high
      P_NoGo_leaning
      P_Consider
      P_Go_leaning;
  run;

%mend;


/*-----------------------------------------------------------------
  7. Example: actual unequal mature interim sample sizes
-----------------------------------------------------------------*/


/*
%cp_individual_actual(
  xp=10,
  np=23,
  xt=8,
  nt=21,
  NP=44,
  NT=44,
  delta_go=0.10,
  qP=0.45,
  qT=0.30,
  out=example_cp
);

proc print data=example_cp noobs;
run;
*/


/*-----------------------------------------------------------------
  8. Example Monte Carlo validation
-----------------------------------------------------------------*/

/*
%simulate_interim_cp(
  nsim=100000,
  pP_true=0.45,
  pL_true=0.30,
  pH_true=0.30,
  nP=22,
  nL=22,
  nH=22,
  NP=44,
  NL=44,
  NH=44,
  delta_go=0.10,
  qP=0.45,
  qL=0.30,
  qH=0.30,
  reference_effect=0,
  out=sim_target
);

proc means data=sim_target mean std min p25 median p75 max;
  var effect_L effect_H cpL cpH both_below_reference;
run;
*/


/*-----------------------------------------------------------------
  9. Example exact final efficacy-classification OC
-----------------------------------------------------------------*/

/*
%final_classification_oc_equal_n(
  N=44,
  pP_true=0.45,
  pL_true=0.30,
  pH_true=0.30,
  weak_effect_boundary=0.05,
  promising_threshold=0.10,
  out=final_oc_N44_target
);

proc print data=final_oc_N44_target noobs;
run;
*/
