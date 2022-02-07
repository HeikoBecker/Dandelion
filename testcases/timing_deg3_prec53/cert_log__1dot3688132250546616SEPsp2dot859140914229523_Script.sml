
(** File: TransBenchsErrorBoundsSmall, function: integrateStoutemyer2007 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__1dot3688132250546616SEPsp2dot859140914229523_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (76606715188545677289613022771418651004172013040019)/(100000000000000000000000000000000000000000000000000000) *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "_tmp12");
    poly := [
    (-14473701852110945620388804400135995820164680480957)/(12500000000000000000000000000000000000000000000000);
    (849732196548891)/(562949953421312);
    (-37122729465170534179918604422709904611110687255859)/(100000000000000000000000000000000000000000000000000);
    (39703771916652738638298103523993631824851036071777)/(1000000000000000000000000000000000000000000000000000)
    ];
  eps := (76606715188545677289613022771418651004172013040019)/(100000000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp12",
    ((6164586730295981)/(4503599627370496),
    (12876425955923819)/(4503599627370496)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``20:num``;

val _ = export_theory();
      