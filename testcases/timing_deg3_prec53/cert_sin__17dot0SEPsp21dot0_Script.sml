
(** File: TransBenchsErrorBoundsSmall, function: ex2_8 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__17dot0SEPsp21dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (4929364589152371764730172397539341409180802897411)/(250000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (7143981464475445)/(8796093022208);
    (-1153766936718233)/(8796093022208);
    (1972927834610463)/(281474976710656);
    (-6197535664759042800531219086224155034869909286499)/(50000000000000000000000000000000000000000000000000)
    ];
  eps := (4929364589152371764730172397539341409180802897411)/(250000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((17)/(1),
    (21)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      