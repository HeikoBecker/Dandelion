open realZeroLib bitArithLib preambleDandelion;

val _ = new_theory "sinMin2Deg5";

val _ = realZeroLib.useBinary := true;

val _ = use_karatsuba();

Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Sin (Bop Sub (Var "x") (Cst 2));
  poly := [
     -8208482357958339  * inv ( 2 pow  53 );
     -233788731970899  * inv ( 2 pow  49 );
     8416541683015153  * inv ( 2 pow  54 );
     285656139742515  * inv ( 2 pow  52 );
     -3401076656520647  * inv ( 2 pow  56 );
     8562074976919383  * inv ( 2 pow  61 );
    ];
  eps :=  135903404387498251981256474445648163477172895723  * inv (2 pow 165 );
  iv := [ ("x",
    ( -1  * inv (2 pow 0 ),
      3  * inv (2 pow 0 )))];
|>
End

Theorem checkerSucceeds = validateCert cos_example_def “32:num”;

val _ = export_theory();
