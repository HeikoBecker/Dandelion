
(** File: TransBenchsErrorBoundsSmall, function: pendulum2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG4dot903325SEPsp4dot903325_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (5445706304456857030776899743137117034137911629643)/(500000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "_tmp31");
    poly := [
    (-1725229)/(262144);
    (-1292623)/(262144);
    (5506149)/(2097152);
    (1628481)/(2097152)
    ];
  eps := (5445706304456857030776899743137117034137911629643)/(500000000000000000000000000000000000000000000000) ;
  iv := [("_tmp31",
    ((-196133)/(40000),
    (196133)/(40000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      