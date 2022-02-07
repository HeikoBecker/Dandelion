
(** File: Benchmarks_small, function: predictMLPLogistic **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG4dot35SEPsp6dot05_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (37154769295015016652906877332082761223993865967273)/(1000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "n1");
    poly := [
    (-2157469)/(524288);
    (-3275587)/(131072);
    (7750267)/(4194304);
    (4496829)/(2097152)
    ];
  eps := (37154769295015016652906877332082761223993865967273)/(1000000000000000000000000000000000000000000000000) ;
  iv := [("n1",
    ((-87)/(20),
    (121)/(20)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      