
(** File: Herbie, function: complex_sine_cosine **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG10dot0SEPsp10dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (38209423025530459509962137793502094239312227333811)/(10000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "im");
    poly := [
    (-1775695645425163)/(1099511627776);
    (-2626058834423397)/(2199023255552);
    (775858593693523)/(8796093022208);
    (6461304774978117)/(281474976710656)
    ];
  eps := (38209423025530459509962137793502094239312227333811)/(10000000000000000000000000000000000000000000000) ;
  iv := [("im",
    ((-10)/(1),
    (10)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      