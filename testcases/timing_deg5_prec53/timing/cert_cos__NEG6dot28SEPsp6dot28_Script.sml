
(** File: TransBenchsErrorBoundsSmall, function: forwardk2jX **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG6dot28SEPsp6dot28_";

val _ = realZeroLib.useBinary := true;

(* err = 0.59444060964569176462925082190858608017550318833624 *)
(* infnorm = 0.59273971921172295657623086438248965503543436601318 *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "_tmp40");
    poly := [
    (40726138739477496519825194809527602046728134155273)/(100000000000000000000000000000000000000000000000000);
    (-263393614633582774043544898201485437994051608257)/(4000000000000000000000000000000000000000000000000000000);
    (-64008756861987120556634067725099157541990280151367)/(500000000000000000000000000000000000000000000000000);
    (44687403873246012489725170248062308120395869082131)/(10000000000000000000000000000000000000000000000000000000000);
    (50102293521623513048585119022959588619414716959)/(12500000000000000000000000000000000000000000000000);
    (-70973680009985730567478474222902233223275736406777)/(1000000000000000000000000000000000000000000000000000000000000)
    ];
  eps := (7430507620571147057865635273857326002193789854203)/(12500000000000000000000000000000000000000000000000) ;
  iv := [("_tmp40",
    ((-157)/(25),
    (157)/(25)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``32:num``;

val _ = export_theory();
      