
(** File: CompoundFunction, function: testDepth2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG4dot0SEPsp2dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (6551275872113959011059691519076730234310137913677)/(25000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "x");
    poly := [
    (1720849)/(2097152);
    (1332301)/(1048576);
    (2985389)/(4194304);
    (1931365)/(16777216)
    ];
  eps := (6551275872113959011059691519076730234310137913677)/(25000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-4)/(1),
    (2)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      