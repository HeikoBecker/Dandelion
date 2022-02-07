
(** File: Analysis2_test, function: ex2_1 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG1dot57079632679SEPsp1dot57079632679_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (4857053401147902271632827971574516743659157879389)/(1000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (-6835529)/(2251799813685248);
    (8267221)/(8388608);
    (3518947)/(562949953421312);
    (-4783745)/(33554432)
    ];
  eps := (4857053401147902271632827971574516743659157879389)/(1000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-157079632679)/(100000000000),
    (157079632679)/(100000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      