
(** File: TransBenchsErrorBoundsSmall, function: stoutemyerEq2007 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG1dot0ENEG8SEPsp1dot0ENEG8_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (119209289550926769147946919040019035225621386775523)/(10000000000000000000000000000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "x");
    poly := [
    (1)/(1);
    (1)/(1);
    (1)/(2);
    (5592405)/(33554432)
    ];
  eps := (119209289550926769147946919040019035225621386775523)/(10000000000000000000000000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-1)/(100000000),
    (1)/(100000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      