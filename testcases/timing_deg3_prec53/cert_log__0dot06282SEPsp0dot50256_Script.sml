
(** File: MLClassifier, function: predictGaussianNB **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__0dot06282SEPsp0dot50256_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1250878456121878992025189719110013461188930979757)/(40000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "_tmp6");
    poly := [
    (-18079256685331916987280465036747045814990997314453)/(5000000000000000000000000000000000000000000000000);
    (4546603564038773)/(281474976710656);
    (-5123194368110477)/(140737488355328);
    (8947183485042543)/(281474976710656)
    ];
  eps := (1250878456121878992025189719110013461188930979757)/(40000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp6",
    ((3141)/(50000),
    (3141)/(6250)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      