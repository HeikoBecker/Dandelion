
(** File: TransBenchsErrorBoundsSmall, function: forwardk2jX **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG6dot28SEPsp6dot28_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (625000627837460309787253069040736906225512319621)/(625000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "_tmp40");
    poly := [
    (4725293)/(2199023255552);
    (-7195195)/(140737488355328);
    (-140897)/(1099511627776);
    (5838123)/(4503599627370496)
    ];
  eps := (625000627837460309787253069040736906225512319621)/(625000000000000000000000000000000000000000000000) ;
  iv := [("_tmp40",
    ((-157)/(25),
    (157)/(25)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      