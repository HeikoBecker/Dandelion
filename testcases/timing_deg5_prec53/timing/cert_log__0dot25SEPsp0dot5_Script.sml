
(** File: MLClassifier, function: predictGaussianNB **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__0dot25SEPsp0dot5_";

val _ = realZeroLib.useBinary := true;

(* err = 8.7265226427911499847532212669928415726587427049118e-6 *)
(* infnorm = 8.6912305772231805179920564915596014350798273146354e-6 *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "prior");
    poly := [
    (-3746272958108643)/(1125899906842624);
    (7947288320201633)/(562949953421312);
    (-2771089734467129)/(70368744177664);
    (5091887571352043)/(70368744177664);
    (-5201476416092959)/(70368744177664);
    (4482561154239233)/(140737488355328)
    ];
  eps := (43632613213955749923766106334964207863293713524559)/(5000000000000000000000000000000000000000000000000000000) ;
  iv := [("prior",
    ((1)/(4),
    (1)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``32:num``;

val _ = export_theory();
      