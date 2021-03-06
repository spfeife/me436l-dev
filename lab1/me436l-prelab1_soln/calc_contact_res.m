function [R1, R2] = calc_contact_res(dT, P)
% CALC_CONTACT_RES - Returns the contact resistance for each section.
% Requires the temperature drop, dT, and the input power, P.
%
% Syntax:  [R1, R2] = calc_contact_res(dT, P)
%
% Inputs:
%    dT - Temperature Drop  [C]
%    P  - Input Power       [W]
%
% Outputs:
%    R1  - Contact resistance - first section   [m^2 C/W]
%    R1  - Contact resistance - second section  [m^2 C/W]
%
%% MAIN

% extract temperature drop, dT
dT1 = dT(1);
dT2 = dT(2);

% ====================== YOUR CODE HERE ======================
% Instructions: Provide expressions for R1 & R2
%
% Hint: Be sure to check units!

% Set known material parameters
d = 25;                  % [mm]
A = pi*((d/2)/1000)^2;   % [mm^2]

R1 = dT1 * ( A/P);  % [m^2 C/W]
R2 = dT2 * ( A/P);  % [m^2 C/W]

% ============================================================

end
