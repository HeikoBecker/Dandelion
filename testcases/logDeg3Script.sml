open realZeroLib bitArithLib preambleDandelion;

val _ = new_theory "logDeg3";

val _ = use_karatsuba();

Definition log_example_def:
  log_example =
  <|
    transc := Fun Log (Var "x") ;
  poly := [
     -3741096325  * inv ( 2 pow  31 );
     2938287119  * inv ( 2 pow  30 );
     -669132811  * inv ( 2 pow  29 );
     2164234537  * inv ( 2 pow  33 );
    ];
  eps :=  25852724876412357694111826447959374196439680993175  * inv (2 pow 183 );
  iv := [ ("x",
    ( 1001 / 1000, 12/10))];
|>
End

Theorem checkerSucceeds = validateCert log_example_def “12:num”;

val _ = export_theory();
