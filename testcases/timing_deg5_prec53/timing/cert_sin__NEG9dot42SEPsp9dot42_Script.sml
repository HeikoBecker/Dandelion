
(** File: TransBenchsErrorBoundsSmall, function: xu2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__NEG9dot42SEPsp9dot42_";

val _ = realZeroLib.useBinary := true;

(* err = 0.9538576534424859451166122301044543900937581387188 *)
(* infnorm = 0.95318435309299902142040829672040421605310550726328 *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "x2");
    poly := [
    (-6228650793314503404920776489259257729935725933501)/(2500000000000000000000000000000000000000000000000000000000);
    (37280127632052309505361620267649414017796516418457)/(1000000000000000000000000000000000000000000000000000);
    (2167722607011563827855150007602007267148991331851)/(2000000000000000000000000000000000000000000000000000000000);
    (-7758915295584760786831712842115393868880346417427)/(2500000000000000000000000000000000000000000000000000);
    (-10413603003159836493718820800146335767491501123061)/(250000000000000000000000000000000000000000000000000000000000);
    (43155569729591855370181424644826506664685439318419)/(1000000000000000000000000000000000000000000000000000000)
    ];
  eps := (2384644133606214862791530575261135975234395346797)/(2500000000000000000000000000000000000000000000000) ;
  iv := [("x2",
    ((-471)/(50),
    (471)/(50)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``32:num``;

val _ = export_theory();
      