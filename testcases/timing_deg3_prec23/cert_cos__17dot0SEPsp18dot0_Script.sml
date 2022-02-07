
(** File: TransBenchsErrorBoundsSmall, function: ex2_5 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__17dot0SEPsp18dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (18610511941501092516474561460858004776762518275009)/(250000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (3299487)/(4096);
    (-1162333)/(8192);
    (1084097)/(131072);
    (-5354955)/(33554432)
    ];
  eps := (18610511941501092516474561460858004776762518275009)/(250000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((17)/(1),
    (18)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      