
(** File: MLClassifier, function: predictGaussianNB **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__0dot75384SEPsp2dot5128_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (21058659075594327648964275387143589053194206914751)/(5000000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "_tmp");
    poly := [
    (-3213123)/(2097152);
    (4512175)/(2097152);
    (-6092229)/(8388608);
    (1730551)/(16777216)
    ];
  eps := (21058659075594327648964275387143589053194206914751)/(5000000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp",
    ((9423)/(12500),
    (3141)/(1250)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      