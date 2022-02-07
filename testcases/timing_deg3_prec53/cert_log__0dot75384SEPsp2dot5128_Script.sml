
(** File: MLClassifier, function: predictGaussianNB **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__0dot75384SEPsp2dot5128_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (42116990406934613690383545042467574556047042896153)/(10000000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "_tmp");
    poly := [
    (-38303399244259506151166760901105590164661407470703)/(25000000000000000000000000000000000000000000000000);
    (2689464865108288083028753590042470023036003112793)/(1250000000000000000000000000000000000000000000000);
    (-36312492454960693111232217233919072896242141723633)/(50000000000000000000000000000000000000000000000000);
    (2578720083399177118166356592610100051388144493103)/(25000000000000000000000000000000000000000000000000)
    ];
  eps := (42116990406934613690383545042467574556047042896153)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp",
    ((9423)/(12500),
    (3141)/(1250)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      