
(** File: TransBenchsErrorBoundsSmall, function: ex3_d **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot0SEPsp7dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1894438289358214397553518095569342466174618387681)/(8000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (3824943)/(16777216);
    (4706799)/(4194304);
    (-4785323)/(8388608);
    (8123817)/(134217728)
    ];
  eps := (1894438289358214397553518095569342466174618387681)/(8000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((0)/(1),
    (7)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      