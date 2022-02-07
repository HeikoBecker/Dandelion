
(** File: FPTaylorReal2Float, function: azimuth **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG6dot2831853SEPspNEG0dot5_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (5333989418833108014747086056537883485182780126619)/(50000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "dLon");
    poly := [
    (1757101)/(16777216);
    (7336067)/(4194304);
    (214747)/(262144);
    (5833053)/(67108864)
    ];
  eps := (5333989418833108014747086056537883485182780126619)/(50000000000000000000000000000000000000000000000000) ;
  iv := [("dLon",
    ((-62831853)/(10000000),
    (-1)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      