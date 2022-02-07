open realZeroLib bitArithLib preambleDandelion;

val _ = new_theory "expCosDeg5";

val _ = realZeroLib.useBinary := true;

val _ = use_karatsuba();

Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Exp (Bop Add (Fun Cos (Var "x")) (Cst 2));
 poly := [
     5653498221684379  * inv ( 2 pow  48 );
     5921595278064889  * inv ( 2 pow  62 );
     -2818185199843715  * inv ( 2 pow  48 );
     -1257220546871335  * inv ( 2 pow  52 );
     4793690400369349  * inv ( 2 pow  50 );
     -3083550346653077  * inv ( 2 pow  51 );
    ];
  eps :=  16688947687386876169149599501463102725036927887039  * inv (2 pow 178 );
  iv := [ ("x",
    ( 37414441915671114706014331717536845303191873100185  * inv (2 pow 168 ),
      1  * inv (2 pow 0 )))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def “32:num”;

val _ = export_theory();
