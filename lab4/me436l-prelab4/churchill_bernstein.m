function [Nu, Re, Pr, nu] = churchill_bernstein(Tf, V)
% Calculates Nusselt number via the Churchill & Bernstein correlation
%   see p458 in Fundamentals of Heat and Mass Transfer, Incropera, Dewitt
%   7th edition
%
% Syntax:  [Nu, Re, Pr, nu] = hilpert(Tf, V)
%
% Inputs:
%    Tf - Film Temp [K]
%    V - Velocity [m/s]

global D;

% ====================== YOUR CODE HERE ======================
% Instructions: Insert CB correlation
%
% Note: you will solve for Nu, use the properties & coefficients set above
% Hint: it may be easier to break this correlation up into several parts

% evaluate properties at Tf
nu = airProp2(Tf,'ny');
Pr = airProp2(Tf,'Pr');

% calculate Reynolds number
Re = 0.0; %????

% evaluate correlation
Nu_a = 0.62 * Re^(1/2) * Pr^(1/3);
Nu_b =
Nu_c = 

Nu = 0.3 + (Nu_a ... 


% ============================================================

end
