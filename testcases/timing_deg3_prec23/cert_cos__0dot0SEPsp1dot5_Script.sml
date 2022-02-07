
(** File: Benchmarks_small, function: rodriguesRotation **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot0SEPsp1dot5_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (27690203198695394336692856388988484817344631258623)/(20000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "theta");
    poly := [
    (4189363)/(4194304);
    (7127989)/(268435456);
    (-2491655)/(4194304);
    (7308093)/(67108864)
    ];
  eps := (27690203198695394336692856388988484817344631258623)/(20000000000000000000000000000000000000000000000000000) ;
  iv := [("theta",
    ((0)/(1),
    (3)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      