
(** File: Benchmarks_small, function: xu1 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot01SEPsp1dot5_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (125787393502446376872499643752582857463391871394883)/(100000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x2");
    poly := [
    (-1387231)/(1073741824);
    (4287497)/(4194304);
    (-2128301)/(33554432);
    (-3906271)/(33554432)
    ];
  eps := (125787393502446376872499643752582857463391871394883)/(100000000000000000000000000000000000000000000000000000) ;
  iv := [("x2",
    ((1)/(100),
    (3)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      