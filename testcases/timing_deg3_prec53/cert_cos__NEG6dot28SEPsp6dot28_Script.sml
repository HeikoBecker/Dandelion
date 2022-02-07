
(** File: TransBenchsErrorBoundsSmall, function: forwardk2jX **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG6dot28SEPsp6dot28_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (100000100453997187410054863527676512245334138184263)/(100000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "_tmp40");
    poly := [
    (10744073340421129569567356212833608708479005144909)/(5000000000000000000000000000000000000000000000000000000);
    (-25562467097237176257686772020034926544695963457343)/(500000000000000000000000000000000000000000000000000000000);
    (-3203627265598321395168333663647231013271721167257)/(25000000000000000000000000000000000000000000000000000000);
    (129632374017390049589543277701189985529062198565953)/(100000000000000000000000000000000000000000000000000000000000)
    ];
  eps := (100000100453997187410054863527676512245334138184263)/(100000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp40",
    ((-157)/(25),
    (157)/(25)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      