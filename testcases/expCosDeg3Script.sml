open realZeroLib bitArithLib preambleDandelion;

val _ = new_theory "expCosDeg3";

val _ = realZeroLib.useBinary := true;

val _ = use_karatsuba();

Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Exp (Bop Add (Fun Cos (Var "x")) (Cst 2));
  poly := [
     5256139  * inv ( 2 pow  18 );
     4302101  * inv ( 2 pow  23 );
     -6515169  * inv ( 2 pow  19 );
     297761  * inv ( 2 pow  16 );
    ];
  eps :=  13929679664587246653295108110621519728546392263  * inv (2 pow 161 );
  iv := [ ("x",
    ( 1 / 10,
      1  * inv (2 pow 0 )))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def “16:num”;

val _ = export_theory();
