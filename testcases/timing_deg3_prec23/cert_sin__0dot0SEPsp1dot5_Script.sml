
(** File: Benchmarks_small, function: rodriguesRotation **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot0SEPsp1dot5_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (64112868613206592924574737687872866976546874521113)/(50000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "theta");
    poly := [
    (-1180229)/(1073741824);
    (1070843)/(1048576);
    (-521335)/(8388608);
    (-7844783)/(67108864)
    ];
  eps := (64112868613206592924574737687872866976546874521113)/(50000000000000000000000000000000000000000000000000000) ;
  iv := [("theta",
    ((0)/(1),
    (3)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      