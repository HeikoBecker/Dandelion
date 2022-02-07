
(** File: FPTaylorReal2Float, function: hartman6 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG22dot240841603SEPsp7dot979168397_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (16735812457901706863758948318653625001544393171417)/(25000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e1");
    poly := [
    (-1236441)/(2048);
    (2623199)/(32768);
    (3477621)/(131072);
    (2174729)/(2097152)
    ];
  eps := (16735812457901706863758948318653625001544393171417)/(25000000000000000000000000000000000000000000000) ;
  iv := [("e1",
    ((-22240841603)/(1000000000),
    (7979168397)/(1000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      