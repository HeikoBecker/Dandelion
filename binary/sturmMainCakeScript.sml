open sturmComputeTheory realPolyTheory certParserTheory translateTheory
     checkerTheory;
open ml_translatorLib ml_translatorTheory basis mlstringTheory;
open preambleDandelion;

val _ = new_theory "sturmMainCake";

val _ = translation_extends "translate";

Definition success_msg_def:
  success_msg = implode "Valid error\n"
End

Definition runSturmPipeline_def:
  runSturmPipeline (s:mlstring list) :mlstring =
  let inp = mlstring$concat s;
      tokList = lex (explode inp) in
    case parsePolyErr tokList of
    | NONE => implode "Error: Lex/Parse"
    | SOME (p, err, P, zeros) =>
      let p' = diff p;
          p'' = diff p';
      in
        case sturm_seq_alt p' p'' of
          | NONE => (implode "Failure: Sturm sequence") ^ (implode "\n")
          | SOME sseq =>
              case numZeros p' p'' P sseq of
              | (Invalid s, _) => (implode "Invalid numZeros:") ^ (implode s) ^ (implode "\n")
              | (Valid, nZeros) =>
                  case validateZerosLeqErr p P zeros err nZeros of
                  | (Valid, _) => success_msg
                  | (Invalid s, _) => (implode "Invalid zero IV:") ^ (implode s) ^ (implode "\n")
End

val _ = translate (runSturmPipeline_def |> REWRITE_RULE [success_msg_def])

val main = process_topdecs ‘
  fun main u =
    case TextIO.inputLinesFrom (List.hd (CommandLine.arguments()))
    of Some lines =>
      TextIO.print (runsturmpipeline lines)’;

val _ = append_prog main;

val st = get_ml_prog_state()

Definition valid_runsturmpipeline_output_def:
  valid_runsturmpipeline_output file_content output =
    (runSturmPipeline file_content = output ∧
     (output = success_msg ⇒
     ∃ p err P zeros.
       parsePolyErr (lex (explode (concat file_content))) = SOME (p, err, P, zeros) ∧
       (∀ x. FST P ≤ x ∧ x ≤ SND P ⇒ real$abs (poly p x) ≤ err)))
End

(* Although we have defined valid_runpipeline_output as a relation between
   file_contents and output, it is actually functional (there is only one correct
   output). We prove this below: existence and uniqueness. *)

Theorem valid_runsturmpipeline_output_exists:
  ∃output. valid_runsturmpipeline_output file_chars output
Proof
  gs[valid_runsturmpipeline_output_def, runSturmPipeline_def, CaseEq"option", success_msg_def]
  >> Cases_on ‘parsePolyErr (lex (explode (concat file_chars)))’ >> gs[CaseEq"prod"]
  >- gs[implode_def]
  >> Cases_on ‘x’ >> gs[]
  >> Cases_on ‘r’ >> gs[]
  >> Cases_on ‘r'’ >> gs[]
  >> top_case_tac >> gs[]
  >- gs[implode_def, strcat_def, concat_def]
  >> Cases_on ‘numZeros (diff q) (diff (diff q)) q'' x’ >> gs[CaseEq"checkerDefs$result"]
  >> reverse $ Cases_on ‘q'3'’ >> gs[]
  >- gs[implode_def, strcat_def, concat_def]
  >> top_case_tac >> reverse $ Cases_on ‘q'3'’ >> gs[]
  >- gs[implode_def, strcat_def, concat_def]
  >> rpt strip_tac
  >> irule validateZerosLeqErr_sound >> qexists_tac ‘diff q’
  >> qexists_tac ‘r''’ >> qexists_tac ‘q''’ >> gs[]
  >> qexists_tac ‘r'’ >> qexists_tac ‘r’ >> gs[]
  >> irule numZeros_sound >> reverse conj_tac
  >- real_tac
  >> qexists_tac ‘x’ >> gs[]
  >> irule sturm_seq_alt_sound >> gs[]
QED

Theorem runpipeline_output_spec_def =
  new_specification("runsturmpipeline_output_spec_def",["runsturmpipeline_output_spec"],
    GEN_ALL valid_runsturmpipeline_output_exists |> SIMP_RULE std_ss [SKOLEM_THM]);

Theorem main_spec:
  hasFreeFD fs ∧ inFS_fname fs fname ∧
  cl = [pname; fname] ∧
  contents = all_lines fs fname ==>
  app (p:'ffi ffi_proj) ^(fetch_v "main" st)
    [uv] (STDIO fs * COMMANDLINE cl)
    (POSTv uv. &UNIT_TYPE () uv *
      (STDIO (add_stdout fs (runsturmpipeline_output_spec contents))) * COMMANDLINE cl)
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
  \\ xlet_auto >- xsimpl
  \\ xapp \\ instantiate \\ xsimpl
  \\ CONV_TAC(SWAP_EXISTS_CONV) \\ qexists_tac`fs` \\ xsimpl
  \\ qmatch_abbrev_tac`STDIO (add_stdout _ xxxx) ==>> STDIO (add_stdout _ yyyy) * GC`
  \\ `xxxx = yyyy` suffices_by xsimpl
  (* now let us unabbreviate xxxx and yyyy *)
  \\ unabbrev_all_tac \\ gs[]
  \\ assume_tac (REWRITE_RULE [valid_runsturmpipeline_output_def] runpipeline_output_spec_def)
  \\ gs[all_lines_def]
QED

val main_whole_prog_spec = Q.store_thm("main_whole_prog_spec",
  `hasFreeFD fs ∧ inFS_fname fs fname ∧
   cl = [pname; fname] ∧
  contents = all_lines fs fname ==>
   whole_prog_spec ^(fetch_v "main" st) cl fs NONE
         ((=) (add_stdout fs (runsturmpipeline_output_spec contents)))`,
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

val _ = export_theory();
