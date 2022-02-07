
(** File: FPTaylorReal2Float, function: logexp **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG8dot0SEPsp8dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (42582131800516178001712352478316985835652621943879)/(100000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "x");
    poly := [
    (-3762610530094061)/(17592186044416);
    (-2846049735241291)/(17592186044416);
    (1407591977508217)/(70368744177664);
    (3061823667530175)/(562949953421312)
    ];
  eps := (42582131800516178001712352478316985835652621943879)/(100000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-8)/(1),
    (8)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      