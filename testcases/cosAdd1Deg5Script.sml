open realZeroLib bitArithLib preambleDandelion;

val _ = new_theory "cosAdd1Deg5";

val _ = realZeroLib.useBinary := true;

val _ = use_karatsuba();

Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Bop Add (Var "x") (Cst 1));
  poly := [
     1216583928184977  * inv ( 2 pow  51 );
     -946383813482461  * inv ( 2 pow  50 );
     -1236269302463055  * inv ( 2 pow  52 );
     2654796087309299  * inv ( 2 pow  54 );
     2626760751453539  * inv ( 2 pow  57 );
     -1996771013603881  * inv ( 2 pow  58 );
    ];
  eps :=  23411789487464686001273220162738075733383647011311  * inv (2 pow 179 );
  iv := [ ("x",
    ( 0  * inv (2 pow 0 ),
      12510454015552528979823542168051382648254782567875  * inv (2 pow 162 )))];
|>
End

Theorem checkerSucceeds = validateCert cos_example_def “32:num”;

val _ = export_theory();
