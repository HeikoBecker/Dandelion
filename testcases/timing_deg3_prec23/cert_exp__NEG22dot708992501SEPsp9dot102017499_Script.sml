
(** File: FPTaylorReal2Float, function: hartman3 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG22dot708992501SEPsp9dot102017499_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (10591342060690361109346284557994494798362944155197)/(5000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e2");
    poly := [
    (-4209153)/(2048);
    (8208473)/(65536);
    (280685)/(4096);
    (364359)/(131072)
    ];
  eps := (10591342060690361109346284557994494798362944155197)/(5000000000000000000000000000000000000000000000) ;
  iv := [("e2",
    ((-22708992501)/(1000000000),
    (9102017499)/(1000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      