function [T] = lcm(t, Lc, Bi_lcm)
% LCM: Returns the theoretical temperature distribution as computed via the
% Lumped Capacitance Method (LCM), See Sec. 5.1 in textbook (p. 280)
%
% Syntax:  [T] = lcm(t, Lc, Ti, Tinf)
%
% Inputs:
%    t    - time vector [s]
%    LC   - characteristic length scale for LCM / Geometry

% Set Globals
global alfa
global Ti Tinf

% ====================== YOUR CODE HERE ======================
% Instructions: First, calculate the Biot number (Bi) & Fourier No. (Fo),
% then use them to compute T, via LCM (Eq. 5.13)

% Set Fo
Fo = (alfa * t)/Lc^2;

% Calculate T via LCM (Eq. 5.13)
T = Tinf + (Ti - Tinf) * exp(-Bi_lcm .* Fo);

% ============================================================


end
