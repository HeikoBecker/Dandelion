
(** File: Daisy, function: instantaneousCurrent **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG1dot5707830967865613SEPsp188495dot55921539583_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (10000000000000512663176669728112088062857093683553)/(10000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "_tmp4");
    poly := [
    (-51264094844217712921394872401384005024813691336893)/(1000000000000000000000000000000000000000000000000000000000000000);
    (2830176463060298204917973290769897576638555787039)/(2000000000000000000000000000000000000000000000000000000000000000000);
    (-52850934165800886363718781938523826179453581567757)/(5000000000000000000000000000000000000000000000000000000000000000000000000);
    (25246903966016882988983493811001861309299286490389)/(1000000000000000000000000000000000000000000000000000000000000000000000000000000)
    ];
  eps := (10000000000000512663176669728112088062857093683553)/(10000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp4",
    ((-7074178169367831)/(4503599627370496),
    (17802902220171114143381873073366743)/(94447329657392904273920000000)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      