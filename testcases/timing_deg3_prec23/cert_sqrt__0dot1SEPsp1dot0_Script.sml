
(** File: TransBenchsErrorBoundsSmall, function: integrateStoutemyer2007 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sqrt__0dot1SEPsp1dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (40462525291769787316113703505810891951209533657829)/(10000000000000000000000000000000000000000000000000000) *)
Definition sqrt_example_def:
  sqrt_example =
  <|
    transc := Fun Sqrt (Var "x");
    poly := [
    (5855621)/(33554432);
    (3309699)/(2097152);
    (-667495)/(524288);
    (1099625)/(2097152)
    ];
  eps := (40462525291769787316113703505810891951209533657829)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((1)/(10),
    (1)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sqrt_example_def ``20:num``;

val _ = export_theory();
      