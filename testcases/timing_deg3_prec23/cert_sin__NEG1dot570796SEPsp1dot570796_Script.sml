
(** File: FPTaylorReal2Float, function: sphere **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG1dot570796SEPsp1dot570796_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (48570566363158314159369476091892570047333015604693)/(10000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "lat");
    poly := [
    (-1708909)/(562949953421312);
    (8267221)/(8388608);
    (7037945)/(1125899906842624);
    (-2391873)/(16777216)
    ];
  eps := (48570566363158314159369476091892570047333015604693)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("lat",
    ((-392699)/(250000),
    (392699)/(250000)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      