
(** File: Herbie, function: complex_sine_cosine **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__0dot0SEPsp10dot0_";

val _ = realZeroLib.useBinary := true;

(* err = 317.32555475365841311005639385852485896035201568312 *)
(* infnorm = 261.69107088726626224227052389782222376393724141283 *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "im");
    poly := [
    (-4586091146038891)/(17592186044416);
    (869048156427439)/(549755813888);
    (-6720449918431673)/(4398046511104);
    (572663775683633)/(1099511627776);
    (-5152046146892293)/(70368744177664);
    (18516901734488027120306696815532632172107696533203)/(5000000000000000000000000000000000000000000000000)
    ];
  eps := (3966569434420730163875704923231560737004400196039)/(12500000000000000000000000000000000000000000000) ;
  iv := [("im",
    ((0)/(1),
    (10)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``32:num``;

val _ = export_theory();
      