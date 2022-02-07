
(** File: FPTaylorReal2Float, function: hartman6 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG21dot849462813SEPsp8dot796647187_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (2388074822584668641732814422592697650882035074253)/(1562500000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e3");
    poly := [
    (-378727)/(256);
    (6412181)/(65536);
    (440875)/(8192);
    (593139)/(262144)
    ];
  eps := (2388074822584668641732814422592697650882035074253)/(1562500000000000000000000000000000000000000000) ;
  iv := [("e3",
    ((-21849462813)/(1000000000),
    (8796647187)/(1000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      