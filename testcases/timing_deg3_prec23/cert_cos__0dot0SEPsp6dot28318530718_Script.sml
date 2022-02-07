
(** File: Daisy, function: polarToCarthesian_x **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot0SEPsp6dot28318530718_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (7661335245848499811609873770389478739611431267987)/(25000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "radiant");
    poly := [
    (5476237)/(4194304);
    (-5340353)/(4194304);
    (1699887)/(8388608);
    (3740489)/(1125899906842624)
    ];
  eps := (7661335245848499811609873770389478739611431267987)/(25000000000000000000000000000000000000000000000000) ;
  iv := [("radiant",
    ((0)/(1),
    (314159265359)/(50000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      