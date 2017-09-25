function [T] = lcm(t, Lc, Bi_lcm)
% LCM: Returns the theoretical temperature distribution [C] as computed via
% the Lumped Capacitance Method (LCM), See Sec. 5.1 in textbook (p. 280)
%
% Syntax:  [T] = lcm(t, Lc, Ti, Tinf)
%
% Inputs:
%    t    - time vector [s]
%    LC   - characteristic length scale for LCM / Geometry
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
% then use them to compute T, via LCM (Eq. 5.13)
%
% Note: you will need to solve for T, not theta/theta_b

% Set Fo
Fo =

% Calculate T via LCM (Eq. 5.13)
T =

% ============================================================


end
