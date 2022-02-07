
(** File: TransBenchsErrorBoundsSmall, function: xu2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG9dot42SEPsp9dot42_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1250000131356710882912907532296216319815809021529)/(1250000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x2");
    poly := [
    (-4647653)/(562949953421312);
    (4622603)/(562949953421312);
    (167099)/(281474976710656);
    (-5246419)/(18014398509481984)
    ];
  eps := (1250000131356710882912907532296216319815809021529)/(1250000000000000000000000000000000000000000000000) ;
  iv := [("x2",
    ((-471)/(50),
    (471)/(50)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      