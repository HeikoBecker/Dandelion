
(** File: TransBenchsErrorBoundsSmall, function: rodriguesRotation **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG5dot0SEPsp5dot0_";

val _ = realZeroLib.useBinary := true;

(* err = 0.11082945400452005328560067891718399123969374953329 *)
(* infnorm = 0.107894987240339702805458344057023253716585489291078 *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "theta");
    poly := [
    (-48383133856830052632263811223783904237876352799619)/(1000000000000000000000000000000000000000000000000000000000000000);
    (945588949247581)/(1125899906842624);
    (42206908603938314319653306273264706695704049504991)/(1000000000000000000000000000000000000000000000000000000000000000);
    (-10867096293096775716513491261139279231429100036621)/(100000000000000000000000000000000000000000000000000);
    (-9211388998140063359731125267455501528710264808053)/(2500000000000000000000000000000000000000000000000000000000000000);
    (6826865746353067343141218792368363210698589682579)/(2500000000000000000000000000000000000000000000000000)
    ];
  eps := (11082945400452005328560067891718399123969374953329)/(100000000000000000000000000000000000000000000000000) ;
  iv := [("theta",
    ((-5)/(1),
    (5)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``32:num``;

val _ = export_theory();
      