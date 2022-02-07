
(** File: MLClassifier, function: predictGaussianNB **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__0dot06282SEPsp0dot50256_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1250877748963641468004590574930244118976784180991)/(40000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "_tmp6");
    poly := [
    (-3791495)/(1048576);
    (4234355)/(262144);
    (-1192837)/(32768);
    (4166359)/(131072)
    ];
  eps := (1250877748963641468004590574930244118976784180991)/(40000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp6",
    ((3141)/(50000),
    (3141)/(6250)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      