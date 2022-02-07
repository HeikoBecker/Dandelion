open realZeroLib bitArithLib preambleDandelion;

val _ = new_theory "sinAdd2Chebyshev";

val _ = createMetiTarskiQuery := false;

val _ = use_karatsuba();

Definition sin_example_def:
  cos_example =
  <|
    transc := Fun Sin (Bop Add (Var "x") (Cst 2)) ;
poly := [
     127912676092593  * inv ( 2 pow  47 );
     -1874032436841611  * inv ( 2 pow  52 );
     -4064547224468285  * inv ( 2 pow  53 );
     4981561559294101  * inv ( 2 pow  56 );
     2436476015744097  * inv ( 2 pow  56 );
     -3687984065622289  * inv ( 2 pow  60 );
    ];
  eps :=  3421382122629  * inv (2 pow 52 );
  iv := [("x",
    ( -3  * inv (2 pow 1 ),
      3  * inv (2 pow 1 )))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def “32:num”;

val _ = export_theory();
