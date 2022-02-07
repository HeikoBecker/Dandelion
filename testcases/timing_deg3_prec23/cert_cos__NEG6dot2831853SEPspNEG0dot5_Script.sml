
(** File: FPTaylorReal2Float, function: azimuth **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG6dot2831853SEPspNEG0dot5_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (11630715481345764490404482203213965983249561107581)/(50000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "dLon");
    poly := [
    (2140633)/(1048576);
    (2182697)/(1048576);
    (3722071)/(8388608);
    (2839599)/(134217728)
    ];
  eps := (11630715481345764490404482203213965983249561107581)/(50000000000000000000000000000000000000000000000000) ;
  iv := [("dLon",
    ((-62831853)/(10000000),
    (-1)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      