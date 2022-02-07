
(** File: TransBenchsErrorBoundsSmall, function: sinxx10 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG3dot0SEPsp3dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1742572953986541860059049981208734981779557952243)/(20000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (-115752188650092291410942380025517195463180541992187)/(1000000000000000000000000000000000000000000000000000000000000000);
    (7123747)/(8388608);
    (947983)/(9223372036854775808);
    (-6196109)/(67108864)
    ];
  eps := (1742572953986541860059049981208734981779557952243)/(20000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-3)/(1),
    (3)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      