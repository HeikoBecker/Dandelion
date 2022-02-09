# Dandelion

A certificate checker for approximations of elementary functions.

## Installation

Dandelion is known to compile with [HOL4](https://github.com/HOL-Theorem-Prover/HOL),
commit `9d2d0e89bd165c1ea71279ed6f2ed14ed6c15d27`.
To install HOL4, please follow the official installation instructions.

To use Dandelion, make sure to have a local copy of the Git repository.
You also need a version of [FloVer](https://gitlab.mpi-sws.org/AVA/FloVer)
and [CakeML](https://github.com/CakeML/cakeml) installed on your machine.
We recommend using the latest state of FloVer from a clean checkout, and the
commit `d8dc70502a73effe17411f0d7eeaa80c1d9fab98` from CakeML.

Before compiling Dandelion with `Holmake`, the shell variables
`FLOVERDIR` and `CMLDIR` need to be set up such that they point to the directories
where FloVer and CakeML are installed respectively, i.e. if FloVer is cloned into
`/home/<username>/git/FloVer`, `FLOVERDIR` should be set to that path with
`export FLOVERDIR=/home/<username>/git/FloVer`.

## Key theorems and definitions

The first phase is defined across the files `transcApproxSemScript.sml` and
`approxPolyScript.sml`. The first file defines the overall approximation function
`approxAsPoly` and gives its soundness proof, and `approxPolyScript.sml` defines
the low-level approximation function for approximating a single elementary function
with a single polynomial and proves soundness of this function.

Theorem 4 (First Phase Soundness) from section 3 is proven in file `transcApproxSemScript.sml` as `approxTransc_sound`.
Variants of Theorem 5 are proven for the supported elementary function in file `mcLaurinApproxScript.sml`
if they are not provided by HOL4.
Variants of Theorem 6 are proven for the supported elementary functions in file `approxPolyScript.sml`.

The second phase is implemented and proven sound in the file `checkerScript.sml`.
It relies on the implementation of computable Sturm sequences in `sturmComputeScript.sml`
and computable polynomial division in `euclidDivScript.sml`.

Theorem 7 (Second Phase Soundness) from section 4 is proven in file `checkerScript.sml` as the combination of
`numZeros_sound`, `validBounds_is_valid`, and `validateZerosLeqErr_sound`.

Theorem 8 was ported from Harrison's HOL-Light proofs in file `drangScript.sml`
and is called `BOUND_THEOREM_INEXACT`.

Theorem 9 (Dandelion soundness) is called `checker_soundness` in file `checkerScript.sml`.

The extracted binary is created in the directory `binary`.
File `translateScript.sml` sets up the CakeML translation of the definitions of
Dandelion, file `certParserScript.sml` defines our (unverified) parser and lexer,
file `sturmMainCakeScript.sml` proves the CakeML specification for the
binary, and file `sturmMainCakeCompileScript.sml` compiles the binary for the second
phase by running the CakeML compiler in-logic on the translated definitions.

## Tests

The directory `testcases/timing_deg5_prec53` contains the testcases used for the
evaluation in the paper.
Running the script `scripts/timing.sh` will reproduce the results from table 1.

The remaining files in `testcases` are the certificates for the additional tests
we performed in section 6.2 and 6.3, and the directory `testcases/sollya_inputs`
contains the Sollya input files we used to generate the example certificates.
File `testscases/INEQTACtestsScript.sml` has all the tests we perform for `REAL_INEQ_TAC`.
