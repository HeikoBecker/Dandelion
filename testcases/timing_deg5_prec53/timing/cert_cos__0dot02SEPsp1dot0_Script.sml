
(** File: Benchmarks_small, function: xu2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot02SEPsp1dot0_";

val _ = realZeroLib.useBinary := true;

(* err = 5.2716612312823534686203571922522757569849514402834e-7 *)
(* infnorm = 5.2002431179673158317596553797813798625215786157172e-7 *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x2");
    poly := [
    (1125901591423941)/(1125899906842624);
    (-598674981052272251022712545864834510211949236691)/(10000000000000000000000000000000000000000000000000000);
    (-24970041383904312271013736790337134152650833129883)/(50000000000000000000000000000000000000000000000000);
    (-6004865923309182654601934281402009219164028763771)/(2500000000000000000000000000000000000000000000000000);
    (9237166927199919053137477931159082800149917602539)/(200000000000000000000000000000000000000000000000000);
    (-8043726817326296227306237085485918214544653892517)/(2000000000000000000000000000000000000000000000000000)
    ];
  eps := (26358306156411767343101785961261378784924757201417)/(50000000000000000000000000000000000000000000000000000000) ;
  iv := [("x2",
    ((1)/(50),
    (1)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``32:num``;

val _ = export_theory();
      