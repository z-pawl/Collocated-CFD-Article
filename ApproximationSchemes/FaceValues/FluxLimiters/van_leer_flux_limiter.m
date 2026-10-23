% VAN_LEER_FLUX_LIMITER Computes Van Leer flux limiter values.
%
% Inputs:
%   derivative_face (:,:) double - Face derivative [field_unit/m]
%   derivative_upwind_face (:,:) double - Upwind face derivative [field_unit/m]
%
% Outputs:
%   flux_limiter (:,:) double - Limiter values psi(r) [-]
function flux_limiter = van_leer_flux_limiter(derivative_face, derivative_upwind_face)
    arguments
        derivative_face (:,:) double
        derivative_upwind_face (:,:) double 
    end

    % Consecutive gradient ratio r
    r = derivative_upwind_face ./ derivative_face;
    r(r < 0 | isnan(r)) = 0;

    flux_limiter = (2 * r) ./ (1 + r);
    flux_limiter(derivative_face == 0) = 0;
end