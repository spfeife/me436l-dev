function [ep] = calc_epsilon(q, theta_b, h)
% CALC_EPSILON - Calculates fin EFFECTIVENESS, Epsilon, as defined by Eqn.
% 3.86 on page 164 of the textbook.
%
% Syntax:  [ep] = calc_eta(q, theta_b, h)
%
% Inputs:
%    q - Fin Heat Rate [W]
%    theta_b - 'excess' temperature [C]
%    h - convection coefficient  % [W/m^2 C]
%
% Outputs:
%    ep - [-] 
%
%#ok<*NASGU>
%% MAIN

% Set globals
global Ac

% ====================== YOUR CODE HERE ======================
% Instructions: provide Eqn. 3.86 below. Note: you are given q, theta_b, h,
% and Ac above -- hence you do not need to set them, just USE them.

ep = q/(h * Ac * theta_b);

% ============================================================

end