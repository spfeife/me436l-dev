function [q] = calc_rad(T)
% CALC_RAD() Returns q_rad

% Set globals
global sigma ep As Tinf

% ====================== YOUR CODE HERE ======================
% Instructions: provide the equation to calculate the heat rate for
% radiation (see acompanying document)

q = sigma * ep * As * (T^4 - Tinf^4);

% ============================================================

end