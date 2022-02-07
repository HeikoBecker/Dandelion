open realZeroLib preambleDandelion;

val _ = new_theory "expDeg7";

(* val _ = use_karatsuba(); *)

Definition exp_example_def:
  exp_example =
<|
  transc := Fun Exp (Var "x");
  poly := [
     1125899905426745  * inv ( 2 pow  50 );
     1125900085623201  * inv ( 2 pow  50 );
     9007140034442381  * inv ( 2 pow  54 );
     6005731712237291  * inv ( 2 pow  55 );
     1497611604427873  * inv ( 2 pow  55 );
     2461450700531187  * inv ( 2 pow  58 );
     166524220724989  * inv ( 2 pow  57 );
     760876843852891  * inv ( 2 pow  61 );
    ];
  eps :=  7379504701367032240254461165456153838783  * inv (2 pow 162 );
  iv := [ ("x",
    ( 0  * inv (2 pow 0 ),
      1  * inv (2 pow 0 )))];
|>
End

Theorem checkerSucceeds = validateCert exp_example_def “20:num”;

val _ = export_theory();
