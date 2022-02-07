
(** File: TransBenchsErrorBoundsSmall, function: rodriguesRotation **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG5dot0SEPsp5dot0_";

val _ = realZeroLib.useBinary := true;

(* err = 0.26918393725064750283039183682289588040921401919507 *)
(* infnorm = 0.26725731355866759333919214974729163997011991076354 *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "theta");
    poly := [
    (73274336146457552665367529698414728045463562011719)/(100000000000000000000000000000000000000000000000000);
    (2411332444625663776660147940254785847713492330513)/(2000000000000000000000000000000000000000000000000000000000);
    (-6736832195666903055908392161654774099588394165039)/(25000000000000000000000000000000000000000000000000);
    (-92216313391428008520993062781771895317084464238633)/(1000000000000000000000000000000000000000000000000000000000000);
    (26220030614931156415225999012363899964839220046997)/(2500000000000000000000000000000000000000000000000000);
    (175958657995658943874193464034330183277422821053193)/(100000000000000000000000000000000000000000000000000000000000000)
    ];
  eps := (26918393725064750283039183682289588040921401919507)/(100000000000000000000000000000000000000000000000000) ;
  iv := [("theta",
    ((-5)/(1),
    (5)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``32:num``;

val _ = export_theory();
      