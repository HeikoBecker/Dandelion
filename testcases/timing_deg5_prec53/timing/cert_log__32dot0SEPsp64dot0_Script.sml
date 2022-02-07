
(** File: LogTwo, function: logTwo **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_log__32dot0SEPsp64dot0_";

val _ = realZeroLib.useBinary := true;

(* err = 8.7000265359817905212941791592570015737202494079544e-6 *)
(* infnorm = 8.6912305772294069669235078988882866547818846884766e-6 *)
Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "x");
    poly := [
    (76233573411069532888006961002247408032417297363281)/(50000000000000000000000000000000000000000000000000);
    (11029078095527797276353965116868494078516960144043)/(100000000000000000000000000000000000000000000000000);
    (-375552688782674923642125597300633899067179299891)/(156250000000000000000000000000000000000000000000000);
    (6900794458639271768476963764271658874349668622017)/(200000000000000000000000000000000000000000000000000000);
    (-1721024179217384659958399754572933026963710290147)/(6250000000000000000000000000000000000000000000000000000);
    (1853943840684762500922586536331038153946337843081)/(2000000000000000000000000000000000000000000000000000000000)
    ];
  eps := (10875033169977238151617723949071251967150311759943)/(1250000000000000000000000000000000000000000000000000000) ;
  iv := [("x",
    ((32)/(1),
    (64)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert log_example_def ``32:num``;

val _ = export_theory();
      