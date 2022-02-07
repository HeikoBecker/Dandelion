
(** File: CompoundFunction, function: compundExp **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG3dot7568024953079284SEPsp0dot9179327838016329_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (6558167384158745060555418412968282247765619763461)/(125000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "_tmp");
    poly := [
    (1081485)/(1048576);
    (4587579)/(4194304);
    (3692803)/(8388608);
    (1001041)/(16777216)
    ];
  eps := (6558167384158745060555418412968282247765619763461)/(125000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp",
    ((-16919134317973335)/(4503599627370496),
    (1033500435770049)/(1125899906842624)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      