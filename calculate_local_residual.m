% CALCULATE_LOCAL_RESIDUAL Calculates local residual for each control volume.
%
% Inputs:
%   coeff (:,:,6) double - Discretization coefficients [aP, aW, aE, aS, aN, b]
%   field (:,:) double - Scalar variable field [variable dependent unit]
%
% Outputs:
%   local_residual (:,:) double - Local residuals across cells [variable dependent unit]
function local_residual = calculate_local_residual(coeff, field)
    sz = size(field);

    % Zero padding vectors for vectorized neighbor operations
    col0 = zeros(sz(1),1);
    row0 = zeros(1,sz(2));

    % r = aW * phiW + aE * phiE + aS * phiS + aN * phiN + b - aP * phiP
    local_residual = [row0; coeff(2:end,:,2) .* field(1:end-1,:)] + [coeff(1:end-1,:,3) .* field(2:end,:); row0] ... 
        + [col0 coeff(:,2:end,4) .* field(:,1:end-1)] + [coeff(:,1:end-1,5) .* field(:,2:end) col0] ...
        + coeff(:,:,6) - coeff(:,:,1) .* field;
end