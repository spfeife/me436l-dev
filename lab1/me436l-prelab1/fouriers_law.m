function [q] = fouriers_law(ks, m)
% FOURIERS_LAW -  Receives the sample ks and the temperature gradients,
% m, for each section. Returns the heat rate, q (as a VECTOR, in [W]),
% for each section in the linear heat conduction apparatus.
%
% Syntax:  [q] = fouriers_law(ks, m)
%
% Inputs:
%    ks - thermal conductivity of the SAMPLE section (middle) [W/mC]
%    m  - Linear Regression Slopes (vector!)
%
% Outputs:
%    q  - Heat Rate (Vector!) [W]
%
%% MAIN

% set derivatives from regression slopes --> You will need to use these.
dTdx1 = abs(m(1));  % Top Section
dTdx2 = abs(m(2));  % Specimen
dTdx3 = abs(m(3));  % Bottom Section

% ====================== YOUR CODE HERE ======================
% Instructions: Provide an expression for q [W]
%
%   Example:        q(1) = ???   [W]
%                   q(2) = ???   [W]
%                   q(3) = ???   [W]
%
% Hint: Write an expression for each q, be sure to check your units!
% Hint: Use parenthesis to clearly separate expressions.

% Set known material parameters
d = ???;               % [mm]
k_brass =  ???;           % [W/m-C]

% calculate area
A =  %(d/2)          % [m^2] <-- NOTE UNITS

% Now, calculate q for each section
q(1) =% ??? * A * dTdx1 * (UNIT CONVERSION!)     % [W]
q(2) = %ks * ???
q(3) = %???


% ============================================================
