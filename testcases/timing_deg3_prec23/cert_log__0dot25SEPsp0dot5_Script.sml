
(** File: MLClassifier, function: predictGaussianNB **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__0dot25SEPsp0dot5_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (6331465470222336989417138485715744802666908975609)/(10000000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "prior");
    poly := [
    (-6037851)/(2097152);
    (4430517)/(524288);
    (-6116187)/(524288);
    (7361181)/(1048576)
    ];
  eps := (6331465470222336989417138485715744802666908975609)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("prior",
    ((1)/(4),
    (1)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      