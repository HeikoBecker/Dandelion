
(** File: CompoundFunction, function: compundExp2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__2dot0SEPsp4dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (52888371410304091212030315074523532216845837708121)/(10000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (96457)/(32768);
    (-4786353)/(2097152);
    (271391)/(1048576);
    (5854297)/(268435456)
    ];
  eps := (52888371410304091212030315074523532216845837708121)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((2)/(1),
    (4)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      