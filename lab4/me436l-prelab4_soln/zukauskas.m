function [Nu, Re, Pr, nu] = zukauskas(T_inf, Ts, V)
% ZUKAUSKAS() - Calculates Nusselt number via the ZUKAUSKAS correlation
%   see p458 in Fundamentals of Heat and Mass Transfer, Incropera, Dewitt
%   7e
%
% Syntax:  [Nu, Re, Pr, nu] = zukauskas(T_inf, Ts, V)
%
% Inputs:
%    T_inf  - ambient air temp [K]
%    T_s    - surface temp [K]
%    V      - Velocity [m/s]
%
%#ok<*NASGU>
%% MAIN

% Set Globals
global D;

% evaluate properties at T_inf, except Pr_s
nu  = airProp2(T_inf, 'ny');
Re  = (V * D)/nu;
Pr  = airProp2(T_inf, 'Pr');
Prs = airProp2(Ts, 'Pr');

% sanity checks
if Pr < 0.7 || Pr > 500
    warning('Pr out of range, may not be accurate')
end

if Re < 1 || Re > 10^6
    warning('Re out of range, may not be accurate')
end

% set C & m table 7.4
if Re <= 40
    C = 0.75; m = 0.4;
elseif Re > 40 && Re <= 1000
    C = 0.51; m = 0.5;
elseif Re > 1000 && Re <= 2*10^5
    C = 0.26; m = 0.6;
elseif Re > 2*10^5 && Re < 10^6
    C = 0.076; m = 0.7;
else
    disp('Correlation is out of Range!')
end

% set n
if Pr <= 10, n = 0.37; end
if Pr > 10, n = 0.36; end

% ====================== YOUR CODE HERE ======================
% Instructions: Insert Zukauskas correlation
%
% Note: you will solve for Nu, use the properties & coefficients set above

Nu = C* Re^m * Pr^n * (Pr/Prs)^(1/4);

% ============================================================

end
