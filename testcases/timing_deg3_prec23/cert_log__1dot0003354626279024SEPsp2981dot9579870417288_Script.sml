
(** File: FPTaylorReal2Float, function: logexp **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__1dot0003354626279024SEPsp2981dot9579870417288_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (159775731825104480118566744452267204629650966094533)/(100000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "e");
    poly := [
    (3311701)/(2097152);
    (2168845)/(134217728);
    (-6437465)/(549755813888);
    (678891)/(281474976710656)
    ];
  eps := (159775731825104480118566744452267204629650966094533)/(100000000000000000000000000000000000000000000000000) ;
  iv := [("e",
    ((4613233066738190827)/(4611686018427387904),
    (6557394960583791)/(2199023255552)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      