function [T, q] = caseA(x,theta_b, m, M, h)
% CASEA - Calculates fin temperature distribution and heat rate for CASE A
% in Table 3.4 of the text.
%
% Syntax:  [T,q] = caseA(x, theta_b, m, M)
%
% Inputs:
%    x - Position vector [m]
%    theta_b - 'excess' temperature [C]
%    m - See Table 3.4
%    M - See Table 3.4
%    h - Convection Coefficient
% Outputs:
%    T - Temperature distribution [C]
%    q - Heat Rate [W]
%
%#ok<*NASGU>
 
%% MAIN


% Set Globals
global L T_inf k


% ====================== YOUR CODE HERE ======================
% Instructions: Provide two expressions: Temperature distribution, T, and
% heat rate, q, from Table 3.4.
%
% Note: you will need to solve for T, not theta/theta_b

h_mk = h/(m*k);
mL = m * L;

% Temperature Distributio 
T = theta_b * ( (cosh(m * (L - x)) + h_mk * sinh(m * (L - x) )) ...
    / (cosh(mL) + h_mk * sinh(m*L)) ) + T_inf;

% Heat Rate
q = M * (sinh(mL) + (h_mk) * cosh(mL))/(cosh(mL) + h_mk * sinh(mL));


% ============================================================

end
