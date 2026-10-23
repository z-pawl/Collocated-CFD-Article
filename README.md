# Collocated-CFD

A 2D axisymmetric collocated finite volume CFD solver for reacting flow, heat transfer, and multicomponent species transport in porous media (such as steam methane reforming).

## Directory Structure
- `ApproximationSchemes/`: Face interpolation schemes (linear, upwind, TVD) and Rhie-Chow momentum interpolation.
- `Boundaries/`: Boundary condition framework and specific types (fixed value, fixed derivative, convective).
- `Components/`: Physical model governing equations (flow/momentum, energy, species transport, and species manager).
- `Postprocessing/`: Postprocessing utilities, including local and domain entropy generation balance calculations.
- `Solvers/`: Linear equation solvers (TDMA, implicit relaxation).
- `Simulations/`: Simulation cases.

## Quick Start
In the MATLAB console while in the `Collocated-CFD-Article` folder:
add_path   % Adds solver directories to MATLAB search path