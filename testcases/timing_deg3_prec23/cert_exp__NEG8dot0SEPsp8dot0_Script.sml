
(** File: FPTaylorReal2Float, function: logexp **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG8dot0SEPsp8dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (4258212852493991380414759648139699841984739092031)/(10000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "x");
    poly := [
    (-7008409)/(32768);
    (-5301181)/(32768);
    (5243689)/(262144);
    (5703091)/(1048576)
    ];
  eps := (4258212852493991380414759648139699841984739092031)/(10000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-8)/(1),
    (8)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      