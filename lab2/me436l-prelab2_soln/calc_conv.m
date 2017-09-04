function [q] = calc_conv(T,h)
% CALC_CONV() - Short function for ESTIMATING the relative heat dissipated
% via CONVECTION (see acompanying document for more information).
%
% Syntax:  [w] = calc_conv(T, h)
%
% Inputs:
%    T - Estimated temp [C]
%    h - convection coefficient  [W/m^2 C]
%
% Outputs:
%    q - Estimated heat rate [W]
%
%#ok<*NASGU>
%% MAIN

% Set globals
global As Tinf

% ====================== YOUR CODE HERE ======================
% Instructions: provide the equation to calculate the heat rate for
% convection (see acompanying document)

q = h * As * (T - Tinf);

% ============================================================

end