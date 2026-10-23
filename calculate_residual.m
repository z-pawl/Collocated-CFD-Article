% CALCULATE_RESIDUAL Computes normalized L1 residual norm.
%
% Inputs:
%   coeff (:,:,6) double - Discretization coefficients [aP, aW, aE, aS, aN, b]
%   field (:,:) double - Scalar variable field [variable dependent unit]
%
% Outputs:
%   residual (1,1) double - Normalized L1 residual norm [-]
function residual = calculate_residual(coeff, field)
    % Compute local residual field
    local_residual = calculate_local_residual(coeff, field);
    
    % Scaling factor: sum of absolute diagonal contributions
    scaling_factor = norm(coeff(:,:,1) .* field, 1);
    
    % Normalized residual
    residual = norm(local_residual, 1) / scaling_factor;
end