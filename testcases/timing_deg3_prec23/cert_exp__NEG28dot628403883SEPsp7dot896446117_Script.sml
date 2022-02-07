
(** File: FPTaylorReal2Float, function: hartman6 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG28dot628403883SEPsp7dot896446117_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1706217506552482702787026405319365818251302335171)/(2500000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e4");
    poly := [
    (-4005661)/(8192);
    (7815995)/(65536);
    (5341605)/(262144);
    (4818859)/(8388608)
    ];
  eps := (1706217506552482702787026405319365818251302335171)/(2500000000000000000000000000000000000000000000) ;
  iv := [("e4",
    ((-28628403883)/(1000000000),
    (7896446117)/(1000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      