
(** File: CompoundFunction, function: compundExp2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG3dot5136049906158564SEPsp0dot9863011805570789_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (12879038002864411433577989635704059328095200208423)/(250000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "_tmp6");
    poly := [
    (267677)/(262144);
    (4631255)/(4194304);
    (1963563)/(4194304);
    (1137837)/(16777216)
    ];
  eps := (12879038002864411433577989635704059328095200208423)/(250000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp6",
    ((-7911935063232343)/(2251799813685248),
    (4441905629231941)/(4503599627370496)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      