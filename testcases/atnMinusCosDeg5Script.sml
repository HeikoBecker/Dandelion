open realZeroLib bitArithLib preambleDandelion;

val _ = new_theory "atnMinusCosDeg5";

val _ = realZeroLib.useBinary := true;
val _ = realZeroLib.createMetiTarskiQuery := false;
val _ = use_karatsuba();

Definition cos_example_def:
  cos_example =
  <|
transc := Bop Sub (Fun Atn (Var "x"))
		(Fun Cos (Bop Mul (Cst (3/4)) (Var "x")));
poly := [
     -9007198756544201  * inv ( 2 pow  53 );
     9005679539555891  * inv ( 2 pow  53 );
     5066449688488517  * inv ( 2 pow  54 );
     -5902225100586553  * inv ( 2 pow  54 );
     -3778049690265979  * inv ( 2 pow  58 );
     5416651390494637  * inv ( 2 pow  55 );
    ];
  eps :=  4507416436400873246072032534221712193802108990219  * inv (2 pow 178 );
  iv := [ ("x",
    ( -1  * inv (2 pow 1 ),
      1  * inv (2 pow 1 )))];
|>
End

Theorem checkerSucceeds = validateCert cos_example_def “32:num”;

val _ = export_theory();
