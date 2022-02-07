
(** File: TransBenchsErrorBoundsSmall, function: ex2_5 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__17dot0SEPsp18dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (31369982241434607931598573125381163640872174765603)/(100000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x");
    poly := [
    (5873235721198165)/(17592186044416);
    (-870423618734635)/(17592186044416);
    (2659496386956875)/(1125899906842624);
    (-2243300519900248441579337921325532079208642244339)/(62500000000000000000000000000000000000000000000000)
    ];
  eps := (31369982241434607931598573125381163640872174765603)/(100000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((17)/(1),
    (18)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      