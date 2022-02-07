
(** File: Analysis2, function: ex2_7 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG1dot57079632679SEPsp1dot57079632679_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (28346377840577601345049155075108603139493751355867)/(1000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (8153687)/(8388608);
    (-461167)/(36028797018963968);
    (-3399775)/(8388608);
    (5980925)/(1152921504606846976)
    ];
  eps := (28346377840577601345049155075108603139493751355867)/(1000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-157079632679)/(100000000000),
    (157079632679)/(100000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      