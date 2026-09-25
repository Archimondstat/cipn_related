/*=================================================================
  AK135 CIPN randomized Phase II - Cohort 1
  Current conditional-power engine
  Version 2.0
  Date: 2026-09-25

  CURRENT WORKING DESIGN
    Final N = 50 per arm; total N = 150
    Stage 1 cohort = first 54 randomized participants overall
    Nominal equal Stage 1 allocation = 18/18/18
    Endpoint: CTCAE grade >=2 CIPN
    Effect: Delta = p_placebo - p_treatment

  Planning rates used inside CP:
    p_placebo_design = 0.45
    p_treatment_design = 0.30
    implied design-alternative RD = 0.15

  The 0.15 RD is implied by the central planning rates; it is not
  assumed to be an invariant AK135 effect.

  Stage 1 binding rule:
    M = max(CP_L, CP_H)
    M >= 0.70 -> Project Go
    M <  0.70 -> Project No-Go

  No dose dropping after Project Go.

  Final efficacy summaries are descriptive. No formal efficacy
  hypothesis test or multiplicity-adjusted P-value is required.

  Base SAS only; PROC IML is not required.
=================================================================*/


/*-----------------------------------------------------------------
  1. Exact individual CP with complete already-randomized outcomes
-----------------------------------------------------------------*/

%macro cp_individual_actual(
    xp=,
    np=,
    xt=,
    nt=,
    NP=50,
    NT=50,
    delta_go=0.10,
    qP=0.45,
    qT=0.30,
    out=cp_individual_out
  );

  data &out;
    length CP 8;
    mP = &NP - &np;
    mT = &NT - &nt;

    if mP < 0 or mT < 0 then do;
      put "ERROR: final planned N must be >= interim n.";
      stop;
    end;

    CP = 0;

    do yP = 0 to mP;
      p_yP = pdf('BINOMIAL', yP, &qP, mP);

      max_yT = floor(
        &NT * ((&xp + yP) / &NP - &delta_go)
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
  2. Available-case + consumed-slot CP

  R = randomized / final-N slots consumed
  E = endpoint-evaluable participants
  U = R - E = permanently indeterminate
  F = N - R = future recruitment capacity

  Final projected available-case denominator = E + F = N - U.
-----------------------------------------------------------------*/

%macro cp_individual_consumed_slot(
    xp=,
    EP=,
    RP=,
    xt=,
    ET=,
    RT=,
    NP=50,
    NT=50,
    delta_go=0.10,
    qP=0.45,
    qT=0.30,
    out=cp_consumed_slot_out
  );

  data &out;
    length CP 8;

    if &EP > &RP or &ET > &RT then do;
      put "ERROR: evaluable count cannot exceed randomized count.";
      stop;
    end;

    if &RP > &NP or &RT > &NT then do;
      put "ERROR: randomized count cannot exceed final planned N.";
      stop;
    end;

    FP = &NP - &RP;
    FT = &NT - &RT;

    final_eval_P = &EP + FP;
    final_eval_T = &ET + FT;

    CP = 0;

    do yP = 0 to FP;
      p_yP = pdf('BINOMIAL', yP, &qP, FP);

      max_yT = floor(
        final_eval_T *
          ((&xp + yP) / final_eval_P - &delta_go)
        - &xt
        + 1E-12
      );

      if max_yT < 0 then
        p_treatment_success = 0;
      else if max_yT >= FT then
        p_treatment_success = 1;
      else
        p_treatment_success = cdf(
          'BINOMIAL',
          max_yT,
          &qT,
          FT
        );

      CP + p_yP * p_treatment_success;
    end;

    U_P = &RP - &EP;
    U_T = &RT - &ET;

    keep
      CP
      FP FT
      final_eval_P final_eval_T
      U_P U_T;
  run;

%mend;


/*-----------------------------------------------------------------
  3. Current Stage 1 project-level rule

  M = max(CP_L, CP_H)
  M >= cp_cutoff -> Go
  otherwise      -> No-Go
-----------------------------------------------------------------*/

%macro stage1_project_decision(
    xp=,
    EP=,
    RP=,
    xL=,
    EL=,
    RL=,
    xH=,
    EH=,
    RH=,
    NP=50,
    NL=50,
    NH=50,
    promising_threshold=0.10,
    qP=0.45,
    qL=0.30,
    qH=0.30,
    cp_cutoff=0.70,
    out=stage1_decision
  );

  %cp_individual_consumed_slot(
    xp=&xp,
    EP=&EP,
    RP=&RP,
    xt=&xL,
    ET=&EL,
    RT=&RL,
    NP=&NP,
    NT=&NL,
    delta_go=&promising_threshold,
    qP=&qP,
    qT=&qL,
    out=_cp_low
  );

  %cp_individual_consumed_slot(
    xp=&xp,
    EP=&EP,
    RP=&RP,
    xt=&xH,
    ET=&EH,
    RT=&RH,
    NP=&NP,
    NT=&NH,
    delta_go=&promising_threshold,
    qP=&qP,
    qT=&qH,
    out=_cp_high
  );

  data &out;
    merge
      _cp_low(rename=(CP=CP_L))
      _cp_high(rename=(CP=CP_H));

    M = max(CP_L, CP_H);
    CP_cutoff = &cp_cutoff;

    length Project_Decision $5;
    if M >= CP_cutoff then
      Project_Decision = "Go";
    else
      Project_Decision = "No-Go";

    keep CP_L CP_H M CP_cutoff Project_Decision;
  run;

%mend;


/*-----------------------------------------------------------------
  4. Exact joint CP utility

  Retained for historical/sensitivity work only.
  It is NOT the current Stage 1 project statistic.
-----------------------------------------------------------------*/

%macro cp_joint_actual(
    xp=,
    np=,
    xL=,
    nL=,
    xH=,
    nH=,
    NP=50,
    NL=50,
    NH=50,
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
      p_yP = pdf('BINOMIAL', yP, &qP, mP);

      max_yL = floor(
        &NL * ((&xp + yP) / &NP - &delta_go)
        - &xL + 1E-12
      );

      max_yH = floor(
        &NH * ((&xp + yP) / &NP - &delta_go)
        - &xH + 1E-12
      );

      if max_yL < 0 then pL_success = 0;
      else if max_yL >= mL then pL_success = 1;
      else pL_success = cdf('BINOMIAL', max_yL, &qL, mL);

      if max_yH < 0 then pH_success = 0;
      else if max_yH >= mH then pH_success = 1;
      else pH_success = cdf('BINOMIAL', max_yH, &qH, mH);

      p_any_success =
        1 - (1 - pL_success) * (1 - pH_success);

      Joint_CP + p_yP * p_any_success;
    end;

    keep Joint_CP;
  run;

%mend;


/*-----------------------------------------------------------------
  5. CP lookup for complete-case Stage 1 simulation
-----------------------------------------------------------------*/

%macro build_cp_lookup(
    nP=,
    nT=,
    NP=50,
    NT=50,
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
          p_yP = pdf('BINOMIAL', yP, &qP, mP);

          max_yT = floor(
            &NT * ((xp + yP) / &NP - &delta_go)
            - xt + 1E-12
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
  6. Current complete-case Stage 1 Monte Carlo utility
-----------------------------------------------------------------*/

%macro simulate_interim_cp(
    nsim=100000,
    seed=20260925,
    pP_true=0.45,
    pL_true=0.30,
    pH_true=0.30,
    nP=18,
    nL=18,
    nH=18,
    NP=50,
    NL=50,
    NH=50,
    delta_go=0.10,
    qP=0.45,
    qL=0.30,
    qH=0.30,
    cp_cutoff=0.70,
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
      xp = rand('BINOMIAL', &pP_true, &nP);
      xL = rand('BINOMIAL', &pL_true, &nL);
      xH = rand('BINOMIAL', &pH_true, &nH);

      effect_L = xp / &nP - xL / &nL;
      effect_H = xp / &nP - xH / &nH;

      output;
    end;
  run;

  proc sql;
    create table &out as
    select
      a.*,
      b.CP as CP_L,
      c.CP as CP_H,
      max(b.CP,c.CP) as M,
      calculated M >= &cp_cutoff as Project_Go
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
  7. Exact final descriptive-classification operating characteristics

  This is a design-OC utility, not a formal hypothesis test.
-----------------------------------------------------------------*/

%macro final_classification_oc_equal_n(
    N=50,
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
      p_xP = pdf('BINOMIAL', xP, &pP_true, &N);

      do xL = 0 to &N;
        p_xL = pdf('BINOMIAL', xL, &pL_true, &N);
        delta_L = (xP - xL) / &N;

        do xH = 0 to &N;
          p_xH = pdf('BINOMIAL', xH, &pH_true, &N);
          delta_H = (xP - xH) / &N;
          delta_max = max(delta_L, delta_H);

          pr = p_xP * p_xL * p_xH;

          if delta_max < &weak_effect_boundary then
            P_NoGo_leaning + pr;
          else if delta_max < &promising_threshold then
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
    true_effect_low = pP_true - pL_true;
    true_effect_high = pP_true - pH_true;

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
  8. Current examples
-----------------------------------------------------------------*/

/*
%stage1_project_decision(
  xp=8,
  EP=18,
  RP=18,
  xL=6,
  EL=18,
  RL=18,
  xH=7,
  EH=18,
  RH=18,
  out=current_stage1_example
);

proc print data=current_stage1_example noobs;
run;


%cp_individual_consumed_slot(
  xp=7,
  EP=17,
  RP=18,
  xt=6,
  ET=18,
  RT=18,
  out=one_placebo_indeterminate
);

proc print data=one_placebo_indeterminate noobs;
run;


%final_classification_oc_equal_n(
  N=50,
  pP_true=0.45,
  pL_true=0.45,
  pH_true=0.30,
  out=current_final_oc
);

proc print data=current_final_oc noobs;
run;
*/
