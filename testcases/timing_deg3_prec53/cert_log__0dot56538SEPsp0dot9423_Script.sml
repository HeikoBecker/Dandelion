
(** File: MLClassifier, function: predictGaussianNB **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__0dot56538SEPsp0dot9423_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (6575224698453038017517277008719373717663502405931)/(50000000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "_tmp2");
    poly := [
    (-1211154562817901)/(562949953421312);
    (20505448199680462728622387658106163144111633300781)/(5000000000000000000000000000000000000000000000000);
    (-390239076015349)/(140737488355328);
    (82437354177054078530062497520702891051769256591797)/(100000000000000000000000000000000000000000000000000)
    ];
  eps := (6575224698453038017517277008719373717663502405931)/(50000000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp2",
    ((28269)/(50000),
    (9423)/(10000)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      