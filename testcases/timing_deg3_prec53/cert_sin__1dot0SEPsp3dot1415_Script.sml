
(** File: TransBenchsErrorBoundsSmall, function: ex2_9 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__1dot0SEPsp3dot1415_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (3854718495509313398750894450962528696476740755813)/(625000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (-49978023494250467528843273612437769770622253417969)/(100000000000000000000000000000000000000000000000000);
    (10579635446010964283658495332929305732250213623047)/(5000000000000000000000000000000000000000000000000);
    (-21340874614441115997287568006868241354823112487793)/(25000000000000000000000000000000000000000000000000);
    (73267086568272798974277293382328934967517852783203)/(1000000000000000000000000000000000000000000000000000)
    ];
  eps := (3854718495509313398750894450962528696476740755813)/(625000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((1)/(1),
    (6283)/(2000)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      