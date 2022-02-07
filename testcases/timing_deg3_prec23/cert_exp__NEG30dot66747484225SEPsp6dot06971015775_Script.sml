
(** File: FPTaylorReal2Float, function: hartman3 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG30dot66747484225SEPsp6dot06971015775_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (4406285693774171499591598564678852303791461762901)/(40000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e4");
    poly := [
    (-8249521)/(262144);
    (2108337)/(65536);
    (7878419)/(2097152);
    (6107933)/(67108864)
    ];
  eps := (4406285693774171499591598564678852303791461762901)/(40000000000000000000000000000000000000000000000) ;
  iv := [("e4",
    ((-122669899369)/(4000000000),
    (24278840631)/(4000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      