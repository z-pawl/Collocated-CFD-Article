% IMPLICIT_RELAXATION Applies Patankar implicit under-relaxation to discretization matrix diagonal.
%
% Inputs:
%   coeff (:,:,6) double - Discretization coefficients [aP, aW, aE, aS, aN, b]
%   field (:,:) double - Previous iteration scalar field [variable dependent unit]
%   relaxation_factor (1,1) double - Implicit under-relaxation factor alpha in (0, 1] [-]
%
% Outputs:
%   coeff (:,:,6) double - Relaxed discretization coefficients
function coeff = implicit_relaxation(coeff, field, relaxation_factor)
    coeff(:,:,6) = coeff(:,:,6) + (1 - relaxation_factor) / relaxation_factor * coeff(:,:,1) .* field;
    coeff(:,:,1) = coeff(:,:,1) / relaxation_factor;
end