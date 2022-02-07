
(** File: TransBenchsErrorBoundsSmall, function: ex2_2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG2dot0SEPsp2dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (145354207925685385944344416581376104427238396688757)/(10000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (-6754393)/(562949953421312);
    (8087269)/(8388608);
    (4562077)/(281474976710656);
    (-541561)/(4194304)
    ];
  eps := (145354207925685385944344416581376104427238396688757)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-2)/(1),
    (2)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      