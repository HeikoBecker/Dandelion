open translateTheory;
open ml_translatorLib ml_translatorTheory basis stringTheory mlstringTheory;
open preambleDandelion;

val _ = new_theory "polyApproxMainCake";

val _ = translation_extends "translate";

(*
Definition runApproxPipeline_def:
  runApproxPipeline (s:mlstring list) =
  let inp = mlstring$concat s;
      tokList = lex (explode inp) in
    case dParse tokList of
    | NONE => NONE
    | SOME (tr, p , err, P, nappr) =>
        SOME (approxPipeline <| transc := tr; poly := p; eps := err; iv := P |> nappr)
End

val _ = translate runApproxPipeline_def;

val polyToString = process_topdecs ‘
  fun polyToString p =
    case p of
    [] => ""
    | c::cs =>
        (Rat.toString c) ^ (" " ^ (polyToString cs))’;

val _ = append_prog polyToString;

(** TODO: Define polyToString **)
val runPipeline = process_topdecs‘
  fun runPipeline s =
    case runapproxpipeline s of
    None => "Error in parsing"
    | Some None => "Error running pipeline"
    | Some (Some (p, err)) =>
      String.concat (
        String.concat (String.concat "POLY " (polyToString p)) "ERR ")
        (Rat.toString err)’;

val _ = append_prog runPipeline;

val main = process_topdecs ‘
  fun main u =
    case TextIO.inputLinesFrom (List.hd (CommandLine.arguments()))
    of Some lines =>
      TextIO.print (runPipeline lines)’;

val _ = append_prog main;

Definition POLY_STRING_TYPE_def:
  POLY_STRING_TYPE p vs =
    ∃ s. STRING_TYPE s vs ∧ parsePoly (lex (explode s)) = SOME (p, [])
End

val st = get_ml_prog_state()

Theorem polyToString_spec:
  ∀ p vp pffi.
    LIST_TYPE REAL_TYPE p vp ⇒
    app (pffi:'ffi ffi_proj) ^(fetch_v "polyToString" st)
        [vp] (emp)
        (POSTv vs. &POLY_STRING_TYPE p vs)
Proof
  Induct_on ‘p’ >>
  rpt strip_tac >> xcf "polyToString" st
  >> xmatch >> gs[LIST_TYPE_def]
  >- (
    reverse conj_tac >- (EVAL_TAC >> gs[])
    >> xlit >> xsimpl >> gs[POLY_STRING_TYPE_def] >> EVAL_TAC)
  >> ntac 2 (reverse conj_tac >- (EVAL_TAC >> gs[]))
  >> first_x_assum $ qspecl_then [‘v2_2’, ‘pffi’] mp_tac
  >> impl_tac >- gs[]
  >> strip_tac
  >> xlet_auto >- xsimpl
  >> gs[POLY_STRING_TYPE_def]
  >> xlet_auto >- xsimpl
  >> gs[RatProgTheory.REAL_TYPE_def, RatProgTheory.RAT_TYPE_def]
  >> xlet_auto >- xsimpl
  >> xapp >> xsimpl
  (* HACK to get correct type... *)
  >> pop_assum mp_tac
  >> pop_assum (fn thm => thm |> concl |> rator |> rand |> (fn t => rpt strip_tac >> qexists_tac ‘^t’ >> assume_tac thm))
  >> qexists_tac ‘toString (RatPair n d)’
  >> gs[]
  >> rpt strip_tac
  (* Again... *)
  >> pop_assum (fn thm => thm |> concl |> rator |> rand |> (fn t => rpt strip_tac >> qexists_tac ‘^t’ >> assume_tac thm))
  >> gs[]
  >> cheat (** TODO: Parser correctness ?? **)
QED

Definition valid_runpipeline_output_def:
  valid_runpipeline_output file_content (output:mlstring) =
     case runApproxPipeline file_content of
     | NONE => output = implode "Error in parsing"
     | SOME (NONE) => output = implode "Error running pipeline"
     | SOME (SOME (p, err)) =>
       case parsePoly (lex (explode output)) of
       | NONE => F
       | SOME (p2, toks) => p = p2 ∧ parseFrac toks = SOME (err, [])
End

(* Although we have defined valid_runpipeline_output as a relation between
   file_contents and output, it is actually functional (there is only one correct
   output). We prove this below: existence and uniqueness. *)

val valid_runpipeline_output_exists = Q.store_thm("valid_runpipeline_output_exists",
  `∃output. valid_runpipeline_output file_chars output`,
  fs[valid_runpipeline_output_def]
  >> Cases_on ‘runApproxPipeline file_chars’ >> gs[]
  >> Cases_on ‘x’ >> gs[]
    >> Cases_on ‘x'’ >> gs[]
>> qexists_tac ‘implode "FIXME"’ >> gs[isEq_frac_string_def]);

val runpipeline_output_spec_def =
  new_specification("runpipeline_output_spec_def",["runpipeline_output_spec"],
    GEN_ALL valid_runpipeline_output_exists |> SIMP_RULE std_ss [SKOLEM_THM]);

(* -- I/O routines from here onwards -- *)

(* Specification of the runchecker function:
   Running the checker on an input file inp appends the result of running
   the function to STDOUT *)

Theorem runPipeline_spec:
  LIST_TYPE STRING_TYPE s sv ⇒
  app (p:'ffi ffi_proj) ^(fetch_v "runPipeline" st) [sv] (emp)
      (POSTv rv. &(∃ rs. STRING_TYPE rs rv ∧ valid_runpipeline_output s rs))
Proof
  xcf "runPipeline" st
  >> xlet_auto >- xsimpl
  >> xmatch >> Cases_on ‘runApproxPipeline s’ >> gs[OPTION_TYPE_def]
  >- (
    reverse conj_tac
    >- (EVAL_TAC >> gs[])
    >> xlit >> gs[valid_runpipeline_output_def] >> xsimpl >> EVAL_TAC)
  >> Cases_on ‘x’ >> gs[OPTION_TYPE_def]
  >- (
    ntac 2 (reverse conj_tac
            >- (EVAL_TAC >> gs[]))
    >> xlit >> gs[valid_runpipeline_output_def] >> xsimpl >> EVAL_TAC)
  >> ntac 3 (reverse conj_tac >- (EVAL_TAC >> gs[]))
  >> xlet_auto >- xsimpl
  >> xapp >> xsimpl
  >> gs[RatProgTheory.REAL_TYPE_def, RatProgTheory.RAT_TYPE_def]
  >> qexists_tac ‘RatPair n d’ >> gs[]
  >> rpt strip_tac
  >> qexists_tac ‘toString (RatPair n d)’ >> gs[valid_runpipeline_output_def, isEq_frac_string_def]
QED

Theorem main_spec:
  hasFreeFD fs ∧ inFS_fname fs fname ∧
  cl = [pname; fname] ∧
  contents = all_lines fs fname ==>
  app (p:'ffi ffi_proj) ^(fetch_v "main" st)
    [uv] (STDIO fs * COMMANDLINE cl)
    (POSTv uv. &UNIT_TYPE () uv *
      (STDIO (add_stdout fs (runpipeline_output_spec contents))) * COMMANDLINE cl)
Proof
  xcf "main" st
  \\ xlet_auto
  >- (xcon \\ xsimpl \\ EVAL_TAC)
  \\ xlet_auto >- xsimpl
  \\ xlet_auto >- xsimpl
  \\ reverse(Cases_on`wfcl cl`)
  >- (rfs[COMMANDLINE_def] \\ xpull)
  \\ reverse (Cases_on `STD_streams fs`) >-(fs[STDIO_def] \\ xpull)
  \\ xlet_auto_spec (SOME inputLinesFrom_spec)
  >- (xsimpl \\ rfs[wfcl_def, validArg_def, EVERY_MEM])
  \\ xmatch \\ fs[OPTION_TYPE_def]
  \\ reverse conj_tac >- (EVAL_TAC \\ fs[])
  \\ xlet_auto_spec (SOME runPipeline_spec) >- xsimpl
  >- (xsimpl)
  \\ xapp \\ instantiate \\ xsimpl
  \\ CONV_TAC(SWAP_EXISTS_CONV) \\ qexists_tac`fs` \\ xsimpl
  \\ qmatch_abbrev_tac`STDIO (add_stdout _ xxxx) ==>> STDIO (add_stdout _ yyyy) * GC`
  \\ `xxxx = yyyy` suffices_by xsimpl
  (* now let us unabbreviate xxxx and yyyy *)
  \\ map_every qunabbrev_tac[`xxxx`,`yyyy`] \\ simp[]
  \\ assume_tac (REWRITE_RULE [valid_runchecker_output_def] runchecker_output_spec_def)
  \\ fs[all_lines_def]);

val main_whole_prog_spec = Q.store_thm("main_whole_prog_spec",
  `hasFreeFD fs ∧ inFS_fname fs fname ∧
   cl = [pname; fname] ∧
  contents = all_lines fs fname ==>
   whole_prog_spec ^(fetch_v "main" st) cl fs NONE
         ((=) (add_stdout fs (runchecker_output_spec contents)))`,
  disch_then assume_tac
  \\ simp[whole_prog_spec_def]
  \\ qmatch_goalsub_abbrev_tac`fs1 = _ with numchars := _`
  \\ qexists_tac`fs1`
  \\ simp[Abbr`fs1`,GSYM add_stdo_with_numchars,with_same_numchars]
  \\ match_mp_tac (MP_CANON (MATCH_MP app_wgframe (UNDISCH main_spec)))
  \\ xsimpl);

val (sem_thm,prog_tm) = whole_prog_thm (get_ml_prog_state ()) "main" (UNDISCH main_whole_prog_spec);

val main_prog_def = Define `main_prog = ^prog_tm`;

val main_semantics =
  sem_thm |> ONCE_REWRITE_RULE[GSYM main_prog_def]
  |> DISCH_ALL |> Q.GENL[`cl`,`contents`]
  |> SIMP_RULE(srw_ss())[AND_IMP_INTRO,GSYM CONJ_ASSOC]
  |> curry save_thm "main_semantics";


    fun eval t = Parse.Term t |> EVAL
    fun getSome t = if optionSyntax.is_some t then optionSyntax.dest_some t else raise ZeroLibErr "Found NONE instead of SOME"
    (* extract components from certificate *)
    val (transc, poly, eps, iv) = destCert (defTh |> concl |> rhs)
    val ivTm = eval ‘if (LENGTH ^iv = 1) then SOME (SND (HD ^iv)) else NONE’
      |> rhs o concl |> getSome
    val var = eval ‘if (LENGTH ^iv = 1) then SOME (FST (HD ^iv)) else NONE’
      |> rhs o concl |> getSome
    val iv_FST = EVAL “FST ^ivTm”
    val iv_SND = EVAL “SND ^ivTm”
    val approxSideThm = eval ‘approxPolySideCond ^numApprox’ |> SIMP_RULE std_ss [EQ_CLAUSES]
    val ivAnnotThm = eval ‘interpIntv ^transc ^iv’
    val ivAnnotTm = ivAnnotThm  |> rhs o concl |> getSome
    val ivSoundThm = MATCH_MP interpIntv_sound ivAnnotThm
    val approxThm = eval ‘approxTransc (^approxCfg with steps := ^numApprox) ^ivAnnotTm’
    val approxTm = approxThm |> rhs o concl |> getSome
    val length1Thm = eval ‘LENGTH ^iv = 1’ |> REWRITE_RULE [EQ_CLAUSES]
    val approxSoundThm =
      MATCH_MP
        (MATCH_MP
          (MATCH_MP
            (REWRITE_RULE [GSYM AND_IMP_INTRO] approxTransc_sound_single)
            length1Thm)
          ivSoundThm)
        approxThm
      |> SIMP_RULE std_ss [erase_def, getAnn_def]
    val transpThm = eval ‘reflectToPoly (erase (^approxTm)) ^var’
    val reflectOkThm = MATCH_MP reflectSemEquiv transpThm |> REWRITE_RULE [erase_def]
    val varEqThm = EVAL “FST (HD ^iv)”
    val ivEqThm = EVAL “SND (HD ^iv)”
    val approxSoundPolyThm = REWRITE_RULE [varEqThm, ivEqThm, reflectOkThm, optionGet_SOME, AND_IMP_INTRO] approxSoundThm
    val transpTm = transpThm |> rhs o concl |> getSome
    val transpGetThm = Q.ISPEC ‘^(transpThm |> lhs o concl)’ optionGet_def
                     |> SIMP_RULE std_ss [SimpR “$=”, transpThm]
    val err = Parse.Term ‘getAnn ^approxTm’ |> EVAL |> concl |> rhs
    val errorpThm = Parse.Term ‘^transpTm -p ^poly’ |> EVAL
    val errorp = errorpThm |> rhs o concl
    val polyErrThm = (testSollya();
     REAL_ZERO_CONV (Parse.Term ‘! x. FST (^ivTm) <= x /\ x <= SND (^ivTm) ==> evalPoly ^errorp x <= ^eps - ^err’))
    val polyErrThm_simped = REWRITE_RULE [GSYM errorpThm, eval_simps, GSYM poly_compat, Once $ GSYM transpGetThm, Once $ GSYM iv_FST, transpThm, optionGet_SOME] polyErrThm
    val final_thm = MATCH_MP (MATCH_MP REAL_ABS_TRIANGLE_PRE approxSoundPolyThm) polyErrThm_simped
*)

val _ = export_theory();
