
(** File: TransBenchsErrorBoundsSmall, function: ex3_c **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG2dot0SEPsp0dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1403350638693353355226676085825238347558952701479)/(625000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "x");
    poly := [
    (8371547)/(8388608);
    (505373)/(524288);
    (3337729)/(8388608);
    (4432313)/(67108864)
    ];
  eps := (1403350638693353355226676085825238347558952701479)/(625000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-2)/(1),
    (0)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      