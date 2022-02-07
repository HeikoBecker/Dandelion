
(** File: TransBenchsErrorBoundsSmall, function: ex2_7 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG1dot57SEPsp1dot57_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (141464435693139934802175700242876919842112016389463)/(5000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (8154133)/(8388608);
    (-3677993)/(288230376151711744);
    (-6801029)/(16777216);
    (5968587)/(1152921504606846976)
    ];
  eps := (141464435693139934802175700242876919842112016389463)/(5000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-157)/(100),
    (157)/(100)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      