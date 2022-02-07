open realTheory realLib RealArith stringTheory polyTheory transcTheory;
open preambleDandelion;

val _ = new_theory "hint";

Datatype:
  hint =
    (* EXP_UB_SPLIT n ∧ x IN (l,h) ⇒ h <= 1/2 * n  *)
    EXP_UB_SPLIT num
End

Definition getExpHint_def:
  getExpHint [] = NONE ∧
  getExpHint (h::hs) =
  case h of
  | EXP_UB_SPLIT n => SOME n
  | _ => getExpHint hs
End

val _ = export_theory();
