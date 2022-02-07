open realZeroLib preambleDandelion;

val _ = new_theory "INEQTACtests";

Theorem test:
! x. -1 <= x /\ x <= 2 ==> (x * x * x + x * x - 4 * x) <= 4:real
Proof
  REAL_INEQ_TAC
QED

Theorem random_test:
! x. - 2.1 <= x /\ x <= 1.5 ==> 5 * x * x * x * x + 4 * x * x * x - 9 * x *x + 2 * x - 5 <= 20:real
Proof
  REAL_INEQ_TAC
QED

Theorem random_test2:
  ! x. -1.97 <= x /\ x <= 1.37 ==> 3 * x *x *x * x + 3 * x * x * x - 2 * x * x - 5 <= 10
Proof
  REAL_INEQ_TAC
QED

val _ = export_theory();
