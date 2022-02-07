
(** File: FPTaylorReal2Float, function: hartman3 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG19dot23665353SEPsp8dot80904647_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (36709847836099313867934989252518290181709698522839)/(25000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e3");
    poly := [
    (-5986199)/(4096);
    (7812983)/(262144);
    (7509607)/(131072);
    (6078559)/(2097152)
    ];
  eps := (36709847836099313867934989252518290181709698522839)/(25000000000000000000000000000000000000000000000) ;
  iv := [("e3",
    ((-1923665353)/(100000000),
    (880904647)/(100000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      