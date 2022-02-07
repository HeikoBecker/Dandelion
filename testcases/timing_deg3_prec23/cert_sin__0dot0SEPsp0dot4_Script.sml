
(** File: FPTaylorReal2Float, function: azimuth **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot0SEPsp0dot4_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (83483056751559421124656271101994678593027173406957)/(50000000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "lat1");
    poly := [
    (-3662379)/(2199023255552);
    (1048701)/(1048576);
    (-1385923)/(1073741824);
    (-5464563)/(33554432)
    ];
  eps := (83483056751559421124656271101994678593027173406957)/(50000000000000000000000000000000000000000000000000000000) ;
  iv := [("lat1",
    ((0)/(1),
    (2)/(5)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      