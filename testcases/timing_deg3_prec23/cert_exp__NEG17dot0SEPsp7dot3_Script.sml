
(** File: TransBenchsErrorBoundsSmall, function: ex2_12 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG17dot0SEPsp7dot3_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (29642616576182520135761582000327543662172769262631)/(100000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "x");
    poly := [
    (-584615)/(2048);
    (6606823)/(262144);
    (4540677)/(262144);
    (3916363)/(4194304)
    ];
  eps := (29642616576182520135761582000327543662172769262631)/(100000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-17)/(1),
    (73)/(10)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      