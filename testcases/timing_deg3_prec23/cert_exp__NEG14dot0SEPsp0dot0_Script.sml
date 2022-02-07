
(** File: TransBenchsErrorBoundsSmall, function: ex3_d **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG14dot0SEPsp0dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (6252522247171393678557682991348189059301681056341)/(50000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "x");
    poly := [
    (7345063)/(8388608);
    (7482985)/(16777216);
    (8339781)/(134217728);
    (5426941)/(2147483648)
    ];
  eps := (6252522247171393678557682991348189059301681056341)/(50000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-14)/(1),
    (0)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      