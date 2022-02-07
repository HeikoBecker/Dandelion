
(** File: MLClassifier, function: predictGaussianNB **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__0dot25SEPsp0dot5_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (3165809970850965949245502646944285466929736726943)/(5000000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "prior");
    poly := [
    (-1620772600537061)/(562949953421312);
    (4757225068085533)/(562949953421312);
    (-6567186972871517)/(562949953421312);
    (1975992975553651)/(281474976710656)
    ];
  eps := (3165809970850965949245502646944285466929736726943)/(5000000000000000000000000000000000000000000000000000) ;
  iv := [("prior",
    ((1)/(4),
    (1)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      