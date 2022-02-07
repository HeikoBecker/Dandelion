
(** File: Herbie, function: complex_sine_cosine **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG10dot0SEPsp10dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (5000000108473589699675227276667697930042811048151)/(5000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "re");
    poly := [
    (-2247671)/(2305843009213693952);
    (6450665)/(4503599627370496);
    (6063293)/(1152921504606846976);
    (-4851787)/(72057594037927936)
    ];
  eps := (5000000108473589699675227276667697930042811048151)/(5000000000000000000000000000000000000000000000000) ;
  iv := [("re",
    ((-10)/(1),
    (10)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      