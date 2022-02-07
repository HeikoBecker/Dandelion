
(** File: Benchmarks_small, function: forwardk2jX **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot01SEPsp1dot5_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (134749426989659572577520826820157803339818303551313)/(100000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "theta1");
    poly := [
    (8376775)/(8388608);
    (1865991)/(67108864);
    (-4997423)/(8388608);
    (1837843)/(16777216)
    ];
  eps := (134749426989659572577520826820157803339818303551313)/(100000000000000000000000000000000000000000000000000000) ;
  iv := [("theta1",
    ((1)/(100),
    (3)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      