function [eta] = calc_eta(q, theta_b, h)
% CALC_ETA -  Calculates fin EFFICIENCY, Eta, as defined by Eqn. 3.91 on
% page 165 of the textbook.
%
% Syntax:  [eta] = calc_eta(q, theta_b, h)
%
% Inputs:
%    q - Fin Heat Rate [W]
%    theta_b - 'excess' temperature [C]
%    h - convection coefficient  % [W/m^2 C]
%
% Outputs:
%    eta - [%] 
%
%#ok<*NASGU>
%% MAIN

% Set globals
global Af

% ====================== YOUR CODE HERE ======================
% Instructions: provide Eqn. 3.91 below. Note: you are given q, theta_b, h,
% and Af above -- hence you do not need to set them, just USE them.

eta = q/(h * Af * theta_b);

% ============================================================

end