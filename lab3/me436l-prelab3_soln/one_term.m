function [T, Fo, theta_star] = one_term(t, Lc, z1, C1 )
% ONE_TERM: Returns the theoretical temperature distribution [C] as computed 
% via the One-Term Approximation method, See Sec. 5.2.2 in textbook (p. 300)
%
% Syntax:  T = one_term(t, Lc, Ti, Tinf)
%
% Inputs:
%    t    - time vector [s]
%    LC   - characteristic length scale for LCM / Geometry
%    z1   - Eigenvalue (zeta) coefficient, Eq. 5.44
%    C1   - Amplitude (C) coefficient, Eq. 5.44
%
% Outputs:
%    T - Temperature distribution [C]
%
%#ok<*NASGU>

%% MAIN

% Set Globals
global alfa
global Ti Tinf

% ====================== YOUR CODE HERE ======================
% Instructions: First, calculate the Biot number (Bi) & Fourier No. (Fo),
% then use them to compute T, via One-term approximation (5.44)
%
% Note: you will need to solve for T, not theta/theta_b

% Set Fo
Fo = (alfa * t)/Lc^2;

% calculate theta_star (5.34)
theta_star = C1 .* exp( - z1.^2 .* Fo);

% convert to temperature
T =  Tinf + (Ti - Tinf) * theta_star;      % [C] one-term approx

% ============================================================
end