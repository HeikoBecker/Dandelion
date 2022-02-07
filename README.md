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

## Tests

The directory `testcases/timing_deg5_prec53` contains the testcases used for the
evaluation in the paper.
Running the script `scripts/timing.sh` will reproduce the results from table 1.

The remaining files in `testcases` are the certificates for the additional tests
we performed in section 6.2 and 6.3, and the directory `testcases/sollya_inputs`
contains the Sollya input files we used to generate the example certificates.
File `testscases/INEQTACtestsScript.sml` has all the tests we perform for `REAL_INEQ_TAC`.
