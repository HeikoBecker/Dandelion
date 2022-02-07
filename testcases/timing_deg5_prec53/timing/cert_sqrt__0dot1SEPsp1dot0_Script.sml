
(** File: TransBenchsErrorBoundsSmall, function: integrateStoutemyer2007 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sqrt__0dot1SEPsp1dot0_";

val _ = realZeroLib.useBinary := true;

(* err = 1.01691034404149997778409366615966000437107062409357e-3 *)
(* infnorm = 5.6624667064129848595071971591904662767624132801871e-4 *)
Definition sqrt_example_def:
  sqrt_example =
  <|
    transc := Fun Sqrt (Var "x");
    poly := [
    (137368231669103113556928974503534846007823944091797)/(1000000000000000000000000000000000000000000000000000);
    (2391312353193661)/(1125899906842624);
    (-9489667507569133908518210773763712495565414428711)/(2500000000000000000000000000000000000000000000000);
    (26959973064441737911067775712581351399421691894531)/(5000000000000000000000000000000000000000000000000);
    (-289435195526731)/(70368744177664);
    (31406997206676795508784039157035294920206069946289)/(25000000000000000000000000000000000000000000000000)
    ];
  eps := (101691034404149997778409366615966000437107062409357)/(100000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((1)/(10),
    (1)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sqrt_example_def ``32:num``;

val _ = export_theory();
      