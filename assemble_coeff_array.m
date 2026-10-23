% ASSEMBLE_COEFF_ARRAY Assembles the 2D finite volume discretization matrix coefficients.
%
% After integration of the governing equation over the control volume, the discretized equation can be expressed as:
% Fe * phi_e - Fw * phi_w + Fn * phi_n - Fs * phi_s = De * (dphi/dx)_e - Dw * (dphi/dx)_w + Dn * (dphi/dr)_n - Ds * (dphi/dr)_s + src * V + src_lin * V * phi_P
% Where the face values and derivatives are expressed in terms of cell center values in the previous and next cells: 
% phi_f = coeffs_value(1) * phi_P + coeffs_value(2) * phi_N + coeffs_value(3)
%
% Following equation is then obtained: aP * phi_P = aW * phi_W + aE * phi_E + aS * phi_S + aN * phi_N + b
%
% Inputs:
% u - variable unit, E - control-volume integrated equation unit (W for energy equation, kg/s * u for other equations)
%   Fx, Fr (:,:) double - Convective fluxes across x and r faces [E/u]
%   Dx, Dr (:,:) double - Diffusive term coefficients across x and r faces [m*E/u]
%   coeffs_value_x, coeffs_value_r (:,:,3) double - Scheme coefficients for face values ([-], [-], [u]) 
%   coeffs_derivative_x, coeffs_derivative_r (:,:,3) double - Scheme coefficients for derivatives ([1/m], [1/m], [u/m])
%   src (:,:) double - Explicit source term [E/m^3]
%   src_lin (:,:) double - Linearized source term [E/(u*m^3)]
%   volume (:,:) double - Cell volumes [m^3]
%
% Outputs:
%   coeff (:,:,6) double - Assembled coefficients [aP, aW, aE, aS, aN, b]
function coeff = assemble_coeff_array(Fx, Fr, Dx, Dr, coeffs_value_x, coeffs_value_r, coeffs_derivative_x, coeffs_derivative_r, src, src_lin, volume)
    arguments
        Fx (:,:) double
        Fr (:,:) double
        Dx (:,:) double
        Dr (:,:) double
        coeffs_value_x (:,:,3) double
        coeffs_value_r (:,:,3) double
        coeffs_derivative_x (:,:,3) double
        coeffs_derivative_r (:,:,3) double
        src (:,:) double
        src_lin (:,:) double
        volume (:,:) double
    end

    % Preallocate coefficient array: [aP, aW, aE, aS, aN, b]
    coeff = zeros([size(volume) 6]);

    % aP
    coeff(:,:,1)  = Fx(2:end,:) .* coeffs_value_x(2:end,:,1) - Fx(1:end-1,:) .* coeffs_value_x(1:end-1,:,2) ...
        - Dx(2:end,:) .* coeffs_derivative_x(2:end,:,1) + Dx(1:end-1,:) .* coeffs_derivative_x(1:end-1,:,2) ...
        + Fr(:,2:end) .* coeffs_value_r(:,2:end,1) - Fr(:,1:end-1) .* coeffs_value_r(:,1:end-1,2) ...
        - Dr(:,2:end) .* coeffs_derivative_r(:,2:end,1) + Dr(:,1:end-1) .* coeffs_derivative_r(:,1:end-1,2) ...
        - src_lin .* volume;

    % aW
    coeff(:,:,2) = Fx(1:end-1,:) .* coeffs_value_x(1:end-1,:,1) - Dx(1:end-1,:) .* coeffs_derivative_x(1:end-1,:,1);

    % aE
    coeff(:,:,3) = -Fx(2:end,:) .* coeffs_value_x(2:end,:,2) + Dx(2:end,:) .* coeffs_derivative_x(2:end,:,2);

    % aS
    coeff(:,:,4) = Fr(:,1:end-1) .* coeffs_value_r(:,1:end-1,1) - Dr(:,1:end-1) .* coeffs_derivative_r(:,1:end-1,1);

    % aN
    coeff(:,:,5) = -Fr(:,2:end) .* coeffs_value_r(:,2:end,2) + Dr(:,2:end) .* coeffs_derivative_r(:,2:end,2);

    % b
    coeff(:,:,6) = Fx(1:end-1,:) .* coeffs_value_x(1:end-1,:,3) - Fx(2:end,:) .* coeffs_value_x(2:end,:,3) ...
        - Dx(1:end-1,:) .* coeffs_derivative_x(1:end-1,:,3) + Dx(2:end,:) .* coeffs_derivative_x(2:end,:,3) ...
        + Fr(:,1:end-1) .* coeffs_value_r(:,1:end-1,3) - Fr(:,2:end) .* coeffs_value_r(:,2:end,3) ...
        - Dr(:,1:end-1) .* coeffs_derivative_r(:,1:end-1,3) + Dr(:,2:end) .* coeffs_derivative_r(:,2:end,3) ...
        + src .* volume;
end