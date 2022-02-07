
(** File: TransBenchsErrorBoundsSmall, function: rodriguesRotation **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG5dot0SEPsp5dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (5415561553902577522317463789068784705961835241659)/(6250000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "theta");
    poly := [
    (2243413)/(16777216);
    (-2554573)/(2251799813685248);
    (-7691619)/(268435456);
    (6539707)/(144115188075855872)
    ];
  eps := (5415561553902577522317463789068784705961835241659)/(6250000000000000000000000000000000000000000000000) ;
  iv := [("theta",
    ((-5)/(1),
    (5)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      