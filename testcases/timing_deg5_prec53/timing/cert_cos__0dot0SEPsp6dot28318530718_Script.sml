
(** File: Daisy, function: polarToCarthesian_x **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot0SEPsp6dot28318530718_";

val _ = realZeroLib.useBinary := true;

(* err = 3.3554920938358712118288023071692245283028807436795e-2 *)
(* infnorm = 2.91588432999551498971188618689176335527396263243053e-2 *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "radiant");
    poly := [
    (4854207214572586193135350640659453347325325012207)/(5000000000000000000000000000000000000000000000000);
    (15668918058347647281891568127321079373359680175781)/(50000000000000000000000000000000000000000000000000);
    (-647695630480525225136645417478575836867094039917)/(625000000000000000000000000000000000000000000000);
    (15331676881096879296040302875780980684794485569)/(48828125000000000000000000000000000000000000000);
    (-24986748506642876554995069682263419963419437408447)/(1000000000000000000000000000000000000000000000000000);
    (-29907701427174985286271908695995697656001832687167)/(10000000000000000000000000000000000000000000000000000000000000)
    ];
  eps := (6710984187671742423657604614338449056605761487359)/(200000000000000000000000000000000000000000000000000) ;
  iv := [("radiant",
    ((0)/(1),
    (314159265359)/(50000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``32:num``;

val _ = export_theory();
      