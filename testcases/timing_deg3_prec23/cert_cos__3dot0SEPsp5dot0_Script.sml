
(** File: CompoundFunction, function: compundExp **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__3dot0SEPsp5dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (46016606467657848865783798113573086357514956983417)/(10000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (1131139)/(131072);
    (-3809279)/(524288);
    (893541)/(524288);
    (-7850235)/(67108864)
    ];
  eps := (46016606467657848865783798113573086357514956983417)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((3)/(1),
    (5)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      