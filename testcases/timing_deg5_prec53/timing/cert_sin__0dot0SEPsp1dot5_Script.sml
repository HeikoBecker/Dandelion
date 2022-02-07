
(** File: Benchmarks_small, function: rodriguesRotation **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot0SEPsp1dot5_";

val _ = realZeroLib.useBinary := true;

(* err = 5.1977007214718840258403837308282362060888287971367e-6 *)
(* infnorm = 5.1777459240907850016187762705358215465679361792872e-6 *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "theta");
    poly := [
    (517772687874291722581222841004233714556903578341)/(100000000000000000000000000000000000000000000000000000);
    (24994056873651512851175482410326367244124412536621)/(25000000000000000000000000000000000000000000000000);
    (17595539900929948583935269468270234938245266675949)/(10000000000000000000000000000000000000000000000000000);
    (-4283573852188842651100841862898960243910551071167)/(25000000000000000000000000000000000000000000000000);
    (1672734071125767053769134440344146241841372102499)/(312500000000000000000000000000000000000000000000000);
    (7420042107079959656582013316494794707978144288063)/(1250000000000000000000000000000000000000000000000000)
    ];
  eps := (51977007214718840258403837308282362060888287971367)/(10000000000000000000000000000000000000000000000000000000) ;
  iv := [("theta",
    ((0)/(1),
    (3)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``32:num``;

val _ = export_theory();
      