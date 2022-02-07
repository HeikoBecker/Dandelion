
(** File: AnalysisSimple, function: e1 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__0dot0SEPsp0dot5_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (2622534086584409606622673711081011862355356757563)/(100000000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "x");
    poly := [
    (2097097)/(2097152);
    (4201171)/(4194304);
    (8121953)/(16777216);
    (7214507)/(33554432)
    ];
  eps := (2622534086584409606622673711081011862355356757563)/(100000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((0)/(1),
    (1)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      