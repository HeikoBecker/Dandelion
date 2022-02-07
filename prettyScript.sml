open polyTheory transcTheory;
open sturmTheory sturmComputeTheory realPolyTheory;
open preambleDandelion;

val _ = new_theory "pretty";

val _ = add_infix ("divides", 401, HOLgrammars.RIGHT);

Definition divides_def:
  (p1 divides p2) = (p1 poly_divides p2)
End

Theorem divides_exists_def = poly_divides |> REWRITE_RULE [GSYM divides_def]

val _ = map Parse.overload_on [
    ("+p", Term ‘poly$poly_add’),
    ("*c", Term ‘poly$##’)
    ]

val _ = map (uncurry set_fixity)
            [ ("+p", Infix(NONASSOC, 461)),
              ("-p", Infix(NONASSOC, 461)),
              ("*p", Infix(NONASSOC, 470)),
              ("*c", Infix(NONASSOC, 470)),
              ("**p",Infix(NONASSOC, 471))
            ]

Theorem sturm_nc_def = STURM_def |> REWRITE_RULE [GSYM divides_def]
                                 |> SIMP_RULE std_ss [PULL_FORALL]
                                 |> Q.SPECL [‘f’, ‘f'’, ‘f’, ‘f'’]
                                 |> GEN  “f':real list” |> GEN “f:real list”

Theorem sturm_c_def = sturm_seq_def |> SIMP_RULE std_ss [PULL_FORALL]

val _ = export_theory();
