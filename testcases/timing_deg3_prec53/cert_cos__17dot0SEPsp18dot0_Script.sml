
(** File: TransBenchsErrorBoundsSmall, function: ex2_5 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__17dot0SEPsp18dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (36971842102200327206359529236097941228433798726733)/(500000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (3543056739030031)/(4398046511104);
    (-4992539770093743)/(35184372088832);
    (4656489436309747)/(562949953421312);
    (-15960124625766941575122359608940314501523971557617)/(100000000000000000000000000000000000000000000000000)
    ];
  eps := (36971842102200327206359529236097941228433798726733)/(500000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((17)/(1),
    (18)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      