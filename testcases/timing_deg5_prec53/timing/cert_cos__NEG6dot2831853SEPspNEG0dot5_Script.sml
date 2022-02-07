
(** File: FPTaylorReal2Float, function: azimuth **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG6dot2831853SEPspNEG0dot5_";

val _ = realZeroLib.useBinary := true;

(* err = 2.5026967281673449128452265600207654765601836047567e-2 *)
(* infnorm = 1.8211583186235404543070766700025210097526837205844e-2 *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "dLon");
    poly := [
    (7187013167659618284588418646308127790689468383789)/(10000000000000000000000000000000000000000000000000);
    (-5789769338518196278853267244812741409987211227417)/(6250000000000000000000000000000000000000000000000);
    (-15156456764133376946546150065842084586620330810547)/(10000000000000000000000000000000000000000000000000);
    (-2972436973779782332094612229411723092198371887207)/(6250000000000000000000000000000000000000000000000);
    (-12367775932106354896955480171527597121894359588623)/(250000000000000000000000000000000000000000000000000);
    (-3423659697616616179143000930906737266923300921917)/(2500000000000000000000000000000000000000000000000000)
    ];
  eps := (25026967281673449128452265600207654765601836047567)/(1000000000000000000000000000000000000000000000000000) ;
  iv := [("dLon",
    ((-62831853)/(10000000),
    (-1)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``32:num``;

val _ = export_theory();
      