
(** File: Daisy, function: carthesianToPolar_radius **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sqrt__2dot0SEPsp20000dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (30175857876530689024760774909619147005104945699923)/(5000000000000000000000000000000000000000000000000) *)
Definition sqrt_example_def:
  sqrt_example =
  <|
    transc := Fun Sqrt (Var "_tmp");
    poly := [
    (1936525)/(262144);
    (10333)/(524288);
    (-6190393)/(4398046511104);
    (5564411)/(144115188075855872)
    ];
  eps := (30175857876530689024760774909619147005104945699923)/(5000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp",
    ((2)/(1),
    (20000)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sqrt_example_def ``20:num``;

val _ = export_theory();
      