
(** File: MLClassifier, function: predictGaussianNB **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__0dot12564SEPsp1dot8846_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (15902662824647877383077053948999530486297588355049)/(200000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "_tmp4");
    poly := [
    (-346923)/(131072);
    (2971125)/(524288);
    (-8377993)/(2097152);
    (4303569)/(4194304)
    ];
  eps := (15902662824647877383077053948999530486297588355049)/(200000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp4",
    ((3141)/(25000),
    (9423)/(5000)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      