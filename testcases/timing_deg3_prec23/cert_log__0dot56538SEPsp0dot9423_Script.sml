
(** File: MLClassifier, function: predictGaussianNB **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__0dot56538SEPsp0dot9423_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (13151458612015477411102189360294416939823330650863)/(100000000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "_tmp2");
    poly := [
    (-4511901)/(2097152);
    (2150151)/(524288);
    (-5815011)/(2097152);
    (6915341)/(8388608)
    ];
  eps := (13151458612015477411102189360294416939823330650863)/(100000000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp2",
    ((28269)/(50000),
    (9423)/(10000)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      