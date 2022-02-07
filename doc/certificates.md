# Certificates for Remez algorithm

For a transcendental function $`f`$, set of points $`\Omega`$, and error bound
$`\varepsilon`$ Remez algorithm computes a polynomial approximation $`p`$.

According to the description from the elementary functions book, Remez
guarantees two properties:

1. $`|f(x_i) - p(x_i)| = \varepsilon \quad{} \forall x_i \in \Omega`$
2. $`\max_{x \in [a,b]} |f(x) - p(x)| \leq \varepsilon`$

The first correctness criterion is already being checked by the `pointChecker`
in the file [pointCheckerScript.sml](../pointCheckerScript.sml).
A soundness proof establishing the first property is given in
[pointCheckerProofsScript.sml](../pointCheckerProofsScript.sml).

Next, we describe the key steps and certificate contents required for proving
the second property.

A Remez certificate is a structure `<| transc:real->real; poly: real poly; omega:real list; eps:real; iv: real#real|>`
,

where `transc` is the function $`f`$,

`poly` is the polynomial $`p`$,

`omega` is a set of points $`\Omega`$,

`eps` is the error constraint $`\varepsilon`$,

and `iv` is the interval $`[a,b]`$.

The key insight to establishing the second property is that Remez algorithm
relies on the invariant that the error between the transcendental function and the
result polynomial *equi-oscillates* between $`\varepsilon`$.
This means that for $`x_i, x_{i+1} \in \Omega`$,
$`(f(x_i) - p(x_i))' = -1 * (f(x_{i+1}) - p(x_{i+1}))'`$.

As $`f`$ is a transcendental function, we do not know a priori how many 0's
the function $`|f(x) - p(x)|`$ may have. This makes checking the property
complicated.

Following the approach by John Harrison, we will approximate $`f`$ by a
"good-enough" polynomial such that we can bound the degree of the polynomial
and get an accurate enough estimate of the roundoff error of the polynomial.
Such good-enough polynomials should be proven correct once and for all in HOL4
as library functions that are used by the verification algorithm.

The difference between two polynomials can then be easily bounded.
If $`f(x)`$ can be approximated locally by polynomial $`q(x)`$, where we have a HOL4 theorem showing that
$`|f(x) - q(x)| \leq \delta`$ we can reduce proving the error $`\varepsilon`$ as follows:

$`|f(x) - p(x)| \leq |f(x) - q(x)| + |q(x) - p(x)|`$ where the error for $`|f(x) - q(x)|`$ is a once and forall
proven HOL4 theorem, and $`|q(x) - p(x)|`$ is proven by the certificate checker using Sturm's theorem.

Computing the error with Sturm's theorem is then done as follows:
- Infer a set of extrema for $`|q(x)-p(x)|`$ and verify that these are exactly $`\Omega`$
- Check that the values of these extrema for $`|f(x) - q(x)| + |q(x) - p(x)|`$ is smaller or equal than $`\varepsilon`$.
