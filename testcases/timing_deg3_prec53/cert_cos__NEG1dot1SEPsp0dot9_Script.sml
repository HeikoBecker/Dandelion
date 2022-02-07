
(** File: TransBenchsErrorBoundsSmall, function: ex2_11 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__NEG1dot1SEPsp0dot9_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (51071998720763381547919648303602908495559514646429)/(10000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (49771493086149592999234414492093492299318313598633)/(50000000000000000000000000000000000000000000000000);
    (74921573821570969231586900605179835110902786254883)/(10000000000000000000000000000000000000000000000000000);
    (-4620306610234539701487221918796421959996223449707)/(10000000000000000000000000000000000000000000000000);
    (-154285108391304381925124289409723132848739624023437)/(10000000000000000000000000000000000000000000000000000)
    ];
  eps := (51071998720763381547919648303602908495559514646429)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((-11)/(10),
    (9)/(10)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      