
(** File: TransBenchsErrorBoundsSmall, function: pendulum2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__1dot0SEPsp5dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (8524784318355429135823674606385343434690522019849)/(125000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "w");
    poly := [
    (2270619)/(1048576);
    (-1855999)/(1048576);
    (3272719)/(16777216);
    (4636513)/(268435456)
    ];
  eps := (8524784318355429135823674606385343434690522019849)/(125000000000000000000000000000000000000000000000000) ;
  iv := [("w",
    ((1)/(1),
    (5)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      