
(** File: Herbie, function: complex_sine_cosine **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG10dot0SEPsp10dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (38209419842937505949283717865315332346481987971649)/(10000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "im");
    poly := [
    (-6614981)/(4096);
    (-611427)/(512);
    (5780597)/(65536);
    (6017559)/(262144)
    ];
  eps := (38209419842937505949283717865315332346481987971649)/(10000000000000000000000000000000000000000000000) ;
  iv := [("im",
    ((-10)/(1),
    (10)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      