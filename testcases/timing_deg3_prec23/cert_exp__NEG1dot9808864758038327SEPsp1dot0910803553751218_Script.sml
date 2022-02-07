
(** File: Benchmarks_small, function: predictMLPLogistic **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG1dot9808864758038327SEPsp1dot0910803553751218_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (44230660185702072801734415855379856191293903825549)/(2000000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "n2");
    poly := [
    (2068611)/(2097152);
    (2192511)/(2097152);
    (4679045)/(8388608);
    (4263137)/(33554432)
    ];
  eps := (44230660185702072801734415855379856191293903825549)/(2000000000000000000000000000000000000000000000000000) ;
  iv := [("n2",
    ((-2313283280103676669)/(1167802046386812410),
    (455059239921256374)/(417072159423861575)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      