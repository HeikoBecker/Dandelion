open realZeroLib bitArithLib preambleDandelion;

val _ = new_theory "harrisonCertificate";

val _ = use_karatsuba();

Definition harrisonExample_def:
  harrisonExample =
  <|
    transc := Bop Sub (Fun Exp (Var "x")) (Cst 1) ;
poly := [
        0;
        1;
        8388676 * inv (2 pow 24);
        11184876 * inv (2 pow 26);
      ];
  eps :=  (23/27) * inv (2 pow 33);
  iv := [ ("x", (900000 / 2 pow 28, 10831/1000000))];
  |>
End

Theorem checkerSucceeds = validateCert harrisonExample_def “16:num”;

val _ = export_theory();
