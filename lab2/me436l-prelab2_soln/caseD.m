function [T, q] = caseD(x, theta_b, m, M)
% CASED - Calculates fin temperature distribution and heat rate for CASE D
% in Table 3.4 of the text. NOTE: Use caseA.m as an example.
%
% Syntax:  [T,q] = caseD(x, theta_b, m, M)
%
% Inputs:
%    x - Position vector [m]
%    theta_b - 'excess' temperature [C]
%    m - See Table 3.4
%    M - See Table 3.4
%
% Outputs:
%    T - Temperature distribution [C]
%    q - Heat Rate [W]
%
%#ok<*NASGU>
 
%% MAIN

% Set Globals
global T_inf 

% ====================== YOUR CODE HERE ======================
% Instructions: Provide two expressions: Temperature distribution, T, and
% heat rate, q, from Table 3.4.
%
% Note: you will need to solve for T, not theta/theta_b!!

% Temperature Distribution:
T = theta_b * exp(-m*x) + T_inf;

% Heat Rate:
q = M;


% ============================================================

end