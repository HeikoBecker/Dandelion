
(** File: Benchmarks_small, function: xu2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot02SEPsp1dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (7122847408783895713711988582139631909261614622429)/(20000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "x2");
    poly := [
    (1125392225340631)/(1125899906842624);
    (52790229621056681055812909164615120971575379371643)/(5000000000000000000000000000000000000000000000000000);
    (-2749862775860723584919753648136975243687629699707)/(5000000000000000000000000000000000000000000000000);
    (7990861961486761533279832292464561760425567626953)/(100000000000000000000000000000000000000000000000000)
    ];
  eps := (7122847408783895713711988582139631909261614622429)/(20000000000000000000000000000000000000000000000000000) ;
  iv := [("x2",
    ((1)/(50),
    (1)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      