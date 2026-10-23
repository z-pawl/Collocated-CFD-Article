% GRID2D 2D axisymmetric cylindrical / Cartesian finite volume mesh.
classdef Grid2D < handle
    properties
        sz (1,2) double                 % Number of cells [Nx, Nr] [-]
        dx (:,1) double                 % Cell sizes along axial direction [m]
        dr (1,:) double                 % Cell sizes along radial direction [m]
        cent_pos_x (:,1) double         % Cell center axial coordinates [m]
        cent_pos_r (1,:) double         % Cell center radial coordinates [m]
        face_pos_x (:,1) double         % Face center axial coordinates [m]
        face_pos_r (1,:) double         % Face center radial coordinates [m]
        face_area_x (:,:) double        % Axial face areas [m^2]
        face_area_r (:,:) double        % Radial face areas [m^2]
        volume (:,:) double             % Control volume cell volumes [m^3]
        domain_boundary Boundaries {mustBeScalarOrEmpty} % Boundary definitions
    end
    methods
        % GRID2D Constructs 2D axisymmetric grid.
        %
        % Inputs:
        %   dx (:,1) double - Cell sizes along x [m]
        %   dr (1,:) double - Cell sizes along r [m]
        %   offset_r (1,1) double - Radial inner boundary offset [m]
        function obj = Grid2D(dx, dr, offset_r)
            arguments
                dx (:,1) double
                dr (1,:) double
                offset_r (1,1) double
            end
            obj.sz = [size(dx,1) size(dr,2)];

            obj.dx = dx;
            obj.dr = dr;

            obj.face_pos_x = cumsum([0; dx], 1);
            obj.face_pos_r = cumsum([offset_r dr], 2);

            obj.cent_pos_x = (obj.face_pos_x(1:end-1,:) + obj.face_pos_x(2:end,:)) / 2;
            obj.cent_pos_r = (obj.face_pos_r(:,1:end-1) + obj.face_pos_r(:,2:end)) / 2;

            obj.face_area_x = repmat(2 * pi .* dr .* obj.cent_pos_r, obj.sz(1) + 1, 1);
            obj.face_area_r = 2 * pi .* dx .* obj.face_pos_r;

            obj.volume = 2 * pi .* dx .* dr .* obj.cent_pos_r;

            obj.domain_boundary = Boundaries;
        end
    end
end