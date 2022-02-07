(**
  CheckerScript: Define a Certificate Checker and a certificate structure for
  Dandelion
**)
open realTheory realLib RealArith stringTheory polyTheory transcTheory;
open renameTheory realPolyTheory transcLangTheory sturmComputeTheory sturmTheory
     drangTheory checkerDefsTheory pointCheckerTheory mcLaurinApproxTheory
     hintTheory realPolyProofsTheory;
open preambleDandelion;

val _ = new_theory "checker";

(**
  Checks that the zero intervals encoded in the certificate actually are
  all of the zeros of derivative of the difference between the approximated
  polynomial and the transcendental function
**)
Definition numZeros_def:
  numZeros deriv1 deriv2 iv sseq =
  let numZeros =
      (variation (MAP (λp. poly p (FST iv)) (deriv1::deriv2::sseq)) -
       variation (MAP (λp. poly p (SND iv)) (deriv1::deriv2::sseq)))
  in
    if (poly deriv1 (FST iv) = 0) then
      (Invalid "Lower bound of derivative is 0", 0)
    else if (poly deriv1 (SND iv) = 0) then
      (Invalid "Upper bound of derivative is 0", 0)
    else (Valid, numZeros)
End

Definition getMaxWidth_def:
  getMaxWidth [] = 0 /\
  getMaxWidth ((u,v)::xs) = max (abs(u-v)) (getMaxWidth xs)
End

Definition getMaxAbsLb_def:
  getMaxAbsLb p [] = 0 ∧
  getMaxAbsLb p ((u,v)::xs) = max (abs (poly p u)) (getMaxAbsLb p xs)
End

Definition validBounds_def:
  validBounds iv [] = T ∧
  validBounds (iv:real#real) (zeroIv::zeros) =
    (FST iv ≤ FST zeroIv ∧ SND zeroIv ≤ SND iv ∧ validBounds iv zeros)
End

(**
  Either find a sublist of length n where P is true, or return the empty list
**)
Definition findN_def:
  findN n P l =
    let subL = FILTER P l in
      if (LENGTH subL = n) then subL else []
End

(**
  Checks that the certificate encoded error eps is an upper bound to the
  error that can be proven in HOL4.
  The provable error is computed following the assumptions of theorem
  BOUND_THEOREM_INEXACT.
  First we compute the maximum absolute value of the input interval
  and use it to get an upper bound on the maxmimum value of the derivate B.
  The error e, i.e. the width of the intervals in which the zeros can be
  found is computed using function getMaxWidth,
  and finally the upper bound ub is computed using function getMaxAbsLb.
  After computing these values, only the outer points of the interval need
  to be validated.
**)
Definition validateZerosLeqErr_def:
  validateZerosLeqErr errorp iv zeros eps numZeros =
    let mAbs = max (abs (FST iv)) (abs (SND iv));
        realZeros = (findN numZeros (λ (u,v). poly (diff errorp) u * poly (diff errorp) v ≤ 0) zeros);
        B = poly (MAP abs (diff errorp)) mAbs;
        e = getMaxWidth realZeros;
        ub = getMaxAbsLb errorp realZeros;
        globalErr = max (abs (poly errorp (FST iv)))
                        (max (abs (poly errorp (SND iv)))
                         (ub + B * e))
    in
      if ~ (validBounds iv realZeros ∧ recordered (FST iv) realZeros (SND iv)) then
          (Invalid "Zeros not correctly spaced", 0)
      else if LENGTH realZeros < numZeros then
          (Invalid "Did not find sufficient zeros", 0)
      else if globalErr ≤ eps
      then (Valid, globalErr)
      else (Invalid "Bounding error too large", 0)
End

(* Unused for new structure
(**
   Overall certificate checker combines all of the above functions into one that
   runs over the full certificate **)
Definition checker_def:
  checker (cert:certificate) approxSteps :result =
  if ~ EVEN approxSteps ∨ ~ EVEN (approxSteps DIV 2) ∨ approxSteps = 0
  then Invalid "Need even number of approximation steps"
  else case approxPoly cert.transc cert.iv cert.hints approxSteps of
    | NONE => Invalid "Could not find appropriate approximation"
    | SOME (transp, err) =>
      let errorp = transp -p cert.poly;
          deriv1 = diff errorp;
          deriv2 = diff deriv1;
      in
        case sturm_seq deriv1 deriv2 of
          NONE => Invalid "Could not compute sturm sequence"
        | SOME sseq =>
            case numZeros deriv1 deriv2 cert.iv sseq of
            | (Valid, zeros ) =>
                validateZerosLeqErr errorp cert.iv cert.zeros (cert.eps - err) zeros
            | (Invalid s, _) => Invalid s
End
*)

Theorem numZeros_sound:
  ∀ sseq deriv1 iv zeros.
    sturm_seq deriv1 (diff deriv1) = SOME sseq ∧
    numZeros deriv1 (diff deriv1) iv sseq = (Valid, n) ∧
    FST iv ≤ SND iv ⇒
    {x | FST iv ≤ x ∧ x ≤ SND iv ∧ (poly deriv1 x = &0)} HAS_SIZE n
Proof
  rpt gen_tac
  >> rewrite_tac[numZeros_def]
  >> CONV_TAC $ DEPTH_CONV let_CONV
  >> rpt (cond_cases_tac >- gs[])
  >> rpt $ pop_assum $ mp_tac o SIMP_RULE std_ss []
  >> rpt strip_tac
  >> qpat_x_assum ‘_ = (_, n)’ $ strip_assume_tac o REWRITE_RULE [PAIR_EQ]
  >> pop_assum $ once_rewrite_tac o single o GSYM
  >> imp_res_tac sturm_seq_equiv
  >> irule STURM_THEOREM >> gs[]
QED

Theorem getMaxWidth_is_max:
  ∀ l. EVERY (λ (u,v). abs (u - v) <= getMaxWidth l) l
Proof
  Induct_on ‘l’ >> rpt strip_tac >> gs[getMaxWidth_def]
  >> rename1 ‘getMaxWidth (iv1::ivs)’
  >> PairCases_on ‘iv1’ >> rename1 ‘getMaxWidth ((iv1Lo, iv1Hi)::ivs)’
  >> gs[getMaxWidth_def, max_def]
  >> cond_cases_tac >> gs[]
  >> ‘getMaxWidth ivs < abs (iv1Lo - iv1Hi)’ by real_tac
  >> irule EVERY_MONOTONIC
  >> qexists_tac ‘λ (u,v). abs (u - v) <= getMaxWidth ivs’ >> gs[]
  >> rpt strip_tac >> Cases_on ‘x’ >> gs[]
  >> real_tac
QED

Theorem getMaxAbsLb_is_max:
  ∀ (l:(real#real) list) p. EVERY (λ (u,v). abs (poly p u) ≤ getMaxAbsLb p l) l
Proof
  Induct_on ‘l’ >> rpt strip_tac >> gs[getMaxAbsLb_def]
  >> rename1 ‘getMaxAbsLb p (iv1::ivs)’
  >> PairCases_on ‘iv1’ >> rename1 ‘getMaxAbsLb p ((iv1Lo, iv1Hi)::ivs)’
  >> gs[getMaxAbsLb_def, max_def]
  >> cond_cases_tac >> gs[]
  >> ‘getMaxAbsLb p ivs < abs (poly p iv1Lo)’
    by (last_x_assum kall_tac >> real_tac)
  >> irule EVERY_MONOTONIC
  >> qexists_tac ‘λ (u,v). abs (poly p u) ≤ getMaxAbsLb p ivs’ >> gs[]
  >> rpt strip_tac >> Cases_on ‘x’ >> gs[]
  >> last_x_assum kall_tac >> real_tac
QED

Theorem validBounds_is_valid:
  ∀ zeros iv.
    validBounds iv zeros ⇒
    EVERY (λ (u,v). FST iv ≤ u ∧ v ≤ SND iv) zeros
Proof
  Induct_on ‘zeros’ >> rpt strip_tac >> gs[validBounds_def]
  >> Cases_on ‘h’ >> gs[]
QED

Theorem validateZerosLeqErr_EVERY:
  ∀ err errorp iv zeroList zeros eps.
    validateZerosLeqErr errorp iv zeroList err zeros = (Valid, eps) ⇒
    let realZeros =
        (findN zeros (λ(u,v). poly (diff errorp) u * poly (diff errorp) v ≤ 0)
         zeroList)
    in
    EVERY (λ (u,v). FST iv ≤ u ∧ v ≤ SND iv ∧
                    abs (u - v) ≤ getMaxWidth realZeros ∧
                    abs (poly errorp u) ≤ getMaxAbsLb errorp realZeros )
          realZeros
Proof
  gs[validateZerosLeqErr_def, isValid_def]
  >> rpt gen_tac >> rpt (cond_cases_tac >> gs[])
  >> disch_then kall_tac
  >> qmatch_goalsub_abbrev_tac ‘EVERY all_conds_pred realZeros’
  >> ‘all_conds_pred =
      λ x. (λ (u,v). FST iv ≤ u ∧ v ≤ SND iv) x ∧
           (λ (u,v). abs (u - v) ≤ getMaxWidth realZeros) x ∧
           (λ (u,v). abs (poly errorp u) ≤ getMaxAbsLb errorp realZeros) x’
     by (unabbrev_all_tac >> gs[FUN_EQ_THM]
         >> rpt strip_tac >> Cases_on ‘x’ >> gs[] >> metis_tac[])
  >> pop_assum $ rewrite_tac o single
  >> gs[EVERY_CONJ] >> unabbrev_all_tac
  >> gs[findN_def] >> cond_cases_tac >> gs[]
  >> qmatch_goalsub_abbrev_tac ‘_ ∧ _ ∧ EVERY _ realZeros’
  >> rpt conj_tac
  >- (
    imp_res_tac validBounds_is_valid
    >> irule EVERY_MONOTONIC
    >> qexists_tac ‘λ (u,v). FST iv ≤ u ∧ v ≤ SND iv’ >> gs[])
  >- (
    assume_tac getMaxWidth_is_max
    >> irule EVERY_MONOTONIC
    >> qexists_tac ‘λ (u,v). abs (u - v) ≤ getMaxWidth realZeros’
    >> gs[])
  >> assume_tac getMaxAbsLb_is_max
  >> irule EVERY_MONOTONIC
  >> qexists_tac ‘λ (u,v). abs (poly errorp u) ≤ getMaxAbsLb errorp realZeros’
  >> gs[]
QED

Theorem EVERY_FILTER_TRUE:
  ∀ P l.
    EVERY P (FILTER P l)
Proof
  Induct_on ‘l’ >> gs[]
  >> rpt strip_tac
  >> cond_cases_tac >> gs[]
QED

Theorem validateZerosLeqErr_sound:
  ∀ deriv errorp iv zerosList zeros err eps.
    deriv = diff errorp ∧
    {x | FST iv ≤ x ∧ x ≤ SND iv ∧ (poly deriv x = &0)} HAS_SIZE zeros ∧
    validateZerosLeqErr errorp iv zerosList err zeros = (Valid, eps) ⇒
    ∀ x.
      FST iv ≤ x ∧ x ≤ SND iv ⇒
      abs(poly errorp x) ≤ err
Proof
  rpt strip_tac
  >> ‘∀ x. FST iv ≤ x ∧ x ≤ SND iv ⇒ ((λ x. poly errorp x) diffl poly deriv x) x’
     by (rpt strip_tac >> gs[polyTheory.POLY_DIFF])
  >> imp_res_tac validateZerosLeqErr_EVERY
  >> qpat_x_assum ‘validateZerosLeqErr _ _ _ _ _ = _’ mp_tac
  >> gs[validateZerosLeqErr_def, isValid_def]
  >> rpt (cond_cases_tac >> gs[])
  >> disch_then kall_tac
  >> pop_assum mp_tac
  >> qmatch_goalsub_abbrev_tac ‘computed_ub ≤ err’
  >> strip_tac >> irule REAL_LE_TRANS
  >> qexists_tac ‘computed_ub’ >> gs[]
  >> unabbrev_all_tac
  >> once_rewrite_tac [REAL_MUL_COMM]
  >> drule $ GEN_ALL BOUND_THEOREM_INEXACT
  >> disch_then $ irule o SIMP_RULE std_ss [BETA_THM]
  >> gs[] >> conj_tac
  >- (
    rpt strip_tac
    >> irule POLY_MONO
    >> gs[REAL_LE_MAX, abs]
    >> ntac 2 $ pop_assum mp_tac
    >> rpt $ pop_assum kall_tac
    >> every_case_tac >> real_tac)
  >> qexists_tac ‘findN zeros (λ (u,v). poly (diff errorp) u * poly (diff errorp) v ≤ 0) zerosList’ >> gs[]
  >> rpt strip_tac
  >> irule RECORDERED_ROOTCOUNT
  >> qexists_tac ‘FST iv’ >> qexists_tac ‘SND iv’ >> gs[]
  >> qexists_tac ‘diff errorp’ >> gs[findN_def]
  >> cond_cases_tac >> gs[EVERY_FILTER_TRUE]
QED

Theorem getExpHint_SOME_MEM:
  getExpHint hints = SOME n ⇒
  MEM (EXP_UB_SPLIT n) hints
Proof
  Induct_on ‘hints’ >> gs[getExpHint_def, CaseEq"hint"]
QED

(*
Theorem checker_soundness:
  ∀ cert approxSteps.
    checker cert approxSteps = Valid ⇒
    ∀ x.
      FST(cert.iv) ≤ x ∧ x ≤ SND (cert.iv) ⇒
      abs (interp cert.transc x - poly cert.poly x) ≤ cert.eps
Proof
  rpt gen_tac >> gs[checker_def]
  >> cond_cases_tac
  >> gs[checker_def, approxPoly_def,
        CaseEq"option", CaseEq"prod", CaseEq"result", CaseEq"transc"]
  >> rpt strip_tac >> rpt VAR_EQ_TAC
  (* Step 1: Approximate the transcendental fun with its taylor series *)
  >> irule REAL_LE_TRANS
  >> qexists_tac ‘abs (interp cert.transc x - poly transp x) + abs (poly transp x - poly cert.poly x)’
  >> conj_tac
  (* Approximation using triangle inequality *)
  >- (
    qmatch_goalsub_abbrev_tac ‘abs (transc_fun - poly _ _) ≤ _’
    >> ‘transc_fun - poly cert.poly x = (transc_fun - poly transp x) + (poly transp x - poly cert.poly x)’
      by real_tac
    >> pop_assum $ rewrite_tac o single
    >> irule REAL_ABS_TRIANGLE)
  (* Split the error into the error from Taylor series and the rest *)
  >> ‘cert.eps = err + (cert.eps - err)’ by real_tac
  >> pop_assum $ once_rewrite_tac o single
  (* Split the proof into proving two separate approximations *)
  >> irule REAL_LE_ADD2 >> reverse conj_tac
  (* 1. error between Taylor series and certificate polynomial *)
  >- (
    gs[GSYM poly_compat, GSYM eval_simps]
    >> rewrite_tac [poly_compat]
    >> irule validateZerosLeqErr_sound
    >> qexists_tac ‘diff (transp -p cert.poly)’ >> gs[]
    >> qexists_tac ‘cert.iv’ >> gs[]
    >> qexists_tac ‘cert.zeros’ >> gs[]
    >> ‘FST cert.iv ≤ SND cert.iv’ by real_tac
    >> drule numZeros_sound
    >> disch_then drule >> gs[])
  (* 2. error between transcendental function and Taylor series *)
  (* TODO: Make separate soundness proof *)
  >> ‘(tr = "exp" ∧
       ((cert.iv = (0, 1 * inv 2) ∧ getExpHint cert.hints = NONE) ∨
        ∃ n. getExpHint cert.hints = SOME n ∧ cert.iv = (0,&n * inv 2))) ∨
      tr = "cos" ∨
      tr = "sin"’
    by (every_case_tac >> gs[getExpHint_SOME_MEM])
  (* exp function, 0 to 1/2 *)
  >- (
    gs[interp_def, getFun_def]
    >> qspecl_then [‘x’, ‘approxSteps’] strip_assume_tac MCLAURIN_EXP_LE
    >> pop_assum $ rewrite_tac o single
    >> ‘poly transp x = evalPoly (exp_poly approxSteps) x’
      by (gs[poly_compat] (* >> EVAL_TAC *))
    >> pop_assum $ rewrite_tac o single
    >> rewrite_tac[exp_sum_to_poly]
    >> qmatch_goalsub_abbrev_tac ‘abs (exp_taylor + taylor_rem - exp_taylor) ≤ _’
    >> ‘exp_taylor + taylor_rem - exp_taylor = taylor_rem’ by real_tac
    >> pop_assum $ rewrite_tac o single
    >> unabbrev_all_tac
    >> ‘exp_err_small approxSteps = inv (&FACT approxSteps * 2 pow (approxSteps - 1))’ by EVAL_TAC
    >> qspecl_then [‘approxSteps’, ‘x’,‘t’] mp_tac exp_remainder_bounded_small
    >> impl_tac >> gs[]
    >> real_tac)
  (* exp function, 0 to 1 *)
  >- (
    gs[interp_def, getFun_def]
    >> ‘1 ≠ inv 2’
      by (once_rewrite_tac [GSYM REAL_INV1]
          >> CCONTR_TAC
          >> pop_assum $ mp_tac o SIMP_RULE std_ss []
          >> rewrite_tac[REAL_INV_INJ] >> real_tac)
    >> ‘err = exp_err_big n approxSteps ∧ transp = exp_poly approxSteps’ by gs[]
    >> rpt VAR_EQ_TAC
    >> rewrite_tac[GSYM poly_compat, eval_simps]
    (* >> ‘exp_poly_cst = exp_poly approxSteps’ by EVAL_TAC *)
    >> pop_assum $ rewrite_tac o single
    >> rewrite_tac[exp_sum_to_poly]
    >> qspecl_then [‘x’, ‘approxSteps’] strip_assume_tac MCLAURIN_EXP_LE
    >> pop_assum $ rewrite_tac o single
    >> qmatch_goalsub_abbrev_tac ‘abs (exp_taylor + taylor_rem - exp_taylor) ≤ _’
    >> ‘exp_taylor + taylor_rem - exp_taylor = taylor_rem’ by real_tac
    >> pop_assum $ rewrite_tac o single
    >> unabbrev_all_tac
    >> ‘exp_err_big n approxSteps = 2 pow n * &n pow approxSteps * inv (&FACT approxSteps * 2 pow approxSteps)’
      by (rewrite_tac[] >> EVAL_TAC)
    >> pop_assum $ rewrite_tac o single
    >> qspecl_then [‘approxSteps’, ‘n’, ‘x’,‘t’] mp_tac exp_remainder_bounded_big
    >> impl_tac
    >- (rpt conj_tac >> gs[] >> real_tac)
    >> rewrite_tac[])
  (* cos function *)
  >- (
    gs[interp_def, getFun_def] >> rpt VAR_EQ_TAC
    >> qspecl_then [‘x’, ‘approxSteps’] strip_assume_tac MCLAURIN_COS_LE
    >> gs[]
    >> pop_assum $ rewrite_tac o single
    >> ‘poly (cos_poly approxSteps) x = evalPoly (cos_poly approxSteps) x’
      by (rewrite_tac [cos_poly_cst_EVAL_THM]
          >> gs[poly_compat, cos_poly_cst_def])
    >> pop_assum $ rewrite_tac o single
    >> gs[cos_sum_to_poly]
    >> qmatch_goalsub_abbrev_tac ‘abs (cos_taylor + taylor_rem - cos_taylor) ≤ _’
    >> ‘cos_taylor + taylor_rem - cos_taylor = taylor_rem’ by real_tac
    >> pop_assum $ rewrite_tac o single
    >> unabbrev_all_tac
    >> ‘(x pow approxSteps) * cos t * inv (&FACT approxSteps) =
        (cos t * ((x pow approxSteps) * inv (&FACT approxSteps)))’
      by real_tac
    >> ‘-(x pow approxSteps) * cos t * inv (&FACT approxSteps) =
        -(cos t * ((x pow approxSteps) * inv (&FACT approxSteps)))’
      by real_tac
    >> rewrite_tac []
    >> ntac 2 $ pop_assum $ rewrite_tac o single
    >> rewrite_tac [GSYM REAL_MUL_ASSOC]
    >> qmatch_goalsub_abbrev_tac ‘abs (cos _ * err_cos_concr)’
    >> irule REAL_LE_TRANS
    >> qexists_tac ‘ 1 * abs err_cos_concr’ >> conj_tac
    >- (rewrite_tac[ABS_MUL] >> irule REAL_LE_RMUL_IMP >> unabbrev_all_tac >> gs[COS_BOUND, ABS_POS])
    >> rewrite_tac[REAL_MUL_LID]
    >> ‘abs err_cos_concr = err_cos_concr’
      by (unabbrev_all_tac
          >> rewrite_tac[ABS_REFL]
          >> irule REAL_LE_MUL >> conj_tac
          >- (irule REAL_LE_INV >> gs[REAL_POS])
          >> irule REAL_LE_MUL >> conj_tac
          >> gs[REAL_POW_GE0])
    >> pop_assum $ rewrite_tac o single
    >> unabbrev_all_tac
    >> rewrite_tac [cos_err_def]
    (* >> ‘abs (inv (&FACT approxSteps)) = inv (&FACT approxSteps)’
      by (rewrite_tac[abs] >>  EVAL_TAC >> gs[])
    >> pop_assum $ rewrite_tac o single *)
    >> imp_res_tac EVEN_ODD_EXISTS >> gs[POW_MINUS1]
    (* >> rewrite_tac[ABS_MUL, real_div, REAL_MUL_LID] *)
    >> irule REAL_LE_LMUL_IMP >> gs[GSYM POW_ABS]
    >> irule REAL_LE_TRANS
    >> qexists_tac ‘abs (x pow (2 * m))’ >> gs[ABS_LE, GSYM POW_ABS]
    >> irule POW_LE >> gs[ABS_POS]
    >> irule RealSimpsTheory.maxAbs >> gs[])
  (* sin *)
  >> gs[interp_def, getFun_def] >> rpt VAR_EQ_TAC
  >> qspecl_then [‘x’, ‘approxSteps’] strip_assume_tac MCLAURIN_SIN_LE
  >> gs[]
  >> pop_assum $ rewrite_tac o single
  >> ‘poly (sin_poly approxSteps) x = evalPoly (sin_poly approxSteps) x’
    by (rewrite_tac [sin_poly_cst_EVAL_THM]
        >> gs[poly_compat, sin_poly_cst_def])
  >> pop_assum $ rewrite_tac o single
  >> gs[sin_sum_to_poly]
  >> qmatch_goalsub_abbrev_tac ‘abs (sin_taylor + taylor_rem - sin_taylor) ≤ _’
  >> ‘sin_taylor + taylor_rem - sin_taylor = taylor_rem’ by real_tac
  >> pop_assum $ rewrite_tac o single
  >> unabbrev_all_tac
  >> ‘inv (&FACT approxSteps) * sin t  * x pow approxSteps * -1 pow (approxSteps DIV 2) =
      (sin t * ((x pow approxSteps) * inv (&FACT approxSteps) * -1 pow (approxSteps DIV 2)))’
    by real_tac
  >> ‘-(x pow approxSteps) * inv (&FACT approxSteps) * sin t =
      -(sin t * ((x pow approxSteps) * inv (&FACT approxSteps)))’
    by real_tac
  >> rewrite_tac []
  >> ntac 2 $ pop_assum $ rewrite_tac o single
  >> rewrite_tac[GSYM REAL_MUL_ASSOC]
  >> qmatch_goalsub_abbrev_tac ‘_ * err_sin_concr’
  >> rewrite_tac [ABS_NEG, Once ABS_MUL]
  >> irule REAL_LE_TRANS
  >> qexists_tac ‘ 1 * abs err_sin_concr’ >> conj_tac
  >- (irule REAL_LE_RMUL_IMP >> unabbrev_all_tac >> gs[SIN_BOUND, ABS_POS])
  >> rewrite_tac [REAL_MUL_LID, sin_err_def, ABS_MUL]
  >> ‘abs err_sin_concr = err_sin_concr’
    by (unabbrev_all_tac
        >> rewrite_tac[ABS_REFL]
        >> irule REAL_LE_MUL >> conj_tac
        >> gs[REAL_POW_GE0]
        >> irule REAL_LE_MUL >> gs[REAL_POS, REAL_POW_GE0])
  >> pop_assum $ rewrite_tac o single
  >> unabbrev_all_tac
  >> rewrite_tac [sin_err_def]
  (* >> ‘abs (inv (&FACT approxSteps)) = inv (&FACT approxSteps)’
      by (rewrite_tac[abs] >>  EVAL_TAC >> gs[])
    >> pop_assum $ rewrite_tac o single *)
  >> imp_res_tac EVEN_ODD_EXISTS >> gs[POW_MINUS1]
  (* >> rewrite_tac[ABS_MUL, real_div, REAL_MUL_LID] *)
  >> irule REAL_LE_LMUL_IMP >> gs[GSYM POW_ABS]
  >> irule REAL_LE_TRANS
  >> qexists_tac ‘abs (x pow (2 * m))’ >> gs[ABS_LE, GSYM POW_ABS]
  >> irule POW_LE >> gs[ABS_POS]
  >> irule RealSimpsTheory.maxAbs >> gs[]
QED
*)

val _ = export_theory();
