open realPolyTheory checkerDefsTheory mlintTheory;
open preambleDandelion;

val _ = new_theory "certParser";

Datatype:
  Token =
  | CERTSTART | CERTEND
  | TADD | TSUB | TMUL | TDIV
  | CONST num | VAR string
  | LBRAC | RBRAC
  | TRANSC | POLY
  | ERR | IV | NAPPR
  | ZEROS
End

Definition getConst_def:
  getConst (c:char) = ORD c - 48
End

Definition lexConst_def:
  lexConst (input:string) (akk:num) =
    case input of
    | STRING char input' =>
        if (isDigit char)
        then lexConst input' (akk * 10 + (getConst char))
        else (akk, input)
    |"" => (akk, input)
End

Theorem lexConst_imp:
  ∀ s n s1 s2.
    lexConst s n = (s1,s2) ⇒ LENGTH s2 <= LENGTH s
Proof
  Induct \\ simp [Once lexConst_def]
  \\ rw [] \\ res_tac \\ fs []
QED

Definition lexName_def:
  lexName (input:string) =
  case input of
  | STRING char input' =>
      if (isAlphaNum char)
      then
        let (name, input') = lexName input' in
          (STRING char name, input')
      else ("", input)
  | "" => ("",input)
End

Theorem lexName_imp:
  !s s1 s2. lexName s = (s1,s2) ==> (s = s1 ++ s2)
Proof
  Induct \\ simp [Once lexName_def]
  \\ rw [] \\ pairarg_tac \\ fs []
QED

Definition strSize_def:
  strSize str :num=
    case str of
      | STRING _ str' => 1 + strSize str'
      | "" => 0
End

Definition lex_def:
  lex input =
    case input of
    | STRING char input1 =>
      (case char of
      | #"+" => TADD :: lex input1
      | #"-" => TSUB :: lex input1
      | #"*" => TMUL :: lex input1
      | #"/" => TDIV :: lex input1
      | #"<" => CERTSTART :: lex input1
      | #">" => CERTEND :: lex input1
      | #"(" => LBRAC :: lex input1
      | #")" => RBRAC :: lex input1
      (* | #"#" => DFRAC :: lex input' *)
      (* | #"?" => DCOND :: lex input' *)
      (* | #"~" => DNEG :: lex input' *)
      | #" " => lex input1
      | #"\n" => lex input1
      | _ =>
        if isDigit char then
          let (num, input2) = lexConst input 0 in
            CONST num :: lex input2
        else if isAlpha char then
          let (name, input2) = lexName input in
            case name of
            | "TRANSC" => TRANSC :: lex input2
            | "POLY" => POLY :: lex input2
            | "ERR" => ERR :: lex input2
            | "IV" => IV :: lex input2
            | "NAPPR" => NAPPR :: lex input2
            | "ZEROS" => ZEROS :: lex input2
            | "" => NIL
            | _ => VAR name :: lex input2
        else NIL)
    | _ => NIL
Termination
  wf_rel_tac `measure LENGTH` \\ rw [] \\ fs []
  \\ imp_res_tac (GSYM lexName_imp) \\ fs [] \\ rpt VAR_EQ_TAC \\ fs []
  \\ fs [Once lexConst_def] \\ rfs []
  \\ imp_res_tac (GSYM lexConst_imp) \\ fs [] \\ rpt VAR_EQ_TAC \\ fs []
End

Definition str_join_def:
  str_join (STRING c s1) s2 = STRING c (str_join s1 s2) ∧
  str_join "" s2 = s2
End

Definition str_of_num_def:
  str_of_num (n:num) =
    if n < 10 then STRING (CHR (n + 48)) ""
    else str_join (str_of_num (n DIV 10)) (STRING (CHR ( (n MOD 10) + 48)) "")
End

Definition str_of_bool_def:
  str_of_bool (b:bool) = if b then "T" else "F"
End

Definition pp_token_def:
  pp_token (token:Token) =
    case token of
    | CERTSTART => "<"
    | CERTEND => ">"
    | TADD => "+"
    | TSUB => "-"
    | TMUL => "*"
    | TDIV => "/"
    | RBRAC => ")"
    | LBRAC => "("
    | CONST n => str_of_num n
    | VAR x => x
    | TRANSC => "TRANSC"
    | POLY => "POLY"
End

(*
Theorem pp_token_correct:
  ∀ t. lex (pp_token t) = [t]
Proof
 Induct_on `t` \\ gs[pp_token_def, Once lex_def]
 >- gs[lex_def]
 >- gs[lex_def]
 >- gs[lex_def]
 >- gs[lex_def]
 >- gs[lex_def]
 >- gs[lex_def]
 >- (
   rpt strip_tac
QED
*)

(* Pretty Printer for Tokens *)
Definition pp_def:
  (pp (token :: tokList) = str_join (pp_token token) (pp tokList)) ∧
  (pp NIL = "")
End

Definition fix_res_def:
  fix_res xs NONE = NONE /\
  fix_res xs (SOME (x,y)) =
    if LENGTH xs < LENGTH y then SOME (x,xs) else SOME (x,y)
End

Theorem fix_res_imp:
  fix_res xs a = SOME (x,y) ==> LENGTH y <= LENGTH xs
Proof
  Cases_on `a` \\ rw [fix_res_def]
  \\ Cases_on `x'` \\ fs [fix_res_def]
  \\ every_case_tac \\ fs [] \\ rpt VAR_EQ_TAC \\ fs []
QED

Definition parseConst_def:
  parseConst ([]) = NONE ∧
  parseConst (CONST n :: TDIV :: CONST d :: tokList) =
    (if d = 0 then NONE else SOME (Cst (&n / &d), tokList)) ∧
  parseConst _ = NONE
End

Definition getBop_def:
  getBop (TADD) = SOME Add ∧
  getBop (TSUB) = SOME Sub ∧
  getBop (TMUL) = SOME Mul ∧
  getBop (TDIV) = SOME Div ∧
  getBop _ = NONE
End

Definition getTranscFun_def:
getTranscFun x =
  if x = "exp" then SOME Exp
  else if x = "sin" then SOME Sin
  else if x = "cos" then SOME Cos
  else if x = "tan" then SOME Tan
  else if x = "sqrt" then SOME Sqrt
  else NONE
End

Theorem parseConst_decreasing:
  parseConst tokList = SOME (p, tokList2) ⇒
  LENGTH tokList2 < LENGTH tokList
Proof
  Cases_on ‘tokList’ >> gs[parseConst_def]
  >> Cases_on ‘h’ >> gs[parseConst_def]
  >> Cases_on ‘t’ >> gs[parseConst_def]
  >> Cases_on ‘h’ >> gs[parseConst_def]
  >> Cases_on ‘t'’ >> gs[parseConst_def]
  >> Cases_on ‘h’ >> gs[parseConst_def]
QED

(** Prefix form parser for exprressions **)
Definition parseTransc_def:
  parseTransc (tokList:Token list): (transc # Token list) option =
  case tokList of
  | [] => NONE
  | tok1 :: tokList1 =>
    let res1 =
      (case tok1 of
      | CONST n => parseConst tokList
      | VAR x =>
          (case getTranscFun x of
          | SOME f =>
            (case tokList1 of
             | LBRAC :: tokList2 =>
               (case fix_res tokList2 (parseTransc tokList2) of
               | NONE => NONE
               | SOME (arg, tokList3) =>
                  (case tokList3 of
                  | RBRAC :: tokList4 => SOME (Fun f arg, tokList4)
                  | _ => NONE))
             | _ => NONE)
          | NONE => SOME (Var x, tokList1))
      (* Unary operators take precedence, i.e. - x + y = (- x) + y *)
      | TSUB =>
        (case fix_res tokList1 (parseTransc tokList1) of
        | NONE => NONE
        | SOME (e, tokList2) =>
            (case e of
            |Cst r => SOME (Cst r, tokList2)
            | _ => SOME (Uop Neg e, tokList2)))
      (* Parenthesis *)
      | LBRAC =>
        (case fix_res tokList1 (parseTransc tokList1) of
        | NONE => NONE
        | SOME (e, tokList2) =>
          (case tokList2 of
          | RBRAC :: tokList3 => SOME (e, tokList3)
          | _ => NONE))
      | _ => NONE)
    in
    (** Now check whether we can continue parsing an expression with a binary operator **)
    case res1 of
    | NONE => NONE
    | SOME (e1, newTokList) =>
      case newTokList of
      | [] => SOME (e1, newTokList)
      | tok2 :: newTokList1 =>
        case getBop tok2 of
        | NONE => NONE
        | SOME bop =>
          case fix_res newTokList1 (parseTransc newTokList1) of
          | NONE => NONE
          | SOME (e2, newTokList2) => SOME (Bop bop e1 e2, newTokList2)
Termination
  wf_rel_tac ‘measure LENGTH’
  >> rw[] >> gs[CaseEq"Token", CaseEq"option", CaseEq"prod", CaseEq"transc", CaseEq"list"]
  >> rpt VAR_EQ_TAC
  >> imp_res_tac fix_res_imp >> gs []
  >> imp_res_tac parseConst_decreasing >> gs[]
End

Theorem parseTransc_LESS_EQ:
  ∀ xs x y.
    parseTransc xs = SOME (x,y) ⇒ LENGTH y ≤ LENGTH xs
Proof
  recInduct parseTransc_ind
  \\ rw [] \\ fs [] \\ pop_assum mp_tac
  \\ once_rewrite_tac [parseTransc_def]
  \\ gs[CaseEq"list", CaseEq"Token", CaseEq"option", CaseEq"prod", CaseEq"transc"]
  \\ rw[] \\ gs[]
  \\ imp_res_tac fix_res_imp \\ fs []
  \\ imp_res_tac parseConst_decreasing \\ gs[]
QED

Theorem fix_res_parseTransc:
  fix_res xs (parseTransc xs) = parseTransc xs
Proof
  Cases_on ‘parseTransc xs’ >> gs[fix_res_def]
  >> Cases_on ‘x’ >> gs[fix_res_def]
  >> imp_res_tac parseTransc_LESS_EQ >> gs []
QED

val parseTransc_def = save_thm("parseTransc_def",
  parseTransc_def |> REWRITE_RULE [fix_res_parseTransc]);

val parseTransc_ind = save_thm("parseTransc_ind",
  parseTransc_ind |> REWRITE_RULE [fix_res_parseTransc]);

Definition parseFrac_def:
  parseFrac (input:Token list) :(real # Token list) option =
    case input of
    | TSUB :: CONST n :: TDIV :: CONST m :: tokRest =>
        if (m = 0) then NONE else SOME ((- &n):real / (&m),tokRest)
    | CONST n :: TDIV :: CONST m :: tokRest =>
        if (m = 0) then NONE else SOME ((&n):real / (&m),tokRest)
      | _ => NONE
End

Definition parseIV_def:
  parseIV (input:Token list) :((real # real) # Token list) option =
    case (parseFrac input) of
      | SOME (iv_lo, tokRest) =>
        (case (parseFrac tokRest) of
           | SOME (iv_hi, tokList) => SOME ((iv_lo, iv_hi), tokList)
           | _ => NONE )
      | _ => NONE
End

Theorem parseFrac_LESS_EQ:
  parseFrac xs = SOME (x,y) ⇒ LENGTH y < LENGTH xs
Proof
  fs [parseFrac_def] \\ every_case_tac \\ fs []
QED

Theorem parseIV_LESS_EQ:
  parseIV xs = SOME (x,y) ==> LENGTH y <= LENGTH xs
Proof
  fs [parseIV_def] \\ every_case_tac \\ fs []
  \\ imp_res_tac parseFrac_LESS_EQ \\ fs [] \\ rw [] \\ fs []
QED

(** Precondition parser: *)
(*   The precondition should be encoded in the following format: *)
(*   PRECOND ::= DCOND DVAR DCONST FRACTION FRACTION PRECOND | EPSILON *)
(*   The beginning of the precondition is marked by the DPRE token *)
(* **)
Definition parsePrecondRec_def:
  parsePrecondRec (input:Token list) :(((string#(real#real))list)# Token list) option =
    (case input of
     | VAR x :: fracRest =>
       (case parseIV fracRest of
        | NONE => NONE
        | SOME (iv, precondRest) =>
          (case parsePrecondRec precondRest of
           | NONE => SOME ([(x, iv)], precondRest)
           | SOME (P, tokRest) => SOME ((x, iv)::P, tokRest)))
       | _ => NONE)
Termination
  wf_rel_tac `measure LENGTH` \\ rw []
   \\ imp_res_tac parseIV_LESS_EQ \\ fs []
End

Definition parsePrecond_def:
  parsePrecond (input :Token list) =
    case input of
    | IV :: tokRest => parsePrecondRec tokRest
    | _ => NONE
End

Definition parsePoly_def:
  parsePoly (tokList:Token list) : (poly # Token list) option =
    case tokList of
    | [] => SOME ([], tokList)
    | tok :: tokList1 =>
      case parseFrac tokList of
      | NONE => SOME ([], tokList)
      | SOME (c, tokList2) =>
          case parsePoly tokList2 of
          | NONE => NONE
          | SOME (p, tokList3) => SOME (c::p, tokList3)
Termination
  wf_rel_tac ‘measure LENGTH’ >> rw[]
  >> imp_res_tac parseFrac_LESS_EQ >> gs[]
End

(* Global parsing function for first binary *)
Definition dParse_def:
  dParse (input:Token list) =
    case input of
    | CERTSTART:: tokList =>
      (case tokList of
      | TRANSC :: tokList1 =>
        (case parseTransc tokList1 of
        | NONE => NONE
        | SOME (tr, tokList2) =>
          (case tokList2 of
          | POLY :: tokList3 =>
            (case parsePoly tokList3 of
            | NONE => NONE
            | SOME (p, tokList4) =>
             (case tokList4 of
             | ERR :: tokList5 =>
               (case parseFrac tokList5 of
               | NONE => NONE
               | SOME (err, tokList6) =>
                 (case tokList6 of
                 | IV :: tokList7 =>
                   (case parsePrecond tokList7 of
                   | NONE => NONE
                   | SOME (P, NAPPR :: CONST c :: [CERTEND]) => SOME (tr, p, err, P, c)
                   | _ => NONE)
                 | _ => NONE))
               | _ => NONE))
          | _ => NONE))
      | _ => NONE)
    | _ => NONE
End

Definition parseZeros_def:
  parseZeros (toks:Token list): ((real#real) list # Token list) option =
    case toks of
    | [] => SOME ([], [])
    | tok::toks2 =>
        case parseFrac toks of
        | NONE => NONE
        | SOME (c1, toks3) =>
            case parseFrac toks3 of
            | NONE => NONE
            | SOME (c2, toks4) =>
              case parseZeros toks4 of
              | NONE => NONE
              | SOME (zeros, toks5) => SOME ((c1,c2)::zeros, toks5)
Termination
  wf_rel_tac ‘measure LENGTH’ >> rpt strip_tac
  >> imp_res_tac parseFrac_LESS_EQ >> gs[]
End

(** Global parsing function for second binary **)
Definition parsePolyErr_def:
  parsePolyErr (input:Token list) =
  case input of
    | POLY :: tokList =>
      (case parsePoly tokList of
      | NONE => NONE
      | SOME (p, tokList2) =>
          (case tokList2 of
          | ERR :: tokList3 =>
              (case parseFrac tokList3 of
              | NONE => NONE
              | SOME (err, tokList4) =>
                (case tokList4 of
                 | IV :: tokList5 =>
                     (case parseIV tokList5 of
                      | NONE => NONE
                      | SOME (P, tokList6) =>
                        (case tokList6 of
                         | ZEROS :: tokList7 =>
                             (case parseZeros tokList7 of
                              |NONE => NONE
                              | SOME (zeros, toks) => SOME (p, err, P, zeros))
                         | _ => NONE))
                 | _ => NONE))
          | _ => NONE))
    | _ => NONE
End

val _ = export_theory();
