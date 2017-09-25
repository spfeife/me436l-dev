%% ME 436L Heat Transfer
% Lab 3 | Transient Conducton: SPHERE
%
%  INSTRUCTIONS
%  ------------
%
%  This file contains code that will guide you through the assignment. Be 
%  sure to follow the instructions provided in the attached document.
%
%  This script performs the following operations:
%
%    - Plots the experimental centerline Temperatures
%    - Plots centerline temperatures for two theoretical models:
%            * Lumped-Capacitance (LCM)
%            * One-term approximation
%
%    - Computes the error between theoretical models and experimental data
%
%
%  NOTE: You will need to complete the following functions:
%
%       lcm.m
%       one_term.m
%
%%
% Written By: Spencer Pfeifer | Revisions: Paola G. Pittoni
% Date:   9/2/17
%
%#ok<*SNASGU>
%#ok<*NUSED>
%#ok<*SAGROW>
%#ok<*UNRCH>

%% Initialization
clear ; close all; clc
addpath('./lib');
addpath('./data');

global alfa h k
global Ti Tinf

disp(' ')
disp(' --------------------------------------------------------')
fprintf('<strong>                Lab 3: Transient Conduction               </strong>\n')
disp(' --------------------------------------------------------')
disp(' ')

%% =========== Part 0: SETUP / PATHS ============= 
% In this section you must tell MATLAB where your data is. For each data
% set, you must provide: (1) name of your excel sheet and (2) the material
% type. Examples are provided below. NOTE: This assumes that your data is
% stored in the /data folder. Otherwise, you must provide the full path.

% you will find it easiest to simply comment out one or the other.
fname = 'brass_sphere'; matl_type = 'Brass';
%fname = 'steel_sphere'; matl_type = 'SS';


%% =========== Part 1: Input Properties ============= 
% Now, using the procedures document for reference, fill in the necessary
% information below

fprintf(['<strong>' 'PART 1:' '</strong>'])
fprintf([' Set Properties: ' '<strong>' matl_type ' Sphere </strong>\n']);

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


% break: Comment this out to proceed.
%break_msg; dbstack; return;


%% =========== Part 2: Plot Data  ============= 
% Now, this section performs the computations and plots our data.

cprintf('comments', '>> DONE.\n');

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


disp(' ');
fprintf(['<strong>' 'PART 2:' '</strong>'])
fprintf(' Compute LCM & One-Term Approximation. \n');

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
Bi1 = (h * Lc_one_term)/k;

% find coefficients C1 & z1 from table 5.1
[z1, C1] = set_coeffients(Bi1, 'sphere');

% compute one-term approximation
[T1, Fo1, theta_star] = one_term(t, Lc_one_term, z1, C1);

cprintf('comments', '>> DONE.\n');

%% PLOTTING / Error
plot_fo(Fo1, theta_star);
plot_data(t,T, T_lcm, T1, titl);

% print figs
if ispc  % if windows
    print(['figs/' fname], '-dtiff','-r150');
else
    print(['figs/' fname], '-dpng','-r150');
end


%% COMPUTE ERROR

err1 = norm(T-T1)/norm(T);
err2 = norm(T-T_lcm)/norm(T);

disp(' ');
fprintf(['<strong>' 'ERROR:\n' '</strong>'])
disp([' One Term: ' num2str(err1) ])
disp([' LCM:      ' num2str(err2) ])



