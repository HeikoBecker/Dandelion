
(** File: TransBenchsErrorBoundsSmall, function: ex2_11 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG1dot1SEPsp0dot9_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (3192011883236571482683566918809019223741975773841)/(625000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (8350271)/(8388608);
    (8044619)/(1073741824);
    (-1937897)/(4194304);
    (-2070775)/(134217728)
    ];
  eps := (3192011883236571482683566918809019223741975773841)/(625000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-11)/(10),
    (9)/(10)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      