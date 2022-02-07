
(** File: TransBenchsErrorBoundsSmall, function: integrate18257 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_exp__NEG0dot9999987317275396SEPsp1dot0_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (12071767452140889752275406113671025341675032247117)/(2000000000000000000000000000000000000000000000000000) *)
Definition exp_example_def:
  exp_example =
  <|
    transc := Fun Exp (Var "_tmp6");
    poly := [
    (99457948965803300023225119730341248214244842529297)/(100000000000000000000000000000000000000000000000000);
    (99566766398208739197173144930275157094001770019531)/(100000000000000000000000000000000000000000000000000);
    (1696789796779209560928514122224441962316632270813)/(3125000000000000000000000000000000000000000000000);
    (8976679033685211472892717665672535076737403869629)/(50000000000000000000000000000000000000000000000000)
    ];
  eps := (12071767452140889752275406113671025341675032247117)/(2000000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp6",
    ((-1125898478894779)/(1125899906842624),
    (1)/(1)))];
  |>
End

Theorem checkerSucceeds = validateCert exp_example_def ``20:num``;

val _ = export_theory();
      