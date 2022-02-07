
(** File: Benchmarks_small, function: xu2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot02SEPsp3dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (23307464189066072411969583168427055900137273005557)/(1000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x1");
    poly := [
    (-7450707)/(268435456);
    (2620067)/(2097152);
    (-785549)/(2097152);
    (-573823)/(67108864)
    ];
  eps := (23307464189066072411969583168427055900137273005557)/(1000000000000000000000000000000000000000000000000000) ;
  iv := [("x1",
    ((1)/(50),
    (3)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      