
(** File: Pendulum, function: pendulum2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG2dot025SEPsp2dot025_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (7689371051589373161581244041525810719701694082379)/(500000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "_tmp4");
    poly := [
    (-7264573)/(562949953421312);
    (8073103)/(8388608);
    (1201133)/(70368744177664);
    (-4304147)/(33554432)
    ];
  eps := (7689371051589373161581244041525810719701694082379)/(500000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp4",
    ((-81)/(40),
    (81)/(40)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      