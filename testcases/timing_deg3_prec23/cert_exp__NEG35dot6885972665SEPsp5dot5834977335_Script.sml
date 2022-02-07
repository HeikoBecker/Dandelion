
(** File: FPTaylorReal2Float, function: hartman6 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG35dot6885972665SEPsp5dot5834977335_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (716199717530123806607770827491073536180235659817)/(10000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e2");
    poly := [
    (-527283)/(1048576);
    (5854289)/(262144);
    (4250307)/(2097152);
    (2739195)/(67108864)
    ];
  eps := (716199717530123806607770827491073536180235659817)/(10000000000000000000000000000000000000000000000) ;
  iv := [("e2",
    ((-71377194533)/(2000000000),
    (11166995467)/(2000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      