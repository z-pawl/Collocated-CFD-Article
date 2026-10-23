% ENTROPY_GENERATION_FLOW_VISCOSITY Calculates volumetric entropy generation from viscous dissipation in porous media.
%
% Inputs:
%   grid (1,1) Grid2D - Computational grid
%   energy_component (1,1) EnergyComponent - Used for temperature field [K]
%   flow_component (1,1) FlowComponent - Used for velocity and viscosity fields
%   permeability (1,1) double - Permeability [m^2]
%
% Outputs:
%   entropy_generation (:,:) double - Local viscous entropy generation rate [W/(m^3*K)]
function entropy_generation = entropy_generation_flow_viscosity(grid, energy_component, flow_component, permeability)
    arguments
        grid (1,1) Grid2D
        energy_component (1,1) EnergyComponent
        flow_component (1,1) FlowComponent
        permeability (1,1) double
    end
    % Entropy generation due to flow viscosity in a porous media is
    % described by the following equation:
    % s_gen = visc * v^2 / (Kp * T); [W/(m^3*K)]
    % Where: T - temperature [K], v - velocity [m/s]
    % visc - dynamic viscosity [Pa*s], Kp - permeability [m^2]

    % [W/(m^3*K)]
    entropy_generation = flow_component.visc .* (flow_component.vx .^ 2 + flow_component.vr .^ 2) ./ (permeability * energy_component.temp);
end