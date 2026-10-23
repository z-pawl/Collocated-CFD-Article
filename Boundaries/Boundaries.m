% BOUNDARIES Container managing domain boundary conditions.
classdef Boundaries < handle
    properties
        boundaries (:,1) IBoundaryType  % Array of boundary condition instances
    end
    methods
        % ADD_BOUNDARY Appends a boundary condition.
        function add_boundary(obj, boundary)
            arguments
                obj (1,1) Boundaries
                boundary (1,1) IBoundaryType
            end
            obj.boundaries(size(obj.boundaries,1) + 1) = boundary;
        end
        
        % APPLY_BOUNDARY_CONDITION_VALUE Applies boundary condition to face value coefficients.
        function [coeffs_x, coeffs_r] = apply_boundary_condition_value(obj, coeffs_x, coeffs_r)
            arguments
                obj Boundaries
                % Coefficient representing the boundary value in the form
                % [aP, aN, b] where P means the previous cell and N the
                % next one, The value at boundary is constructed as follows:
                % val_face = aP*phiP + aN*phiN + b
                coeffs_x (:,:,3) double
                coeffs_r (:,:,3) double
            end

            % Applying the boundary conditions
            for i = 1:size(obj.boundaries,1)
                [coeffs_x, coeffs_r] = obj.boundaries(i).apply_boundary_condition_value(coeffs_x, coeffs_r);
            end
        end

        % Function applying the boundary conditions to field normal derivatives at boundaries
        function [coeffs_x, coeffs_r] = apply_boundary_condition_normal_derivative(obj, coeffs_x, coeffs_r)
            arguments
                obj Boundaries
                % Coefficient representing the boundary derivative in the form
                % [aP, aN, b] where P means the previous cell and N the
                % next one The value at boundary is constructed as follows:
                % derivative_face = aP*phiP + aN*phiN + b
                coeffs_x (:,:,3) double
                coeffs_r (:,:,3) double
            end

            % Applying the boundary conditions
            for i = 1:size(obj.boundaries,1)
                [coeffs_x, coeffs_r] = obj.boundaries(i).apply_boundary_condition_normal_derivative(coeffs_x, coeffs_r);
            end
        end
    end
end