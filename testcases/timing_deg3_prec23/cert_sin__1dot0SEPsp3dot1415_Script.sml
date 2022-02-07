
(** File: TransBenchsErrorBoundsSmall, function: ex2_9 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__1dot0SEPsp3dot1415_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (61675331147526422958616220896456271453395671652803)/(10000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (-524057)/(1048576);
    (4437419)/(2097152);
    (-3580403)/(4194304);
    (4916867)/(67108864)
    ];
  eps := (61675331147526422958616220896456271453395671652803)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((1)/(1),
    (6283)/(2000)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      