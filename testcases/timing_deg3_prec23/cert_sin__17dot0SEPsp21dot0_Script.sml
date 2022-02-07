
(** File: TransBenchsErrorBoundsSmall, function: ex2_8 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__17dot0SEPsp21dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (2465275924092630091239425477255090130494953936223)/(125000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (3326655)/(4096);
    (-4298091)/(32768);
    (3674843)/(524288);
    (-129971)/(1048576)
    ];
  eps := (2465275924092630091239425477255090130494953936223)/(125000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((17)/(1),
    (21)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      