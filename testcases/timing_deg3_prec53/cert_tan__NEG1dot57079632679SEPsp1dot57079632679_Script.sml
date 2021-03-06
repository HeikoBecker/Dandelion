
(** File: AllTrig, function: tangent **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_tan__NEG1dot57079632679SEPsp1dot57079632679_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (6395924753533554005098488420255215779443920244723)/(62500000000000000000000000000000000000) *)
Definition tan_example_def:
  tan_example =
  <|
    transc := Fun Tan (Var "x");
    poly := [
    (-36766945835325)/(134217728);
    (-3195165958493431)/(16384);
    (7629916925782207)/(68719476736);
    (6906429762651001)/(65536)
    ];
  eps := (6395924753533554005098488420255215779443920244723)/(62500000000000000000000000000000000000) ;
  iv := [("x",
    ((-157079632679)/(100000000000),
    (157079632679)/(100000000000)))];
  |>
End

Theorem checkerSucceeds = validateCert tan_example_def ``20:num``;

val _ = export_theory();
      