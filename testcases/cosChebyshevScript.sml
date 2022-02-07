open realZeroLib bitArithLib preambleDandelion;

val _ = new_theory "cosChebyshev";

val _ = use_karatsuba();

Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x") ;
 poly := [
     4503636143957169  * inv ( 2 pow  52 );
     -5557330530459  * inv ( 2 pow  55 );
     -2247086872957039  * inv ( 2 pow  52 );
     -119938828703157  * inv ( 2 pow  55 );
     13562838948249867  * inv ( 2 pow  58 );
     -1246401865678091  * inv ( 2 pow  58 );
    ];
  eps :=  12134270522769147  * inv (2 pow 75 );
  iv := 
    [ ("x", ( 14411518807585587  * inv (2 pow 57 ),
      1  * inv (2 pow 0 )))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def “32:num”;

val _ = export_theory();
