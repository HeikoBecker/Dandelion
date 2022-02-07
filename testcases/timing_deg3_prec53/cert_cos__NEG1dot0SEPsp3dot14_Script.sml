
(** File: TransBenchsErrorBoundsSmall, function: integrate18257 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG1dot0SEPsp3dot14_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (4248304902631473931591568604524185564985729336181)/(100000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "_tmp9");
    poly := [
    (12596367101091981988147949778067413717508316040039)/(12500000000000000000000000000000000000000000000000);
    (-25781993751871349479509731850157550070434808731079)/(250000000000000000000000000000000000000000000000000);
    (-633399925152849235798768745553388725966215133667)/(1250000000000000000000000000000000000000000000000);
    (29733438161583)/(281474976710656)
    ];
  eps := (4248304902631473931591568604524185564985729336181)/(100000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp9",
    ((-1)/(1),
    (15888576884623883540670884717435008603390197006485156291016756605153281656087634731018890120562814272872185612348869735044099985884784787934060551895347973028839117805710459367110652257754317482787321762760110487882117587448838376841521113418459025172753589436220163409858173047295594448776626709428711491669655057675839340569)/(5060056332682765458812383667972932676238916244103552958922533950685758489199883672299009592535928112379676946607920297784745218434644836921675334998518462748037935606914159034111672693552330408530994191961818626714050187085617317465452583891228988908520251412808969238808335365380762563304658187716150156582692693527337369600)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      