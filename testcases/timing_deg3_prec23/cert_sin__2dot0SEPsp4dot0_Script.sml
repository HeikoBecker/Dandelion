
(** File: CompoundFunction, function: compundExp2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__2dot0SEPsp4dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (2160203175717364639266902195984814937823667374321)/(1250000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (-6842741)/(4194304);
    (3721669)/(1048576);
    (-6067729)/(4194304);
    (5150181)/(33554432)
    ];
  eps := (2160203175717364639266902195984814937823667374321)/(1250000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((2)/(1),
    (4)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      