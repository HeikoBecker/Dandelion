
(** File: FPTaylorReal2Float, function: azimuth **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot0SEPsp0dot4_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1376152356914437491549175193686353878256714935983)/(125000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "lat1");
    poly := [
    (2097135)/(2097152);
    (701567)/(1073741824);
    (-1065783)/(2097152);
    (4429979)/(134217728)
    ];
  eps := (1376152356914437491549175193686353878256714935983)/(125000000000000000000000000000000000000000000000000000) ;
  iv := [("lat1",
    ((0)/(1),
    (2)/(5)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      