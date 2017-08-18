function [T, q] = caseB(x,theta_b, m, M)
% CASEB() Calculates fin temperature distribution and heat rate (see table
% 3.4 in text.)
%
% Syntax:  [T,q] = CASEB(x, theta_b, m, M)
%
% Inputs:
%    x - Position vector [m]
%    theta_b - 'excess' temperature [C]
%    m - See Table 3.4
%    M - See Table 3.4

% Set Globals
global L T_inf 

% ====================== YOUR CODE HERE ======================
% Instructions: Provide two expressions: Temperature distribution, T, and
% heat rate, q, from Table 3.4.
%
% Note: you will need to solve for T, not theta/theta_b

mL = m * L;

% Temperature Distributio 
T = theta_b * ( cosh(m * (L - x)) / cosh(mL) ) + T_inf;

% Heat Rate
q = M * tanh(mL);


% ============================================================

end