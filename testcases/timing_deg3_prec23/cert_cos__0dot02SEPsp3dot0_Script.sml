
(** File: Benchmarks_small, function: forwardk2jX **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot02SEPsp3dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (23826874927301221622763085736765392045683731435583)/(5000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "_tmp10");
    poly := [
    (8341449)/(8388608);
    (153761)/(2097152);
    (-5658317)/(8388608);
    (4802929)/(33554432)
    ];
  eps := (23826874927301221622763085736765392045683731435583)/(5000000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp10",
    ((1)/(50),
    (3)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      