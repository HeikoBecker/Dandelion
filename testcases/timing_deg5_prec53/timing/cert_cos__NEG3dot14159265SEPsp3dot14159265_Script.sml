
(** File: FPTaylorReal2Float, function: sphere **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG3dot14159265SEPsp3dot14159265_";

val _ = realZeroLib.useBinary := true;

(* err = 3.0240752646901800782865360801320776013858832814324e-2 *)
(* infnorm = 2.915881802080032670829320615503837597018164955161e-2 *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "lon");
    poly := [
    (97084144278657180660019321294385008513927459716797)/(100000000000000000000000000000000000000000000000000);
    (176754168944359185297416921139380431571286322878223)/(1000000000000000000000000000000000000000000000000000000000000);
    (-22167146596693851345882819714461220428347587585449)/(50000000000000000000000000000000000000000000000000);
    (-2371855381434659339930445351078371800726540818971)/(50000000000000000000000000000000000000000000000000000000000);
    (15616717864949311838501655458344430371653288602829)/(625000000000000000000000000000000000000000000000000);
    (29918287343743585737056418469444039496749065953907)/(10000000000000000000000000000000000000000000000000000000000000)
    ];
  eps := (7560188161725450195716340200330194003464708203581)/(250000000000000000000000000000000000000000000000000) ;
  iv := [("lon",
    ((-62831853)/(20000000),
    (62831853)/(20000000)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``32:num``;

val _ = export_theory();
      