
(** File: TransBenchsErrorBoundsSmall, function: pendulum2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG2dot005SEPsp2dot0027015115293407_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (73504697155267876577256801370828722385645354885833)/(5000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "_tmp32");
    poly := [
    (-6495437)/(562949953421312);
    (8084471)/(8388608);
    (1090781)/(70368744177664);
    (-4326835)/(33554432)
    ];
  eps := (73504697155267876577256801370828722385645354885833)/(5000000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp32",
    ((-401)/(200),
    (3607746312423147149)/(1801439850948198400)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      