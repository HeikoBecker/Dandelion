
(** File: TransBenchsErrorBoundsSmall, function: ex2_6 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_tan__NEG1dot0SEPsp1dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (8281332414251417126288360055905115139538541086357)/(400000000000000000000000000000000000000000000000000) *)
Definition tan_example_def:
  tan_example =
  <|
    transc := Fun Tan (Var "x");
    poly := [
    (-2156889)/(18014398509481984);
    (7620431)/(8388608);
    (2142793)/(2251799813685248);
    (5274949)/(8388608)
    ];
  eps := (8281332414251417126288360055905115139538541086357)/(400000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-1)/(1),
    (1)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert tan_example_def ``20:num``;

val _ = export_theory();
      