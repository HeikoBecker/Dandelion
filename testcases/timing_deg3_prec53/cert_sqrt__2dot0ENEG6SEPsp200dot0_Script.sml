
(** File: Herbie, function: complex_square_root **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sqrt__2dot0ENEG6SEPsp200dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (13027510791159946510989351823823099214388778534723)/(20000000000000000000000000000000000000000000000000) *)
Definition sqrt_example_def:
  sqrt_example =
  <|
    transc := Fun Sqrt (Var "_tmp1");
    poly := [
    (65044641401820346704454323116806335747241973876953)/(100000000000000000000000000000000000000000000000000);
    (202741054640351581195290009418386034667491912841797)/(1000000000000000000000000000000000000000000000000000);
    (-29531111029133224124554324419023032533004879951477)/(20000000000000000000000000000000000000000000000000000);
    (40818416182308516507127801875576267320866463705897)/(10000000000000000000000000000000000000000000000000000000)
    ];
  eps := (13027510791159946510989351823823099214388778534723)/(20000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp1",
    ((1)/(500000),
    (200)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sqrt_example_def ``20:num``;

val _ = export_theory();
      