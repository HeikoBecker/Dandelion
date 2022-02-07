
(** File: Benchmarks_small, function: xu2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot02SEPsp1dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (2225836802494486231876947168391595554607003882957)/(6250000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x2");
    poly := [
    (8384825)/(8388608);
    (2834277)/(268435456);
    (-576689)/(1048576);
    (5362613)/(67108864)
    ];
  eps := (2225836802494486231876947168391595554607003882957)/(6250000000000000000000000000000000000000000000000000) ;
  iv := [("x2",
    ((1)/(50),
    (1)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      