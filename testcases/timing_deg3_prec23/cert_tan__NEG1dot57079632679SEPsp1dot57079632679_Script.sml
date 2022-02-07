
(** File: AllTrig, function: tangent **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_tan__NEG1dot57079632679SEPsp1dot57079632679_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (1023347855250827814178221537433894723767169330023)/(10000000000000000000000000000000000000) *)
Definition tan_example_def:
  tan_example =
  <|
    transc := Fun Tan (Var "x");
    poly := [
    (-273935)/(1);
    (-195017408512)/(1);
    (7105911)/(64);
    (105383739392)/(1)
    ];
  eps := (1023347855250827814178221537433894723767169330023)/(10000000000000000000000000000000000000) ;
  iv := [("x",
    ((-157079632679)/(100000000000),
    (157079632679)/(100000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert tan_example_def ``20:num``;

val _ = export_theory();
      