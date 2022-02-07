
(** File: LogTwo, function: logTwo **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__32dot0SEPsp64dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (26869403017359264504415310082215644004853189532353)/(50000000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "x");
    poly := [
    (4137597)/(2097152);
    (2215255)/(33554432);
    (-3058083)/(4294967296);
    (1840285)/(549755813888)
    ];
  eps := (26869403017359264504415310082215644004853189532353)/(50000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((32)/(1),
    (64)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      