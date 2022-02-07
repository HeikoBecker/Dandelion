
(** File: Benchmarks_small, function: xu2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot03SEPsp1dot5_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (12098391013344286956777096196858799158535016883007)/(10000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x2");
    poly := [
    (-7301023)/(4294967296);
    (4296001)/(4194304);
    (-4431691)/(67108864);
    (-7747273)/(67108864)
    ];
  eps := (12098391013344286956777096196858799158535016883007)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("x2",
    ((3)/(100),
    (3)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      