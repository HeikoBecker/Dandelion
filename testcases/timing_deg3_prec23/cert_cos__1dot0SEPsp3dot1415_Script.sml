
(** File: TransBenchsErrorBoundsSmall, function: ex2_9 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__1dot0SEPsp3dot1415_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (7190978463254452920880409791770468202650258966697)/(2000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (4505393)/(4194304);
    (-6582991)/(134217728);
    (-1291423)/(2097152);
    (281423)/(2097152)
    ];
  eps := (7190978463254452920880409791770468202650258966697)/(2000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((1)/(1),
    (6283)/(2000)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      