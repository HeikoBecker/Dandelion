
(** File: TransBenchsErrorBoundsSmall, function: ex2_4 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG1dot57SEPsp1dot57_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (24229869568354606570970662999965720496333301832237)/(5000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (-6816373)/(2251799813685248);
    (129179)/(131072);
    (439033)/(70368744177664);
    (-4784513)/(33554432)
    ];
  eps := (24229869568354606570970662999965720496333301832237)/(5000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-157)/(100),
    (157)/(100)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      