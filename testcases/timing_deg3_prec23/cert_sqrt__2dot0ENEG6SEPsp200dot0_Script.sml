
(** File: Herbie, function: complex_square_root **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sqrt__2dot0ENEG6SEPsp200dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (13027515769659089706249823012668930190580409643569)/(20000000000000000000000000000000000000000000000000) *)
Definition sqrt_example_def:
  sqrt_example =
  <|
    transc := Fun Sqrt (Var "_tmp1");
    poly := [
    (341021)/(524288);
    (3401431)/(16777216);
    (-6341759)/(4294967296);
    (4488033)/(1099511627776)
    ];
  eps := (13027515769659089706249823012668930190580409643569)/(20000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp1",
    ((1)/(500000),
    (200)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sqrt_example_def ``20:num``;

val _ = export_theory();
      