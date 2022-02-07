
(** File: FPTaylorReal2Float, function: sphere **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG3dot14159265SEPsp3dot14159265_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (30629360594447012402116605847122097642216195528627)/(100000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "lon");
    poly := [
    (2912371)/(4194304);
    (-1270925)/(1125899906842624);
    (-3399775)/(16777216);
    (1030173)/(9007199254740992)
    ];
  eps := (30629360594447012402116605847122097642216195528627)/(100000000000000000000000000000000000000000000000000) ;
  iv := [("lon",
    ((-62831853)/(20000000),
    (62831853)/(20000000)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      