open RealArith realTheory realLib realSyntax polyTheory;
open realPolyTheory realPolyProofsTheory checkerTheory sturmComputeTheory
     transcLangTheory transcIntvSemTheory approxPolyTheory
     transcApproxSemTheory transcReflectTheory euclidDivTheory
     certParserTheory;
open AbbrevsTheory RealSimpsTheory sqrtApproxTheory IntervalArithTheory;
open ml_translatorLib ml_translatorTheory basis stringTheory mlstringTheory;
open bossLib preambleDandelion;

val _ = new_theory "translate";

val _ = translation_extends "basisProg";

val _ = translate oEL_def;

(** Copied from FloVer **)
(* translation of real_div *)
val _ = (next_ml_names := ["real_div"]);
val res = translate realTheory.real_div;
val real_div_side = prove(
  let val tm = hyp res |> hd |> rand val v = rand tm
  in mk_eq(tm,``^v <> 0``) end,EVAL_TAC)
  |> update_precondition;
(* / translation of real_div *)

(** Translate basic functions **)
val _ = map translate [FACT, reduce_def, zerop_def, deg_def, coeff_def, monom_def,
                       poly_add_aux_def, poly_add_def,
                       poly_mul_cst_aux_def, poly_mul_cst_def, poly_mul_def,
                       poly_neg_def, poly_sub_def,
                       evalPoly_def,
                       divmod_aux_def, divmod_def, rm_def];

val expPoly_res = translate expPoly_def;
val exppoly_side_def = fetch "-" "exppoly_side_def";

Theorem FACT_NOT_ZERO:
  ∀ n. FACT n ≠ 0
Proof
  Induct_on ‘n’ >> gs[FACT]
QED

Theorem FACT_NOT_ZERO_REAL:
  ∀ n. &FACT n ≠ 0
Proof
  gs[FACT_NOT_ZERO]
QED

Theorem exppoly_side_true:
  ∀ n. exppoly_side n = T
Proof
  Induct_on ‘n’ >> simp[Once exppoly_side_def]
  >> rpt strip_tac >> ‘FACT n ≠ 0’ suffices_by gs[]
  >> gs[FACT_NOT_ZERO]
QED

val _ = exppoly_side_true |> update_precondition;

Definition sturm_seq_aux_alt_def:
  sturm_seq_aux_alt n p q =
  case n of
  | 0 =>
    if coeff q (deg q) = 0 then NONE else
    if (rm p ((coeff q (deg q))⁻¹ *c q) = []) ∧ ¬zerop q then SOME []
      else NONE
  | SUC n =>
      if (coeff q (deg q) = 0) then NONE else
      (let g = (rm p (inv (coeff q (deg q)) *c q)) in
       if g = [] ∧ ~ zerop q then SOME []
       else if zerop q ∨ (LENGTH (reduce q) < 2)
       then NONE
       else case sturm_seq_aux_alt n q (--p g) of
            | SOME ss => SOME (--p g::ss)
            | _ => NONE)
End

(** sturm_seq_aux gets a precond, but we discharge it later **)
val sturm_seq_aux_res = translate sturm_seq_aux_alt_def;

Definition sturm_seq_alt_def:
  sturm_seq_alt p q =
    if zerop q ∨ deg p ≤ 1 then NONE
    else
      case sturm_seq_aux_alt (deg p - 1) p q of
      NONE => NONE
      | SOME sseq =>
        case oEL (PRE (LENGTH sseq)) sseq of
        | SOME [x] => if x ≠ 0 then SOME sseq
                   else NONE
        | _ => NONE
End

val res = translate sturm_seq_alt_def

Theorem sturm_seq_aux_alt_sound:
  ∀ n p q sseq.
    sturm_seq_aux_alt n p q = SOME sseq ⇒
    sturm_seq_aux n p q = SOME sseq
Proof
  Induct >> rw[Once sturm_seq_aux_alt_def, Once sturm_seq_aux_def, CaseEq"option"]
QED

Theorem sturm_seq_alt_sound:
  sturm_seq_alt p q = SOME sseq ⇒
  sturm_seq p q = SOME sseq
Proof
  rw[sturm_seq_def, sturm_seq_alt_def, CaseEq"option"]
  >> imp_res_tac sturm_seq_aux_alt_sound
  >> gs[]
QED

val _ = map translate [abs, polyTheory.poly_diff_aux_def, polyTheory.poly_diff_def,
                       sturmTheory.varrec_def, sturmTheory.variation_def,
                       polyTheory.poly_def, numZeros_def,
                       findN_def, getMaxWidth_def,
                       getMaxAbsLb_def, validBounds_def,
                       drangTheory.recordered_def,
                       validateZerosLeqErr_def]

(** Translate lexer and parser **)
val _ = map translate [isDigit_def, isLower_def, isUpper_def, isAlpha_def,
                       isAlphaNum_def, getConst_def,
                       lexConst_def, lexName_def, lex_def]

val _ = map translate [parseConst_def, getBop_def, getTranscFun_def,
                       parseTransc_def, parseFrac_def, parseIV_def,
                       parsePrecondRec_def, parsePrecond_def,
                       parsePoly_def, dParse_def, parseZeros_def,
                       parsePolyErr_def]

val _ = export_theory ();

(**  UNUSED
val _ = map translate [pow]

val expErrSmall_res = translate expErrSmall_def;
val _ = fetch "-" "experrsmall_side_def" |> REWRITE_RULE [FACT_NOT_ZERO] |> update_precondition

val expErrBig_res = translate expErrBig_def;
val _ = fetch "-" "experrbig_side_def" |> REWRITE_RULE [FACT_NOT_ZERO] |> update_precondition

(** TODO: This uses LEAST, i.e. a loop to find the ceiling, maybe replace with a
faster version using division? **)
val NUM_CEILING_res = translate NUM_CEILING_def;
val num_ceiling_side_def = fetch "-" "num_ceiling_side_def"

Theorem NUM_CEILING_side_true:
  ∀ x. num_ceiling_side x = T
Proof
  gs[num_ceiling_side_def, FUN_EQ_THM] >> rpt strip_tac
  >> qexists_tac ‘clg (x)’
  >> gs[LE_NUM_CEILING]
QED

val _ = update_precondition NUM_CEILING_side_true

val _ = map translate [min4_def, max4_def, IVlo_def, IVhi_def]

(** Taken from FloVer once more **)
fun LET_CONV var_name body =
  (UNBETA_CONV body THENC
   RATOR_CONV (ALPHA_CONV (mk_var(var_name, type_of body))) THENC
   REWR_CONV (GSYM LET_THM));

val absIntvUpd_eq =
  IntervalArithTheory.absIntvUpd_def
  |> SPEC_ALL
  |> CONV_RULE (RAND_CONV (LET_CONV "lo1" ``IVlo iv1`` THENC
                           LET_CONV "lo2" ``IVlo iv2`` THENC
                           LET_CONV "hi1" ``IVhi iv1`` THENC
                           LET_CONV "hi2" ``IVhi iv2``));

val addInterval_eq =
  IntervalArithTheory.addInterval_def
  |> REWRITE_RULE [absIntvUpd_eq]
val _ = translate addInterval_eq

val multInterval_eq =
  IntervalArithTheory.multInterval_def
  |> REWRITE_RULE [absIntvUpd_eq]
val _ = translate multInterval_eq
(** End of copy **)

(** newton and getFunIv have a side condition for the second argument being
    unequal to 0, this is discharged later when dealing with interpIntv **)
val _ = map translate [getAnn_def, abs, newton_def,
                       validate_newton_down_def, validate_newton_up_def,
                       getFunIv_def
                         |> SIMP_RULE std_ss [internalSteps_def, newtonIters_def],
                       negateInterval_def, invertInterval_def,
                       subtractInterval_def, divideInterval_def,
                       widenInterval_def,
                       intvBop_def, intvUop_def]

val evalpolyintv_res = translate evalPolyIntv_def;
val intvbop_side_def = fetch "-" "intvbop_side_def"
val evalpolyintv_side_def = fetch "-" "evalpolyintv_side_def" |> SIMP_RULE std_ss [intvbop_side_def]

Theorem evalpolyintv_side_true:
  ∀ p iv. evalpolyintv_side p iv = T
Proof
  Induct_on ‘p’ >> simp[Once evalpolyintv_side_def]
QED

val _ = update_precondition evalpolyintv_side_true;

Definition interpIntv_alt_def:
  interpIntv_alt (Var x) (env:(string#(real#real)) list) =
    (case FIND (λ (y, iv). y = x) env of
    | NONE => NONE
    | SOME xv => SOME (VarAnn (SND xv) x))
  ∧
  interpIntv_alt (Cst c) env = SOME (CstAnn (c,c) c) ∧
  interpIntv_alt (Uop uop t) env =
  (case interpIntv_alt t env of
    | NONE => NONE
    | SOME r =>
      if (~ (uop = Inv)) ∨ (SND (getAnn r) < 0 ∨ 0 < FST (getAnn r))
      then SOME (UopAnn (intvUop uop (getAnn r)) uop r)
      else NONE)
  ∧
  interpIntv_alt (Bop bop t1 t2) env =
    (case interpIntv_alt t1 env of
    | NONE => NONE
    | SOME r1 =>
      case interpIntv_alt t2 env of
      | NONE => NONE
      | SOME r2 =>
        let iv1 = getAnn r1; iv2 = getAnn r2; in
        if bop = Div ⇒ (SND iv2 < 0 ∨ 0 < FST iv2)
        then SOME (BopAnn (intvBop bop iv1 iv2) bop r1 r2)
        else NONE)
  ∧
  interpIntv_alt (Fun s t) env =
    (case interpIntv_alt t env of
    | NONE => NONE
    | SOME r =>
      let iv = getAnn r in
      (* Sqrt defined for positive values only *)
        (* Tan cannot be done at 0 because we approximate it with sin x/cos x *)
      if ((~ (s = Sqrt)) ∨ (0 < FST iv)) ∧
         ((~ (s = Tan)) ∨ (SND iv < 0 ∨ 0 < FST iv))
      then
        case getFunIv s iv of
        | NONE => NONE
        | SOME ivRes => SOME (FunAnn ivRes s r)
      else NONE)
  ∧
  interpIntv_alt (Poly p t) env =
  case interpIntv_alt t env of
  | NONE => NONE
  | SOME r =>
      let iv = getAnn r in
      SOME (PolyAnn (evalPolyIntv p iv) p r)
End

(**
Theorem interpIntv_alt_sound:
  interpIntv_alt p env = SOME ann ⇒
  interpIntv p env = SOME ann
Proof
  (** TODO **)
QED
**)

val _ = translate interpIntv_alt_def
val interpintv_alt_side_def = fetch "-" "interpintv_alt_side_def"
val getfuniv_side_def = fetch "-" "getfuniv_side_def"
val newton_side_def = fetch "-" "newton_side_def"
val intvuop_side_def = fetch "-" "intvuop_side_def"
val divideinterval_side_def = fetch "-" "divideinterval_side_def"
val invertinterval_side_def = fetch "-" "invertinterval_side_def"

Theorem newton_side_inductive:
  ∀ n x y.
    0 ≤ x ∧ 0 ≤ y ∧ x ≠ 0 ∧ y ≠ 0 ⇒
    newton_side n x y
Proof
  Induct_on ‘n’ >> simp[Once newton_side_def]
  >> rpt strip_tac
  >> ‘0 ≤ x / y ’ by gs[real_div, moreRealTheory.REAL_ZERO_LE_MUL1]
  >> first_x_assum irule >> rpt conj_tac
  >- gs[]
  >- (
    ‘x/y ≠ 0’ by gs[real_div]
    >> ‘(y + x / y) ≠ 0’ by (gs[real_div] >> real_tac)
    >> gs[real_div])
  >> gs[]
  >> real_tac
QED

Theorem interpintv_alt_side_true:
  ∀ p env. interpintv_alt_side p env = T
Proof
  Induct_on ‘p’ >> simp[Once interpintv_alt_side_def]
  >- (
    rpt strip_tac >> gs[getfuniv_side_def]
    >> ‘FST (getAnn x1) ≤ SND (getAnn x1)’ by TODO
    >> rpt strip_tac >> res_tac >> gs[]
    >> irule newton_side_inductive >> gs[]
    >> rpt conj_tac >> real_tac)
  >- (
    rpt strip_tac
    >> gs[intvbop_side_def] >> rpt strip_tac >> res_tac
    >> gs[divideinterval_side_def, invertinterval_side_def]
    >> ‘FST (getAnn x2) ≤ SND (getAnn x2)’ by TODO
    >> conj_tac >> real_tac)
  >> rpt strip_tac
  >> gs[intvuop_side_def] >> rpt strip_tac >> res_tac
  >> gs[invertinterval_side_def]
  >> ‘FST (getAnn x4) ≤ SND (getAnn x4)’ by TODO
  >> conj_tac >> real_tac
QED

val _ = update_precondition interpintv_alt_side_true

Definition approxTransc_alt_def:
  approxTransc_alt cfg (VarAnn iv s) = SOME (VarAnn 0 s) ∧
  approxTransc_alt cfg (CstAnn iv r) = SOME (CstAnn 0 r) ∧
  approxTransc_alt cfg (BopAnn iv b e1 e2) =
  (case approxTransc_alt cfg e1 of
  | NONE => NONE
  | SOME e1Appr =>
    case approxTransc_alt cfg e2 of
    | NONE => NONE
    | SOME e2Appr =>
      if (b = Div ⇒
          SND (widenInterval (getAnn e2) (getAnn e2Appr)) < 0 ∨
          0 < FST (widenInterval (getAnn e2) (getAnn e2Appr)))
      then
        let propError = errorPropBop b (getAnn e1) (getAnn e1Appr) (getAnn e2) (getAnn e2Appr)
        in SOME (BopAnn propError b e1Appr e2Appr)
      else NONE)
  ∧
  approxTransc_alt cfg (UopAnn iv u e) =
    (case approxTransc_alt cfg e of
    | NONE => NONE
    | SOME eAppr =>
      if (u = Inv ⇒
          SND (widenInterval (getAnn e) (getAnn eAppr)) < 0 ∨
          0 < FST (widenInterval (getAnn e) (getAnn eAppr)))
      then
        let propError = errorPropUop u (getAnn e) (getAnn eAppr)
        in SOME (UopAnn propError u eAppr)
      else NONE)
  ∧
  approxTransc_alt cfg (FunAnn iv f e) =
    (case approxTransc_alt cfg e of (* recursive call *)
    | NONE => NONE
    | SOME eAppr =>
      (* approximate polynomial on widened interval *)
      case approxPoly f (widenInterval (getAnn e) (getAnn eAppr) ) cfg.steps of
      | NONE => NONE
      | SOME (pWiden,errWiden) =>
        if (approxPolySideCond cfg.steps ∧ getAnn eAppr ≤ inv 2 ∧ 0 ≤ getAnn eAppr)
        then
          case errorPropFun f cfg (getAnn e) (getAnn eAppr) pWiden errWiden of
            | NONE => NONE
            | SOME fullError => SOME (PolyAnn fullError pWiden eAppr)
        else NONE)
  ∧
  (* We do not support partial approximations for now *)
  approxTransc_alt cfg  (PolyAnn iv p e) = NONE
End

Theorem approxTransc_alt_sound:
  approxTransc_alt cfg p = SOME ann ⇒
  approxTransc cfg p = SOME ann
Proof
  TODO
QED

val _ = map translate [sinPoly_def, cosPoly_def, sinErr_def, cosErr_def];

val sinpoly_side_def = fetch "-" "sinpoly_side_def" |> SIMP_RULE std_ss []
val cospoly_side_def = fetch "-" "cospoly_side_def" |> SIMP_RULE std_ss []
val sinerr_side_def = fetch "-" "sinerr_side_def" |> SIMP_RULE std_ss [FACT_NOT_ZERO] |> update_precondition
val coserr_side_def = fetch "-" "coserr_side_def" |> SIMP_RULE std_ss [FACT_NOT_ZERO] |> update_precondition

Theorem sinpoly_side_true:
  ∀ n. sinpoly_side n = T
Proof
  Induct_on ‘n’ >> simp[Once sinpoly_side_def, FACT_NOT_ZERO]
QED

val _ = update_precondition sinpoly_side_true

Theorem cospoly_side_true:
  ∀ n. cospoly_side n = T
Proof
  Induct_on ‘n’ >> simp[Once cospoly_side_def, FACT_NOT_ZERO]
QED

val _ = update_precondition cospoly_side_true

val _ = map translate [minAbsFun_def, maxAbs_def, approxPolySideCond_def,
                       approxPoly_def,
                       errorPropUop_def, errorPropBop_def,
                       errorPropSinCos_def, errorPropFun_def,
                       approxTransc_alt_def]

val errorpropuop_side_def = fetch "-" "errorpropuop_side_def"
val errorpropbop_side_def = fetch "-" "errorpropbop_side_def"
val approxtransc_alt_side_def = fetch "-" "approxtransc_alt_side_def"

Theorem min_abs:
real$min (real$abs x) (real$abs y) = 0 ⇒
x = 0 ∨ y = 0
Proof
  gs[min_def]
  >> cond_cases_tac >> gs[]
QED

Theorem approxtransc_alt_side_true:
  ∀ cfg p ivenv. validIVAnnot p ivenv ⇒ approxtransc_alt_side cfg p = T
Proof
  Induct_on ‘p’ >> simp[Once approxtransc_alt_side_def]
  >> rpt strip_tac >> simp[errorpropuop_side_def, errorpropbop_side_def, invertinterval_side_def]
  >> rpt strip_tac >> res_tac
  >> gs[minAbsFun_def]
  >> imp_res_tac min_abs
  >- TODO
  >- TODO
  >- TODO
  >- TODO
  >- gs[]
  >- gs[]
  >- TODO
  >- TODO
  >- TODO
  >- TODO
  >- TODO
  >- TODO
  >- TODO
  >- gs[]
  >- gs[]
  >> TODO
QED

val _ = map translate [compose_def, cst_def, var_def, reflectToPoly_def,
                       erase_def]

(**
  approxPipeline must return the certificate and the annotated polynomial
  because we need to pretty print to stdout the err, as well as the polynomial
  difference between the certificate polynomial and the computed one **)
Definition approxPipeline_def:
  approxPipeline cert steps =
    if ~ (LENGTH cert.iv = 1) ∨ ~ approxPolySideCond steps then NONE
    else
      case interpIntv_alt cert.transc cert.iv of
      | NONE => NONE
      | SOME pIvAnn =>
          case approxTransc_alt <| steps := steps |> pIvAnn of
          | NONE => NONE
          | SOME trAnn =>
              case reflectToPoly (erase trAnn) (FST (HD cert.iv)) of
              | NONE => NONE
              | SOME p => SOME (p -p cert.poly, getAnn trAnn)
End

val _ = translate approxPipeline_def;
val approxpipeline_side_def = fetch "-" "approxpipeline_side_def"

Theorem approxpipeline_side_true:
  ∀ cert steps.
    approxpipeline_side cert steps = T
Proof
  rpt strip_tac >> simp[approxpipeline_side_def]
  >> rpt strip_tac >> gs[]
  >> irule (SIMP_RULE std_ss [EQ_CLAUSES] approxtransc_alt_side_true)
  >> qexists_tac ‘cert.iv’ >> irule interpIntv_sound
  >> qexists_tac ‘cert.transc’ >> irule interpIntv_alt_sound >> gs[]
QED

val _ = update_precondition approxpipeline_side_true

val _ = export_theory();

**)
