
(** File: TransBenchsErrorBoundsSmall, function: pendulum1 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__1dot0SEPsp3dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (6160504500510528749767901805902715432034174246423)/(1250000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "t");
    poly := [
    (-3798481)/(8388608);
    (2127941)/(1048576);
    (-210739)/(262144);
    (4316049)/(67108864)
    ];
  eps := (6160504500510528749767901805902715432034174246423)/(1250000000000000000000000000000000000000000000000000) ;
  iv := [("t",
    ((1)/(1),
    (3)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      