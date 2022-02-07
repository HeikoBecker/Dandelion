
(** File: TransBenchsErrorBoundsSmall, function: forwardk2jY **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG6dot28SEPsp6dot28_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (87163948059552349319032936533104519267311053908847)/(100000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "_tmp37");
    poly := [
    (-31093968012593920869911673929633644242187529016519)/(250000000000000000000000000000000000000000000000000000000);
    (4887739906992465133139802446748944930732250213623)/(50000000000000000000000000000000000000000000000000);
    (7293671553934973633172967168517009106665227591293)/(200000000000000000000000000000000000000000000000000000000);
    (-60092311947551246484322540197808848461136221885681)/(10000000000000000000000000000000000000000000000000000)
    ];
  eps := (87163948059552349319032936533104519267311053908847)/(100000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp37",
    ((-157)/(25),
    (157)/(25)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      