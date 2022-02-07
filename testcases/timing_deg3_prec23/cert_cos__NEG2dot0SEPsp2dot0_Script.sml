
(** File: TransBenchsErrorBoundsSmall, function: ex2_2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG2dot0SEPsp2dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (13711339690079054883195135475231829735811472247841)/(200000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (7817541)/(8388608);
    (-1062097)/(18014398509481984);
    (-2969875)/(8388608);
    (4248389)/(288230376151711744)
    ];
  eps := (13711339690079054883195135475231829735811472247841)/(200000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-2)/(1),
    (2)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      