function [Nu, Re, Pr, nu] = hilpert(Tf, V)
% HILPERT() - Calculates Nusselt number via HILPERT correlation
%   see p458 in Fundamentals of Heat and Mass Transfer, Incropera, Dewitt
%   7e
%
% Syntax:  [Nu, Re, Pr, nu] = hilpert(Tf, V)
%
% Inputs:
%    Tf - Film Temp [K]
%    V - Velocity [m/s]
%
%#ok<*NASGU>
%% MAIN

% Set Globals
global D;

% evaluate properties at Tf
nu = airProp2(Tf, 'ny');
Re = (V * D)/nu;
Pr = airProp2(Tf, 'Pr');

% get C & m (table 7.2)
if Re > 0.4 && Re <= 4
    C = 0.989; m = 0.330;
elseif Re > 4 && Re <= 40
    C = 0.911; m = 0.385;
elseif Re > 40 && Re <= 4000
    C = 0.683; m = 0.466;
elseif Re > 4000 && Re < 40000
    C = 0.193; m = 0.618;
elseif Re > 40000 && Re < 400000
    C = 0.927; m = 0.805;
else
    disp('Correlation is out of Range!')
end

% ====================== YOUR CODE HERE ======================
% Instructions: Insert Hilpert correlation
%
% Note: you will solve for Nu, use the properties & coefficients set above

Nu = 0; %??????


% ============================================================

end
