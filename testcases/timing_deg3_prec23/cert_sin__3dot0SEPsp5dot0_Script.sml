
(** File: CompoundFunction, function: compundExp **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__3dot0SEPsp5dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (43314810321886178762598181492376489851349280132661)/(10000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (7992559)/(8388608);
    (5932905)/(4194304);
    (-3625329)/(4194304);
    (6779679)/(67108864)
    ];
  eps := (43314810321886178762598181492376489851349280132661)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((3)/(1),
    (5)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      