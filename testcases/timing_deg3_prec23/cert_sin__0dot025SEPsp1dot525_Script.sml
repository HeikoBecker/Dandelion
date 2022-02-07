
(** File: Benchmarks_small, function: pendulum2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot025SEPsp1dot525_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (3276636621360282419931338853993185248029165835969)/(2500000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "_tmp20");
    poly := [
    (-921277)/(536870912);
    (1075013)/(1048576);
    (-4591399)/(67108864);
    (-7659611)/(67108864)
    ];
  eps := (3276636621360282419931338853993185248029165835969)/(2500000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp20",
    ((1)/(40),
    (61)/(40)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      