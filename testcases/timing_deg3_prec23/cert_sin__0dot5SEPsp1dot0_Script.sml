
(** File: FPTaylorReal2Float, function: azimuth **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot5SEPsp1dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1383696781327959091631781041549279328082785461537)/(100000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "lat2");
    poly := [
    (-3565453)/(536870912);
    (1085721)/(1048576);
    (-4425695)/(67108864);
    (-4072767)/(33554432)
    ];
  eps := (1383696781327959091631781041549279328082785461537)/(100000000000000000000000000000000000000000000000000000) ;
  iv := [("lat2",
    ((1)/(2),
    (1)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      