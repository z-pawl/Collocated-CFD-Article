# Components

Physical model equations and sub-models governing fluid flow, energy, and chemical species transport.

## Contents
- `IComponent.m`: Abstract base interface for physical equation solvers.
- `FlowComponent.m`: 2D axisymmetric Brinkman-Forchheimer momentum and continuity solver (SIMPLE algorithm).
- `EnergyComponent.m`: 2D axisymmetric energy conservation solver with conduction, convection, and reaction heat sources.
- `SpeciesComponent.m`: Single chemical species conservation solver.
- `SpeciesManagerComponent.m`: Multicomponent species manager handling mixture thermodynamics and steam reforming/water-gas-shift reaction kinetics.
