structure mcLaurinLib =
struct

  open transcSyntax transcTheory realTheory mcLaurinApproxTheory;

  datatype transc =
    Exp of transc
    |Sin of transc
    |Cos of transc
    |Sqrt of transc
    |Add of transc * transc
    |Mul of transc * transc
    |Cst of term
    |Var;

  exception EncodeError;
  exception DerivError;

  fun reflectTransc t =
  if is_var t then Var
  else if realSyntax.is_real_literal t then
    Cst t
  else if is_exp t then
    Exp $ reflectTransc $ dest_exp t
  else if is_sin t then
    Sin $ reflectTransc $ dest_sin t
  else if is_cos t then
    Cos $ reflectTransc $ dest_cos t
  else if is_sqrt t then
    Sqrt $ reflectTransc $ dest_sqrt t
  else if realSyntax.is_plus t then
    let val (arg1, arg2) = realSyntax.dest_plus t in
      Add (reflectTransc arg1, reflectTransc arg2) end
  else if realSyntax.is_mult t then
    let val (arg1, arg2) = realSyntax.dest_mult t in
      Mul (reflectTransc arg1, reflectTransc arg2) end
  else raise EncodeError;

  fun isVar f = case f of Var => true |_ => false;

  val (DIFF_COMPOSITE_SIN, DIFF_COMPOSITE_COS) =
  let val thms = CONJ_LIST 10 DIFF_COMPOSITE in
    (List.nth (thms, 8), List.nth (thms, 9))
    end;

  val DIFF_LAMBDA = Q.prove (‘∀ f m x. (f diffl m) x ⇒ ((λ x. f x) diffl m) x’,
      rpt strip_tac >> ‘(λ x. f x) = f’ suffices_by gs[]
      >> gs[FUN_EQ_THM]);

  fun diffTransc f =
    case f of
      Var => (Cst “1:real”, “λ x. x:real”, “1:real”, Q.SPEC ‘x:real’ limTheory.DIFF_X)
      | Cst k => (Cst “0:real”, Parse.Term ‘^k’, “0:real”, Q.SPEC ‘^k’ limTheory.DIFF_CONST)
      | Exp g =>
          let val (g_diff, g_tm, g_diff_tm, g_diff_thm) = diffTransc g in
            if isVar g then
              (Exp Var,
               “λ x. exp x”,
               “exp (x:real)”,
               MATCH_MP DIFF_LAMBDA $ Q.SPEC ‘x’ transcTheory.DIFF_EXP)
            else
              (Mul (Exp g, g_diff),
               Parse.Term ‘λ x. exp(^g_tm x)’,
               Parse.Term ‘exp(^g_tm x) * ^g_diff_tm’,
               MATCH_MP transcTheory.DIFF_COMPOSITE_EXP g_diff_thm)
            end
      | Sin g =>
          let val (g_diff, g_tm, g_diff_tm , g_diff_thm) = diffTransc g in
            if isVar g then
              (Cos Var,
               “λ x. sin(x:real)”,
               “cos(x:real)”,
               MATCH_MP DIFF_LAMBDA $ Q.SPEC ‘x’ transcTheory.DIFF_SIN)
            else
              (Mul (Cos g, g_diff),
               Parse.Term ‘λ x. sin(^g_tm x)’,
               Parse.Term ‘cos(^g_tm x) * ^g_diff_tm’,
               MATCH_MP DIFF_COMPOSITE_SIN g_diff_thm)
            end
      | Cos g =>
          let val (g_diff, g_tm, g_diff_tm , g_diff_thm) = diffTransc g in
            if isVar g then
              (Sin Var,
               “λ x. cos(x:real)”,
               “-sin(x:real)”,
               MATCH_MP DIFF_LAMBDA $ Q.SPEC ‘x’ transcTheory.DIFF_COS)
            else
              (* TODO: Negation *)
              (Mul (Sin g, g_diff),
               Parse.Term ‘λ x. cos(^g_tm x)’,
               Parse.Term ‘-sin(^g_tm x) * g_diff_tm’,
               MATCH_MP DIFF_COMPOSITE_COS g_diff_thm)
          end
      | Sqrt g => raise DerivError
      | Add (g1, g2) =>
          let val (g1_diff, g1_tm, g1_diff_tm, g1_diff_thm) = diffTransc g1
            val (g2_diff, g2_tm, g2_diff_tm, g2_diff_thm) = diffTransc g2
          in
            (Add (g1_diff, g2_diff),
             Parse.Term ‘\x. ^g1_tm x + ^g2_tm x’,
             Parse.Term ‘^g1_diff_tm + ^g2_diff_tm’,
             MATCH_MP
               (MATCH_MP
                 (REWRITE_RULE [GSYM AND_IMP_INTRO] limTheory.DIFF_ADD)
                 g1_diff_thm)
               g2_diff_thm)
          end
      | Mul (g1, g2) =>
          let val (g1_diff, g1_tm, g1_diff_tm, g1_diff_thm) = diffTransc g1
            val (g2_diff, g2_tm, g2_diff_tm, g2_diff_thm) = diffTransc g2
          in
            (Add (Mul (g1_diff, g2), Mul (g1, g2_diff)),
             Parse.Term ‘λ x. ^g1_tm x + ^g2_tm x’,
             Parse.Term ‘(^g1_diff_tm * ^g2_tm x) + (^g1_tm x * ^g2_diff_tm)’,
             MATCH_MP
               (MATCH_MP
                 (REWRITE_RULE [GSYM AND_IMP_INTRO] limTheory.DIFF_MUL)
                 g1_diff_thm)
               g2_diff_thm)
            end;

  fun diffList f n =
    if n <= 0 then []
    else
      let val (diffTr, f_tm, diff_tm, diffThm) = diffTransc f in
        (diffTr, f_tm, diff_tm, diffThm) :: diffList diffTr (n - 1)
      end

  val lemma = Q.prove (
    ‘∀ diff n f g.
      (∀ x. (f diffl g) x) ∧
      diff n = f ∧
      (∀ m x. m < n ⇒ (diff m diffl diff (SUC m) x) x) ⇒
      ∀ m x.
        m < SUC n ⇒
        ((λ k x. if k = SUC n then g else diff k x) m diffl
         (λ k x. if k = SUC n then g else diff k x) (SUC m) x) x’,
    rpt strip_tac
    >> Cases_on ‘m = n’ >> gs[]
    >- (
       ‘(λ x . f x) = f’ suffices_by gs[]
       >> gs[FUN_EQ_THM])
    >> ‘m < n’ by gs[]
    >> ‘(λ x. diff m x) = diff m’ suffices_by gs[]
    >> gs[FUN_EQ_THM]);

  fun mkDiffFun diffs =
  case diffs of
    [] => Parse.Term ‘λ (n:num) (x:real). x’
  | [(diffTr, f_tm, diff_tm, diffThm)] =>
     Parse.Term ‘λ (n:num) x. if n = 1 then ^diff_tm else if n = 0 then ^f_tm x else x’
  | (diffTr, f_tm, diff_tm, diffThm)::remDiffs =>
      let val diffFun = mkDiffFun remDiffs
        val indexNum = numSyntax.term_of_int $ List.length diffs
      in
        Parse.Term ‘λ n x. if n = ^indexNum then ^diff_tm else ^diffFun n x’
      end
  (* SIMP_CONV std_ss [BETA_THM] (mkDiffFun (List.rev $ diffList (Cos Var) 16)) *)

  fun MCLAURIN_RULE t n =
  let val enc_t = reflectTransc (snd (dest_abs t))
  val diffFun = SIMP_CONV std_ss [BETA_THM] (mkDiffFun (List.rev $ diffList enc_t n)) |> concl |> rhs
  val diffFun_0_fine = Q.prove (‘^diffFun 0 = ^t’, gs[]) in
    MATCH_MP (REWRITE_RULE [GSYM AND_IMP_INTRO] MCLAURIN_ALL_LE) diffFun_0_fine
  end

  Q.SPECL [‘x’, ‘16’] MCLAURIN_SIN_LE |> BETA_RULE |> SIMP_RULE std_ss [SIN_0, COS_0, REAL_MUL_LZERO, REAL_MUL_LID]
  |>
  Q.SPECL [‘sin (x)’, ‘16’] MCLAURIN_EXP_LE
  |> EVAL_RULE
  |> SIMP_RULE std_ss [SimpL “$=”, pow]

val _ = computeLib.add_thms [CONV_RULE numLib.SUC_TO_NUMERAL_DEFN_CONV pow] computeLib.the_compset;


  Q.SPECL [‘sin x’, ‘3’] MCLAURIN_EXP_LE
  |> CONV_RULE $ PATH_CONV "brrl" EVAL
  |> SIMP_RULE std_ss [REAL_MUL_RID, REAL_OVER1]

PATH_CONV "rl" EVAL )
  “exp (sin x) =
         sum (0,16) (λm. sin x pow m / &FACT m) +
         exp t / &FACT 16 * sin x pow 16”

  val th = PROVE [BETA_THM] “exp t / &FACT k * x pow k = (\ m. exp t / &FACT k * x pow k) m”
  Q.SPEC ‘sum (0,k) (λm. x pow m / &FACT m) + exp t / &FACT k * x pow k’ MCLAURIN_EXP_LE
  |> REWRITE_RULE [Once th, realTheory.SUM_ADD]

  (*
  MCLAURIN_RULE “λ x. exp x” 16
  *)

end;
