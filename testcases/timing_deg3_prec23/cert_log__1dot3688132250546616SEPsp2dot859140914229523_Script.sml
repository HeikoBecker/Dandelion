
(** File: TransBenchsErrorBoundsSmall, function: integrateStoutemyer2007 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__1dot3688132250546616SEPsp2dot859140914229523_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (76606939604736483708855738236302902440250561525397)/(100000000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "_tmp12");
    poly := [
    (-4856569)/(4194304);
    (6330999)/(4194304);
    (-3114081)/(8388608);
    (666119)/(16777216)
    ];
  eps := (76606939604736483708855738236302902440250561525397)/(100000000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp12",
    ((6164586730295981)/(4503599627370496),
    (12876425955923819)/(4503599627370496)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      