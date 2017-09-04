function [q] = calc_rad(T)
% CALC_RAD() - Short function for ESTIMATING the relative heat dissipated
% via RADIATION (see acompanying document for more information)
%
% Syntax:  [w] = calc_rad(T)
%
% Inputs:
%    T - Estimated temp [K]
%
% Outputs:
%    q - Estimated heat rate [W]
%
%#ok<*NASGU>
%% MAIN


% Set globals
global sigma ep As Tinf

% ====================== YOUR CODE HERE ======================
% Instructions: provide the equation to calculate the heat rate for
% radiation (see acompanying document)

q = sigma * ep * As * (T^4 - Tinf^4);

% ============================================================

end