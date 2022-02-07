
(** File: FPTaylorReal2Float, function: hartman6 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG22dot240841603SEPsp7dot979168397_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (33471624753943486551819126816479823171512235602273)/(50000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "e1");
    poly := [
    (-1327618405098073)/(2199023255552);
    (2816638859320329)/(35184372088832);
    (7468133842897585)/(281474976710656);
    (291887161630917)/(281474976710656)
    ];
  eps := (33471624753943486551819126816479823171512235602273)/(50000000000000000000000000000000000000000000000) ;
  iv := [("e1",
    ((-22240841603)/(1000000000),
    (7979168397)/(1000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      