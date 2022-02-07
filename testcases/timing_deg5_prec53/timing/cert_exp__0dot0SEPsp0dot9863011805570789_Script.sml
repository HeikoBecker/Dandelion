
(** File: CompoundFunction, function: compundExp2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__0dot0SEPsp0dot9863011805570789_";

val _ = realZeroLib.useBinary := true;

(* err = 1.05068133541189327112180732403349472268780114062225e-6 *)
(* infnorm = 1.03246900313131083559269883330937254651859967341977e-6 *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "_tmp6");
    poly := [
    (49999948376752034739922692097024992108345031738281)/(50000000000000000000000000000000000000000000000000);
    (25001841445389988427550065352988895028829574584961)/(25000000000000000000000000000000000000000000000000);
    (1559844196985669603772173275046952767297625541687)/(3125000000000000000000000000000000000000000000000);
    (85114464734171210724689160542766330763697624206543)/(500000000000000000000000000000000000000000000000000);
    (35023496498233434859326251853417488746345043182373)/(1000000000000000000000000000000000000000000000000000);
    (3451089295393482744150892571610711456742137670517)/(250000000000000000000000000000000000000000000000000)
    ];
  eps := (4202725341647573084487229296133978890751204562489)/(4000000000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp6",
    ((0)/(1),
    (4441905629231941)/(4503599627370496)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``32:num``;

val _ = export_theory();
      