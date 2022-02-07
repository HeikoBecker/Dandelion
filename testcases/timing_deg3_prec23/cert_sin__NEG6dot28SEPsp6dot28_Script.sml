
(** File: TransBenchsErrorBoundsSmall, function: forwardk2jY **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG6dot28SEPsp6dot28_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (871639505649289955564168354742552695429274087697)/(1000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "_tmp37");
    poly := [
    (-4376087)/(35184372088832);
    (3280107)/(33554432);
    (5132465)/(140737488355328);
    (-6452363)/(1073741824)
    ];
  eps := (871639505649289955564168354742552695429274087697)/(1000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp37",
    ((-157)/(25),
    (157)/(25)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      