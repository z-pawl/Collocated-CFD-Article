# ApproximationSchemes

Finite volume face interpolation and gradient evaluation schemes.

## Contents
- `FacePartialDerivative/`: Differencing schemes for normal face derivatives.
- `FaceValues/`: Face interpolation schemes (linear, upwind, TVD).
  - `FluxLimiters/`: Flux limiters for the TVD method (e.g., Van Leer).
- `deferred_correction_face.m`: Deferred correction implementation blending low- and high-order schemes.
- `evaluate_faces.m`: Vectorized evaluation of face values.
- `rhie_chow_interpolation.m`: Rhie-Chow momentum interpolation for collocated grids.
