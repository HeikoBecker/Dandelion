
(** File: FPTaylorReal2Float, function: hartman3 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__0dot0SEPsp9dot102017499_";

val _ = realZeroLib.useBinary := true;

(* err = 99.955972215440319215936569058058313053242717022967 *)
(* infnorm = 81.276387425659067539351840592927021475083985970956 *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e2");
    poly := [
    (-2824452107984299)/(35184372088832);
    (4801290601939263)/(8796093022208);
    (-2573368065331661)/(4398046511104);
    (1953115642308747)/(8796093022208);
    (-2447399133585175)/(70368744177664);
    (1115177561758753)/(562949953421312)
    ];
  eps := (99955972215440319215936569058058313053242717022967)/(1000000000000000000000000000000000000000000000000) ;
  iv := [("e2",
    ((0)/(1),
    (9102017499)/(1000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``32:num``;

val _ = export_theory();
      