
(** File: TransBenchsErrorBoundsSmall, function: ex2_5 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__17dot0SEPsp18dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (31374046728825404066718736915981815886825898880099)/(100000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (5470125)/(16384);
    (-3242751)/(65536);
    (2477005)/(1048576);
    (-602229)/(16777216)
    ];
  eps := (31374046728825404066718736915981815886825898880099)/(100000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((17)/(1),
    (18)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      