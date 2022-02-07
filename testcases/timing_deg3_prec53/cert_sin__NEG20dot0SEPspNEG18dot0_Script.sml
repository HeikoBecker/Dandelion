
(** File: TransBenchsErrorBoundsSmall, function: ex2_10 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG20dot0SEPspNEG18dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (24666117259725250255463658377012223951877733339043)/(25000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (-8862917770828653)/(8796093022208);
    (-2856225988594889)/(17592186044416);
    (-4878683444004597)/(562949953421312);
    (-76627825754347941855648684850166318938136100769043)/(500000000000000000000000000000000000000000000000000)
    ];
  eps := (24666117259725250255463658377012223951877733339043)/(25000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-20)/(1),
    (-18)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      