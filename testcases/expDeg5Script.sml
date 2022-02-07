open realZeroLib bitArithLib preambleDandelion;

val _ = new_theory "expDeg5";

val _ = use_karatsuba();

Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "x");
    poly := [
        9007189080480811  * inv ( 2 pow  53 );
        562994683590669  * inv ( 2 pow  49 );
        8990916016722869  * inv ( 2 pow  54 );
        6139378123833441  * inv ( 2 pow  55 );
        5015290855595641  * inv ( 2 pow  57 );
        8014953567108575  * inv ( 2 pow  59 );
      ];
    eps :=  1271782579  * inv (2 pow 50 );
    iv := [ ("x",
    ( 0  * inv (2 pow 0 ),
      1  * inv (2 pow 0 )))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def “20:num”;

val _ = export_theory();
