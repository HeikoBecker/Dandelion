
(** File: FPTaylorReal2Float, function: hartman3 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG25dot09723033SEPsp7dot60706967_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (24116757753182580967541437046893139855620730499881)/(50000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e1");
    poly := [
    (-6151453)/(16384);
    (5423629)/(65536);
    (4628871)/(262144);
    (2428089)/(4194304)
    ];
  eps := (24116757753182580967541437046893139855620730499881)/(50000000000000000000000000000000000000000000000) ;
  iv := [("e1",
    ((-2509723033)/(100000000),
    (760706967)/(100000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      