
(** File: Benchmarks_small, function: pendulum2 **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_sin__0dot025SEPsp1dot525_";

val _ = realZeroLib.useBinary := true;

(* err = 5.3335948393816482190753115074275255035313367816127e-6 *)
(* infnorm = 5.313397963175931189347143201167054909837359489898e-6 *)
Definition sin_example_def:
  sin_example =
  <|
    transc := Fun Sin (Var "_tmp20");
    poly := [
    (12636620685609658556666778927990435477113351225853)/(1000000000000000000000000000000000000000000000000000000);
    (99965541425386195140134759640204720199108123779297)/(100000000000000000000000000000000000000000000000000);
    (5494588305004669643791248567765705956844612956047)/(2500000000000000000000000000000000000000000000000000);
    (-86037941435732900874455708617460913956165313720703)/(500000000000000000000000000000000000000000000000000);
    (14714700269637804967703953451518827932886779308319)/(2500000000000000000000000000000000000000000000000000);
    (57959373982417652232390636868331057485193014144897)/(10000000000000000000000000000000000000000000000000000)
    ];
  eps := (53335948393816482190753115074275255035313367816127)/(10000000000000000000000000000000000000000000000000000000) ;
  iv := [("_tmp20",
    ((1)/(40),
    (61)/(40)))];
  |>
End

Theorem checkerSucceeds = validateCert sin_example_def ``32:num``;

val _ = export_theory();
      