
(** File: Benchmarks_small, function: predictMLPLogistic **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG1dot9808864758038327SEPsp1dot0910803553751218_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (8846148301034960449300034316184753930220505207707)/(400000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "n2");
    poly := [
    (69411066971297)/(70368744177664);
    (1306838522341514929880901263459236361086368560791)/(1250000000000000000000000000000000000000000000000);
    (5577856098048957766977196115476544946432113647461)/(10000000000000000000000000000000000000000000000000);
    (3176283171249211917386290338072285521775484085083)/(25000000000000000000000000000000000000000000000000)
    ];
  eps := (8846148301034960449300034316184753930220505207707)/(400000000000000000000000000000000000000000000000000) ;
  iv := [("n2",
    ((-2313283280103676669)/(1167802046386812410),
    (455059239921256374)/(417072159423861575)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      