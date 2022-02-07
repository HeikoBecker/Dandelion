
(** File: FPTaylorReal2Float, function: azimuth **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot5SEPsp1dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (148498137918684287049934841599622265402519576531733)/(10000000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "lat2");
    poly := [
    (8308691)/(8388608);
    (7395603)/(134217728);
    (-40525)/(65536);
    (1897087)/(16777216)
    ];
  eps := (148498137918684287049934841599622265402519576531733)/(10000000000000000000000000000000000000000000000000000000) ;
  iv := [("lat2",
    ((1)/(2),
    (1)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      