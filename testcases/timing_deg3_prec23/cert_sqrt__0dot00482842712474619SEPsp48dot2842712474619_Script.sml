
(** File: Herbie, function: complex_square_root **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sqrt__0dot00482842712474619SEPsp48dot2842712474619_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1482680380906292513125687241804979909087874889089)/(5000000000000000000000000000000000000000000000000) *)
Definition sqrt_example_def:
  sqrt_example =
  <|
    transc := Fun Sqrt (Var "_tmp");
    poly := [
    (3044815)/(8388608);
    (6729589)/(16777216);
    (-3185185)/(268435456);
    (1158137)/(8589934592)
    ];
  eps := (1482680380906292513125687241804979909087874889089)/(5000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp",
    ((695849683193361119)/(144115188075855872000),
    (13590814124870337)/(281474976710656)))];
  |>
End

Theorem checkerSucceeds = validateCert sqrt_example_def ``20:num``;

val _ = export_theory();
      