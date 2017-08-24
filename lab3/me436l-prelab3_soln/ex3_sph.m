%% ME 436L Heat Transfer
% Lab 3 | Transient Conducton
%
%  INSTRUCTIONS
%  ------------
%
%  This script performs the following operations:
%
%       - Plots data from 3 stations and compares with models A, B, D
%       - Compares heat transfer rates to input power
%       - Compares fin effectiveness & efficiency
%
%   This is done by looping over all excel files in your 'data' folder and
%   plotting the data therein.  Be sure to have your paths setup correctly.
%
%  NOTE: You will need to complete the following functions:
%
%
%#ok<*SNASGU>
%#ok<*NUSED>
%#ok<*SAGROW>
%#ok<*UNRCH>

%% Initialization

clear ; close all;
addpath('./lib');
addpath('./data');

global alfa h k
global Ti Tinf

disp(' ')
disp(' --------------------------------------------------------')
fprintf('<strong>                Lab 3: Transient Conduction               </strong>\n')
disp(' --------------------------------------------------------')
disp(' ')

%% =================    SETUP    ==================

%fname = 'brass_sphere'; matl_type = 'Brass';
fname = 'steel_sphere'; matl_type = 'SS';


%% =================    PROPERTIES    ==================
% From the procedures document and the textbook, fill in all of the
% necessary info

% diffusivity
alfa_b = 0.000037;
alfa_ss = 0.000006;

% thermal conductivity
kb = 121;
ks = 25;

% characteristic length scales
Lc_one_term = 0.0225;
Lc_lcm = 0.0075;

%hb = 2500;
%hs = 1300;

hb = 1800;
hs = 1800;

%% ==================================================

% based on input, set properties
s1 = lower(matl_type);
if strcmp(s1,'brass')
    alfa = alfa_b;
    k = kb;
    h = hb;
    titl = 'Thermal Response, Brass Sphere';
elseif strcmp(s1,'ss')
    alfa = alfa_ss;
    k = ks;
    h = hs;
    titl = 'Thermal Response, SS Sphere';
end

%% Calculations

% load data
raw = xlsread(fname);

% truncate t & T to start at 0
[T, t] = set_tzero(raw);

% extract Tinf & Ti
Tinf = mean(T(end-20:end));
Ti = T(1);

% compute Biot number (LCM)
Bi_lcm = (h * Lc_lcm)/k;

% compute LCM T
T_lcm  = lcm(t, Lc_lcm, Bi_lcm);

% estimate Bi (one-term approx)
Bi = (h * Lc_one_term)/k;

% find coefficients C1 & z1 from table 5.1
[z1, C1] = set_coeffients(Bi, 'sphere');

% compute one-term approximation
[T1, Fo1, theta_star] = one_term(t, Lc_one_term, z1, C1);

%% PLOTTING / Error
plot_fo(Fo1, theta_star);

plot_data(t,T, T_lcm, T1, titl);

% print fig
%print(['figs/' fname], '-dpng','-r200');

err1 = norm(T-T1)/norm(T);
err2 = norm(T-T_lcm)/norm(T);

disp('Error:  ')
disp([' One Term: ' num2str(err1) ])
disp([' LCM:      ' num2str(err2) ])


