% TDMA Tridiagonal Matrix Algorithm (Thomas algorithm) for solving A*x = d.
%
% Inputs:
%   a (:,1) double - Subdiagonal entries (a(1) unused)
%   b (:,1) double - Main diagonal entries
%   c (:,1) double - Superdiagonal entries (c(end) unused)
%   d (:,1) double - Right-hand side vector
%
% Outputs:
%   d (:,1) double - Solution vector
function d = tdma(a,b,c,d)
    %#codegen
    % Dimension of the matrix A
    n = length(b);

    % Forward sweep
    for i = 2:n
        w = a(i) / b(i-1);
        b(i) = b(i) - w*c(i-1);
        d(i) = d(i) - w*d(i-1);
    end


    % Backward substitution
    d(n) = d(n) / b(n);
    for i = (n-1):(-1):1
        d(i) = (d(i)-c(i)*d(i+1))/b(i);
    end
end