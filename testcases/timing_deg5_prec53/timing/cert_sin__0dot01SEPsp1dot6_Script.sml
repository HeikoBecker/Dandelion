
(** File: Benchmarks_small, function: pendulum1 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot01SEPsp1dot6_";

val _ = realZeroLib.useBinary := true;

(* err = 7.7686199882727997157574199272667930545060898931257e-6 *)
(* infnorm = 7.7452307875867233965043568481714860225684357492424e-6 *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "t");
    poly := [
    (56734977865572818126328573373751140707099693827331)/(5000000000000000000000000000000000000000000000000000000);
    (99961510808691211860121939025702886283397674560547)/(100000000000000000000000000000000000000000000000000);
    (126614629114634022130636559211325220530852675437927)/(50000000000000000000000000000000000000000000000000000);
    (-675135307726018813259671880189216608414426445961)/(3906250000000000000000000000000000000000000000000);
    (6541042775430329705987908539555064635351300239563)/(1000000000000000000000000000000000000000000000000000);
    (14011016321212525596873188504787322017364203929901)/(2500000000000000000000000000000000000000000000000000)
    ];
  eps := (77686199882727997157574199272667930545060898931257)/(10000000000000000000000000000000000000000000000000000000) ;
  iv := [("t",
    ((1)/(100),
    (8)/(5)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``32:num``;

val _ = export_theory();
      