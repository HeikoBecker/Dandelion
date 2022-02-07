
(** File: Benchmarks_small, function: pendulum1 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot01SEPsp1dot6_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (16557148605238326153072306260873485677751911229339)/(10000000000000000000000000000000000000000000000000000) *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "t");
    poly := [
    (-3728567)/(2147483648);
    (4312725)/(4194304);
    (-636161)/(8388608);
    (-3696105)/(33554432)
    ];
  eps := (16557148605238326153072306260873485677751911229339)/(10000000000000000000000000000000000000000000000000000) ;
  iv := [("t",
    ((1)/(100),
    (8)/(5)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``20:num``;

val _ = export_theory();
      