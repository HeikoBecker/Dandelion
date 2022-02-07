
(** File: Daisy, function: polarToCarthesian_y **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot0SEPsp6dot28318530718_";

val _ = realZeroLib.useBinary := true;

(* err = 1.26785403425191128158121516578223512685826996556122e-2 *)
(* infnorm = 6.8498113729770538974557459443900898693856962467304e-3 *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "radiant");
    poly := [
    (17124427634915009247690287352838822698686271905899)/(2500000000000000000000000000000000000000000000000000);
    (252632630280541)/(281474976710656);
    (155166190588691636081941638281023188028484582901)/(625000000000000000000000000000000000000000000000);
    (-38595063237340920814233413693727925419807434082031)/(100000000000000000000000000000000000000000000000000);
    (2146256936401505846512272057680092984810471534729)/(25000000000000000000000000000000000000000000000000);
    (-27326991992657899584184821861754244309850037097931)/(5000000000000000000000000000000000000000000000000000)
    ];
  eps := (63392701712595564079060758289111756342913498278061)/(5000000000000000000000000000000000000000000000000000) ;
  iv := [("radiant",
    ((0)/(1),
    (314159265359)/(50000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``32:num``;

val _ = export_theory();
      