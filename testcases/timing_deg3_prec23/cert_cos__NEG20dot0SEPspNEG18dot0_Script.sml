
(** File: TransBenchsErrorBoundsSmall, function: ex2_10 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG20dot0SEPspNEG18dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (6123800649756841461044316698250901157379748346971)/(1250000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (-2614261)/(8192);
    (-1383013)/(32768);
    (-7443753)/(4194304);
    (-6217445)/(268435456)
    ];
  eps := (6123800649756841461044316698250901157379748346971)/(1250000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-20)/(1),
    (-18)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      