
(** File: TransBenchsErrorBoundsSmall, function: rodriguesRotation **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG5dot0SEPsp5dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1362161990087581612708813236111204430882175959191)/(2500000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "theta");
    poly := [
    (-5329121)/(144115188075855872);
    (6185109)/(16777216);
    (8156691)/(576460752303423488);
    (-224555)/(8388608)
    ];
  eps := (1362161990087581612708813236111204430882175959191)/(2500000000000000000000000000000000000000000000000) ;
  iv := [("theta",
    ((-5)/(1),
    (5)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      