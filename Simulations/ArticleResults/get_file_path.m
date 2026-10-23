% GET_FILE_PATH Formats file path for given operating conditions and folder path
%
% Inputs:
%   porosity (1,1) double - Catalyst bed porosity [-]
%   temp_wall (1,1) double - Wall temperature [K]
%   v_inlet (1,1) double - Inlet velocity [m/s]
%   SC (1,1) double - Steam-to-carbon ratio [-]
%   path (1,1) string - Folder path
%
% Output:
%   name (1,1) - (1,1) string - Full path to the MAT-file named according to the 
%       specified operating conditions.
function name = get_file_path(porosity, temp_wall, v_inlet, SC, path)
    % Porosity - last 3 digits of the integer part of 100 times porosity
    s_porosity = sprintf("%03d", floor(porosity * 100));
    
    % Wall temperature - last 4 digits of the integer part
    s_temp_wall = sprintf("%04d", floor(temp_wall));
    
    % Inlet velocity - last 3 digits of the integer part of 100 times velocity
    s_v_inlet = sprintf("%03d", floor(v_inlet * 100));
    
    % Steam-to-carbon ratio - last 3 digits of the integer part of 10 times velocity
    s_SC = sprintf("%03d", floor(SC * 10));
    
    name = sprintf("%s-%s-%s-%s.mat", [s_porosity, s_temp_wall, s_v_inlet, s_SC]);
    name = path + name;
end