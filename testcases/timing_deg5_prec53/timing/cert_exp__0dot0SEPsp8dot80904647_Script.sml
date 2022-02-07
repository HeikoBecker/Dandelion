
(** File: FPTaylorReal2Float, function: hartman3 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__0dot0SEPsp8dot80904647_";

val _ = realZeroLib.useBinary := true;

(* err = 67.999847827283397640683186021598499939750033377375 *)
(* infnorm = 54.97141872985742924770010135623450620726560980638 *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e3");
    poly := [
    (-118683503845947)/(2199023255552);
    (3370351272243097)/(8796093022208);
    (-935788476422983)/(2199023255552);
    (5899461311429327)/(35184372088832);
    (-3837474712609995)/(140737488355328);
    (1823579534240549)/(1125899906842624)
    ];
  eps := (543998782618267181125465488172787999518000267019)/(8000000000000000000000000000000000000000000000) ;
  iv := [("e3",
    ((0)/(1),
    (880904647)/(100000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``32:num``;

val _ = export_theory();
      