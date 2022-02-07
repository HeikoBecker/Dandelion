
(** File: TransBenchsErrorBoundsSmall, function: ex2_10 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG20dot0SEPspNEG18dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1235282991380161237921234534532037315471589320169)/(1250000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (-8253941)/(8192);
    (-5319951)/(32768);
    (-2271737)/(262144);
    (-5142235)/(33554432)
    ];
  eps := (1235282991380161237921234534532037315471589320169)/(1250000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-20)/(1),
    (-18)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      