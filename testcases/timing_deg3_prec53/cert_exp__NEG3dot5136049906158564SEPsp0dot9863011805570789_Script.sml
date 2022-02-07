
(** File: CompoundFunction, function: compundExp2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG3dot5136049906158564SEPsp0dot9863011805570789_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (51516131096519683925566681223208513212987085463929)/(1000000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "_tmp6");
    poly := [
    (10211066577180407666247674569603987038135528564453)/(10000000000000000000000000000000000000000000000000);
    (1380221622141149795393033627988188527524471282959)/(1250000000000000000000000000000000000000000000000);
    (1462968638394433404381622665368922753259539604187)/(3125000000000000000000000000000000000000000000000);
    (6782038428225500847901230372372083365917205810547)/(100000000000000000000000000000000000000000000000000)
    ];
  eps := (51516131096519683925566681223208513212987085463929)/(1000000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp6",
    ((-7911935063232343)/(2251799813685248),
    (4441905629231941)/(4503599627370496)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      