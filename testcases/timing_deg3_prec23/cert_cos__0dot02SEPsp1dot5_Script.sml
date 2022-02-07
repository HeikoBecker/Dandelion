
(** File: Benchmarks_small, function: xu1 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot02SEPsp1dot5_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (131130429750007410687188401403153137642515687533437)/(100000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x1");
    poly := [
    (8374765)/(8388608);
    (3901651)/(134217728);
    (-5011555)/(8388608);
    (3697251)/(33554432)
    ];
  eps := (131130429750007410687188401403153137642515687533437)/(100000000000000000000000000000000000000000000000000000) ;
  iv := [("x1",
    ((1)/(50),
    (3)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      