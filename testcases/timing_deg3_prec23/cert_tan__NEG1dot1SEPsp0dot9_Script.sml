
(** File: TransBenchsErrorBoundsSmall, function: ex2_11 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_tan__NEG1dot1SEPsp0dot9_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (42447475054917405327059054328225186387176343779069)/(1000000000000000000000000000000000000000000000000000) *)
Definition tan_example_def:
  tan_example =
  <|
    transc := Fun Tan (Var "x");
    poly := [
    (-2443861)/(17179869184);
    (6976751)/(8388608);
    (4248359)/(4294967296);
    (6360383)/(8388608)
    ];
  eps := (42447475054917405327059054328225186387176343779069)/(1000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-11)/(10),
    (9)/(10)))];
  |>
End

Theorem checkerSucceeds = validateCert tan_example_def ``20:num``;

val _ = export_theory();
      