
(** File: FPTaylorReal2Float, function: azimuth **)
open realZeroLib preambleDandelion;

val _ = new_theory "cert_cos__0dot0SEPsp0dot4_";

val _ = realZeroLib.useBinary := true;

(* infnorm = (110075886131743551374453105274434321460563953993123)/(10000000000000000000000000000000000000000000000000000000) *)
Definition cos_example_def:
  cos_example =
  <|
    transc := Fun Cos (Var "lat1");
    poly := [
    (99999184896443449321878915725392289459705352783203)/(100000000000000000000000000000000000000000000000000);
    (32714172470974862321282938815159013756783679127693)/(50000000000000000000000000000000000000000000000000000);
    (-2541047164662327273454422993381740525364875793457)/(5000000000000000000000000000000000000000000000000);
    (4126542758421348697228658863878081319853663444519)/(125000000000000000000000000000000000000000000000000)
    ];
  eps := (110075886131743551374453105274434321460563953993123)/(10000000000000000000000000000000000000000000000000000000) ;
  iv := [("lat1",
    ((0)/(1),
    (2)/(5)))];
  |>
End

Theorem checkerSucceeds = validateCert cos_example_def ``20:num``;

val _ = export_theory();
      