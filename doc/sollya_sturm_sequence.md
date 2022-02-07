 Given a univariate polynomial $`P(x)`$ with real coefficients, the sturm
 sequence is computed as follows:


- $`P_{o} = P`$
- $`P_{1} = P' `$ , where $`P' `$ is the derivative of the polymonial $`P`$
- $`P_{i+1} = - rem( P_{i-1}, P_{i}) , \forall i \geq 1`$

Here `rem` computes the remainder of the long division or the Eucledian division
of the polynomial $`P_{i-1}`$ by $`P_{i} `$.
The length of the sturm sequence is at most the degree of the polynomial $`P`$.

Sollya models polynomials as an array of coefficients.
It follows the above mentioned algorithm to compute the sturm sequence, i.e. it
starts with the polynomial as the zeroth sequence, $`P_{o}`$, computes its
derivative and denote it as $`P_{1}`$ and then compute the rest of the sequence
by Eucledian division of $`P_{i-1}`$ and $`P_{i}`$. Once, it has the sturm
sequence, it computes the variation of sign in the sturm sequence at points
$`a`$ and $`b`$ of the interval $`[a,b]`$ separately using the formula:

$`var(x) = \sum_{i=1}^n (\text{ if   } (P_{i-1}(a) * P_{i}(a) < 0) \text{ then   } 1 \text{ else   } 0)`$

The number of distinct real roots in the interval is then $`|var(a) - var(b)|`$.

A detailed implementation of the Sturm sequence in Sollya can be found in the
`sturm.c` file at https://www.sollya.org/download.php?release=current from line
322-474.
The module which implements the sturm sequence is `strum_mpq` in the `sturm.c` file.
