open realZeroLib preambleDandelion;

val _ = new_theory "sinDeg7";

Definition sin_example_def:
  sin_example =
<|
  transc := Fun Sin (Var "x");
  poly := [
     -4541078812227245  * inv ( 2 pow  78 );
     2251800657665503  * inv ( 2 pow  51 );
     -8591718204578285  * inv ( 2 pow  71 );
     -6004148135820653  * inv ( 2 pow  55 );
     -934797677073871  * inv ( 2 pow  64 );
     4851231450188095  * inv ( 2 pow  59 );
     -5464083178697541  * inv ( 2 pow  66 );
     -774607737846209  * inv ( 2 pow  62 );
    ];
  eps :=  32037369045855798330882206963044555433501  * inv (2 pow 167 );
  iv := [ ("x",
    ( 37414441915671114706014331717536845303191873100185  * inv (2 pow 168 ),
      1  * inv (2 pow 0 )))];
|>
End

Theorem checkerSucceeds = validateCert sin_example_def “20:num”;

val _ = export_theory();
