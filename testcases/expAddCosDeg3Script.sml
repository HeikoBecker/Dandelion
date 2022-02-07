open realZeroLib bitArithLib preambleDandelion;

val _ = new_theory "expAddCosDeg3";

val _ = realZeroLib.useBinary := true;
val _ = createMetiTarskiQuery := false
val _ = use_karatsuba();

Definition cos_example_def:
  cos_example =
  <|
    transc := Bop Add (Fun Exp (Bop Mul (Var "x") (Cst (1/2:real)))) (Fun Cos (Bop Mul (Var "x") (Cst (1/2:real))));
poly := [
     9007199045267507  * inv ( 2 pow  52 );
     4503607326537297  * inv ( 2 pow  53 );
     -3241616109733325  * inv ( 2 pow  69 );
     375588665660545  * inv ( 2 pow  54 );
     5979080956143783  * inv ( 2 pow  60 );
     5038332231908613  * inv ( 2 pow  64 );
    ];
  eps :=  27896958177787588423236394485375286824270176601341  * inv (2 pow 192 );
  iv := [ ("x",
    ( 37414441915671114706014331717536845303191873100185  * inv (2 pow 168 ),
      1  * inv (2 pow 0 )))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def “16:num”;

val _ = export_theory();
