
(** File: TransBenchsErrorBoundsSmall, function: integrate18257 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot0SEPsp3dot14_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (35457871082438277479423617266533542793801367684017)/(1250000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (-7503197)/(268435456);
    (1334665)/(1048576);
    (-6792339)/(16777216);
    (-1888739)/(17179869184)
    ];
  eps := (35457871082438277479423617266533542793801367684017)/(1250000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((0)/(1),
    (157)/(50)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      