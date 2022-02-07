
(** File: TransBenchsErrorBoundsSmall, function: forwardk2jY **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG3dot14SEPsp3dot14_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (105339837627011931281912870060829938945227355044593)/(1000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "theta1");
    poly := [
    (-187590340396809329703842195158358663320541381835937)/(1000000000000000000000000000000000000000000000000000000000000000);
    (6919019)/(8388608);
    (702535)/(4611686018427387904);
    (-729641)/(8388608)
    ];
  eps := (105339837627011931281912870060829938945227355044593)/(1000000000000000000000000000000000000000000000000000) ;
  iv := [("theta1",
    ((-157)/(50),
    (157)/(50)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      