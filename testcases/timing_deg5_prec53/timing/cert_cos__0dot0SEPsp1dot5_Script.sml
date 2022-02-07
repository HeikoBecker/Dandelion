
(** File: Benchmarks_small, function: rodriguesRotation **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot0SEPsp1dot5_";

val _ = realZeroLib.useBinary := true;

(* err = 5.5701092219995238091875207804712872428630353118605e-6 *)
(* infnorm = 5.553418876104236392481622191682170304010018674687e-6 *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "theta");
    poly := [
    (100000555340123353786907500762026757001876831054687)/(100000000000000000000000000000000000000000000000000);
    (-13708124903968427156161768998288152943132445216179)/(50000000000000000000000000000000000000000000000000000);
    (-24890169024547684206716269272874342277646064758301)/(50000000000000000000000000000000000000000000000000);
    (-4044011317886317988072597540138986005331389605999)/(625000000000000000000000000000000000000000000000000);
    (25188834034630104563579067189493798650801181793213)/(500000000000000000000000000000000000000000000000000);
    (-5529972933606712090504053946915519190952181816101)/(1000000000000000000000000000000000000000000000000000)
    ];
  eps := (11140218443999047618375041560942574485726070623721)/(2000000000000000000000000000000000000000000000000000000) ;
  iv := [("theta",
    ((0)/(1),
    (3)/(2)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``32:num``;

val _ = export_theory();
      