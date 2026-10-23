% ICOMPONENT Abstract interface for physical model components (Flow, Energy, Species).
classdef (Abstract) IComponent < handle & matlab.mixin.Heterogeneous
    methods (Abstract)
        % ITERATE Performs one outer iteration of the component solver.
        converged = iterate(obj)
    end
end