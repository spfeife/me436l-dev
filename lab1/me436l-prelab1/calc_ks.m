function [ks] = calc_ks(m)
% CALC_KS - Returns the unknown thermal conductivity, given the slopes
% from linear regression
%
% Syntax:  [ks] = calc_ks(m)
%
% Inputs:
%    m  - Linear Regression Slopes (vector!)
%
% Outputs:
%    ks  - Computed thermal conductivity of the SAMPLE section (middle)
%
%#ok<*NASGU>
 
%% MAIN

% set derivatives from regression slopes. NOTE: You will need to use these below!
dTdx1 = abs(m(1));  % Top Section
dTdx2 = abs(m(2));  % Specimen
dTdx3 = abs(m(3));  % Bottom Section

% ====================== YOUR CODE HERE ======================
% Instructions: Provide an expression for ks (see slides for assistance)
%
%              Example:     ks = ???
%
% Hint: You will need to supply a value for k_brass.

k_brass = %???;  % [W/mC]


% calculate sample k
ks = %???


% ============================================================

end
