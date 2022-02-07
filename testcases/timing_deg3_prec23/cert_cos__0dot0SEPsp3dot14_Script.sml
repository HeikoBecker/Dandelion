
(** File: TransBenchsErrorBoundsSmall, function: integrate18257 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot0SEPsp3dot14_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (50615470283112847903865956577614446596568214630783)/(10000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (8350929)/(8388608);
    (4682743)/(67108864);
    (-5635717)/(8388608);
    (4783745)/(33554432)
    ];
  eps := (50615470283112847903865956577614446596568214630783)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((0)/(1),
    (157)/(50)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      