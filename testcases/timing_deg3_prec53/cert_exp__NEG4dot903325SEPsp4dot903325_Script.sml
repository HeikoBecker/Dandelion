
(** File: TransBenchsErrorBoundsSmall, function: pendulum2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG4dot903325SEPsp4dot903325_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (108914138901329238690240039034895471814628549512237)/(10000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "_tmp31");
    poly := [
    (-65812273669874832293658073467668145895004272460937)/(10000000000000000000000000000000000000000000000000);
    (-2775885938447489)/(562949953421312);
    (26255364778908503176069189066765829920768737792969)/(10000000000000000000000000000000000000000000000000);
    (77652018756039897784404502090183086693286895751953)/(100000000000000000000000000000000000000000000000000)
    ];
  eps := (108914138901329238690240039034895471814628549512237)/(10000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp31",
    ((-196133)/(40000),
    (196133)/(40000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      