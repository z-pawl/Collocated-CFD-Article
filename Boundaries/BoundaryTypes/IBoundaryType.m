% IBOUNDARYTYPE Abstract base class for boundary condition types.
classdef (Abstract) IBoundaryType < handle & matlab.mixin.Heterogeneous & matlab.mixin.Copyable
    properties
        name (1,1) string               % Boundary patch identifier ('West', 'East', 'South', 'North')
    end
    methods (Abstract)
        % APPLY_BOUNDARY_CONDITION_VALUE Applies boundary condition to face value coefficients.
        [coeffs_x, coeffs_r] = apply_boundary_condition_value(obj, coeffs_x, coeffs_r)

        % APPLY_BOUNDARY_CONDITION_NORMAL_DERIVATIVE Applies boundary condition to normal derivative coefficients.
        [coeffs_x, coeffs_r] = apply_boundary_condition_normal_derivative(obj, coeffs_x, coeffs_r)
        
        % CONVERT_INTO_CORRECTION_BOUNDARY Converts boundary condition for correction field (a*y# + b*y#' = 0) - used for pressure correction equation.
        converted_bd = convert_into_correction_boundary(obj)
    end
end