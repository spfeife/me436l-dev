function [eta] = calc_eta(q, theta_b, h)
% CALC_ETA() Returns performace metric: Eta

% Set globals
global Af

% ====================== YOUR CODE HERE ======================
% Instructions: provide Eqn. 3.91 below. Note: you are given q, theta_b, h,
% and Af above -- hence you do not need to set them, just USE them.

eta = q/(h * Af * theta_b);

% ============================================================

end