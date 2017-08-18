function delta = calc_uncertainty(Tm, pct_conv)
% CALC_UNCERTAINTY:  Performs the uncertainty analysis (see slides)

% set globals
global T_inf V I As

% epsilon values
eI = 0.01;
eV = 0.1;
eT = 0.1;

% convert back to [C]
Tinf = T_inf - 273.15;    % [C]
T_1 = Tm(1);              % [C]
T_2 = Tm(2);              % [C]

% ====================== YOUR CODE HERE ======================
% Instructions: insert a relationship for 'delta'

dhdI = (2 * pct_conv * V)/(As * ( T_1 + T_2 - 2*Tinf) );
dhdV = (2 * pct_conv * I)/(As * ( T_1 + T_2 - 2*Tinf) );
dhdT1 = (-2 * pct_conv * V*I)/(As * ( T_1 + T_2 - 2*Tinf)^2 );
dhdT2 = (-2 * pct_conv * V*I)/(As * ( T_1 + T_2 - 2*Tinf)^2 );
dhdTinf = (4 * pct_conv * V*I)/(As * ( T_1 + T_2 - 2*Tinf)^2 );

delta = sqrt( (dhdI * eI)^2 + (dhdV *eV)^2 + (dhdT1*eT)^2 + (dhdT2 *eT)^2 + (dhdTinf * eT)^2);


end
