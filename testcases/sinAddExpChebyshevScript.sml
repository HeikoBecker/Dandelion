open realZeroLib bitArithLib preambleDandelion;

val _ = new_theory "sinAddExpChebyshev";

val _ = use_karatsuba();

Definition sinAddExp_example_def:
  cos_example =
  <|
    transc := Bop Add (Fun Sin (Bop Mul (Cst 3) (Var "x"))) (Fun Exp (Bop Mul (Var "x") (Cst (1/2)))) ;
  poly := [
     8808144721120757  * inv ( 2 pow  53 );
     590999138684017  * inv ( 2 pow  47 );
     -1775071453592149  * inv ( 2 pow  49 );
     -2317614563300631  * inv ( 2 pow  53 );
    ];
  eps :=  13924549503659  * inv (2 pow 49 );
  iv := [("x",
    ( 0  * inv (2 pow 0 ),
      1  * inv (2 pow 0 )))];
  |>
End

Theorem checkerSucceeds = validateCert sinAddExp_example_def “32:num”;

val _ = export_theory();
