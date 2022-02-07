
(** File: TransBenchsErrorBoundsSmall, function: integrateStoutemyer2007 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__0dot1SEPsp1dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (7972337333374359591714193635078638539321845059637)/(12500000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "x");
    poly := [
    (4184091)/(4194304);
    (1079653)/(1048576);
    (6667535)/(16777216);
    (615071)/(2097152)
    ];
  eps := (7972337333374359591714193635078638539321845059637)/(12500000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((1)/(10),
    (1)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      