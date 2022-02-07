
(** File: TransBenchsErrorBoundsSmall, function: integrate18257 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG1dot0SEPsp3dot14_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (21241551747787612371621274571725579939571157921369)/(500000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "_tmp9");
    poly := [
    (4226639)/(4194304);
    (-6920803)/(67108864);
    (-2125337)/(4194304);
    (3544501)/(33554432)
    ];
  eps := (21241551747787612371621274571725579939571157921369)/(500000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp9",
    ((-1)/(1),
    (15888576884623883540670884717435008603390197006485156291016756605153281656087634731018890120562814272872185612348869735044099985884784787934060551895347973028839117805710459367110652257754317482787321762760110487882117587448838376841521113418459025172753589436220163409858173047295594448776626709428711491669655057675839340569)/(5060056332682765458812383667972932676238916244103552958922533950685758489199883672299009592535928112379676946607920297784745218434644836921675334998518462748037935606914159034111672693552330408530994191961818626714050187085617317465452583891228988908520251412808969238808335365380762563304658187716150156582692693527337369600)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      