
(** File: FPTaylorReal2Float, function: hartman3 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__0dot0SEPsp7dot60706967_";

val _ = realZeroLib.useBinary := true;

(* err = 13.275282007019609395114421115363956601573452939001 *)
(* infnorm = 10.3968943672913850345956490122732712130038103417375 *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e1");
    poly := [
    (-661243015244395)/(70368744177664);
    (6056201868621411)/(70368744177664);
    (-3911744537823597)/(35184372088832);
    (228673858767229)/(4398046511104);
    (-5620489063289607)/(562949953421312);
    (35988778798980025630527279645320959389209747314453)/(50000000000000000000000000000000000000000000000000)
    ];
  eps := (13275282007019609395114421115363956601573452939001)/(1000000000000000000000000000000000000000000000000) ;
  iv := [("e1",
    ((0)/(1),
    (760706967)/(100000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``32:num``;

val _ = export_theory();
      