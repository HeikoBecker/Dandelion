
(** File: Daisy, function: polarToCarthesian_y **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot0SEPsp6dot28318530718_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (53424068487366710229172560999425458467712688862103)/(500000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "radiant");
    poly := [
    (-3514173)/(33554432);
    (3668031)/(2097152);
    (-6871901)/(8388608);
    (5833051)/(67108864)
    ];
  eps := (53424068487366710229172560999425458467712688862103)/(500000000000000000000000000000000000000000000000000) ;
  iv := [("radiant",
    ((0)/(1),
    (314159265359)/(50000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      