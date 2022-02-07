
(** File: TransBenchsErrorBoundsSmall, function: ex2_12 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG17dot0SEPsp7dot3_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (5928524123122763952203379399724768999556541025273)/(20000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "x");
    poly := [
    (-156931357907071)/(549755813888);
    (3547012322337707)/(140737488355328);
    (2437757185470031)/(140737488355328);
    (23343339301506130234464819750428432598710060119629)/(25000000000000000000000000000000000000000000000000)
    ];
  eps := (5928524123122763952203379399724768999556541025273)/(20000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-17)/(1),
    (73)/(10)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      