
(** File: Benchmarks_small, function: rodriguesRotation **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot0SEPsp1dot5_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (13845097822231056260080631497621729862297613723713)/(10000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "theta");
    poly := [
    (1124573578404505)/(1125899906842624);
    (13276880421573081583752617973459564382210373878479)/(500000000000000000000000000000000000000000000000000);
    (-668848461408279)/(1125899906842624);
    (544495246986712380654616083575092488899827003479)/(5000000000000000000000000000000000000000000000000)
    ];
  eps := (13845097822231056260080631497621729862297613723713)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("theta",
    ((0)/(1),
    (3)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      