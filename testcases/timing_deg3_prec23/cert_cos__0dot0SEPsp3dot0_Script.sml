
(** File: TransBenchsErrorBoundsSmall, function: ex2_3 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot0SEPsp3dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (50361206793868920478087135142270382609774940706213)/(10000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (8350929)/(8388608);
    (2341367)/(33554432);
    (-1408929)/(2097152);
    (37373)/(262144)
    ];
  eps := (50361206793868920478087135142270382609774940706213)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((0)/(1),
    (3)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      