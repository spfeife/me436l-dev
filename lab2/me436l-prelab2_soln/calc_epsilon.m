function [ep] = calc_epsilon(q, theta_b, h)
% CALC_ETA() Returns performace metric: Epsilon

% Set globals
global Ac

% ====================== YOUR CODE HERE ======================
% Instructions: provide Eqn. 3.86 below. Note: you are given q, theta_b, h,
% and Ac above -- hence you do not need to set them, just USE them.

ep = q/(h * Ac * theta_b);

% ============================================================

end