
(** File: FPTaylorReal2Float, function: hartman6 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG21dot849462813SEPsp8dot796647187_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1528368031780840710077360221514490808116251192739)/(1000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e3");
    poly := [
    (-813310133815219)/(549755813888);
    (3442513700295539)/(35184372088832);
    (3787087710405291)/(70368744177664);
    (2547512783755071)/(1125899906842624)
    ];
  eps := (1528368031780840710077360221514490808116251192739)/(1000000000000000000000000000000000000000000000) ;
  iv := [("e3",
    ((-21849462813)/(1000000000),
    (8796647187)/(1000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      