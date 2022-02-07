
(** File: CompoundFunction, function: compundExp **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__3dot0SEPsp5dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (46015292476576577100863258479708621445016389106941)/(10000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x");
    poly := [
    (4858201630500191)/(562949953421312);
    (-4090179878514257)/(562949953421312);
    (17042933285997523551458243673550896346569061279297)/(10000000000000000000000000000000000000000000000000);
    (-23395511372204477740233130589331267401576042175293)/(200000000000000000000000000000000000000000000000000)
    ];
  eps := (46015292476576577100863258479708621445016389106941)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((3)/(1),
    (5)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      