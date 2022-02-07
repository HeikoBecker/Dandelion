
(** File: Herbie, function: complex_sine_cosine **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG10dot0SEPsp10dot0_";

val _ = realZeroLib.useBinary := true;

(* err = 0.98621198528561399813274380218291376329828161069229 *)
(* infnorm = 0.98598857964436204886034856452908669393822726020895 *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "re");
    poly := [
    (-62004614277200580740371655124199695707787327592087)/(10000000000000000000000000000000000000000000000000000000000);
    (55511688754641685950019791562226600944995880126953)/(5000000000000000000000000000000000000000000000000000);
    (13313134503086834253157283707458963251113459591579)/(5000000000000000000000000000000000000000000000000000000000);
    (-22787612237849230712415093957901035537361167371273)/(25000000000000000000000000000000000000000000000000000);
    (-50611471883072504968844837716537669869421023349787)/(500000000000000000000000000000000000000000000000000000000000);
    (2484890008929791166761291698605873534688726067543)/(200000000000000000000000000000000000000000000000000000)
    ];
  eps := (98621198528561399813274380218291376329828161069229)/(100000000000000000000000000000000000000000000000000) ;
  iv := [("re",
    ((-10)/(1),
    (10)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``32:num``;

val _ = export_theory();
      