
(** File: TransBenchsErrorBoundsSmall, function: forwardk2jX **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG3dot14SEPsp3dot14_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (30583502968799014304055242047225791513118038016217)/(100000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "theta1");
    poly := [
    (5828589)/(8388608);
    (-1267021)/(1125899906842624);
    (-6806445)/(33554432);
    (8224405)/(72057594037927936)
    ];
  eps := (30583502968799014304055242047225791513118038016217)/(100000000000000000000000000000000000000000000000000) ;
  iv := [("theta1",
    ((-157)/(50),
    (157)/(50)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      