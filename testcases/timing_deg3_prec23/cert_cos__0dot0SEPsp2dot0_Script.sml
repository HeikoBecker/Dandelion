
(** File: TransBenchsErrorBoundsSmall, function: ex2_3 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot0SEPsp2dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (7677241946881342854976060187100558777908432962629)/(2500000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (2091405)/(2097152);
    (6588411)/(134217728);
    (-2679083)/(4194304);
    (2182403)/(16777216)
    ];
  eps := (7677241946881342854976060187100558777908432962629)/(2500000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((0)/(1),
    (2)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      