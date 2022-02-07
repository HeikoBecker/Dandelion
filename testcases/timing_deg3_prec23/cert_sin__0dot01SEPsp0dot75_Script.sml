
(** File: Benchmarks_small, function: xu1 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot01SEPsp0dot75_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1133440554290630367407270706849364807853097593071)/(31250000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x1");
    poly := [
    (-7037685)/(137438953472);
    (1050233)/(1048576);
    (-2339015)/(268435456);
    (-2570225)/(16777216)
    ];
  eps := (1133440554290630367407270706849364807853097593071)/(31250000000000000000000000000000000000000000000000000) ;
  iv := [("x1",
    ((1)/(100),
    (3)/(4)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      