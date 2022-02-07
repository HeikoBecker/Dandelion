
(** File: TransBenchsErrorBoundsSmall, function: integrate18257 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG0dot9999987317275396SEPsp1dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (7544841159825006645200552947822261308506205056231)/(1250000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "_tmp6");
    poly := [
    (8343137)/(8388608);
    (4176133)/(4194304);
    (2277393)/(4194304);
    (3012073)/(16777216)
    ];
  eps := (7544841159825006645200552947822261308506205056231)/(1250000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp6",
    ((-1125898478894779)/(1125899906842624),
    (1)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      