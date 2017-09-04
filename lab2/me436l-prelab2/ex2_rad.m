%% ME 436L Heat Transfer
% Lab 2 | Extended Surfaces: Radiation
%
%  INSTRUCTIONS
%  ------------
%
%  This file contains code that will guide you through the RADIATION
%  portion of the assignment. Be sure to follow the instructions provided
%  in the attached document.
%
%  This script performs the following operations:
%
%       - Estimates the relative heat lost to radiation and convection
%       - Computes percentages and plots a bar graph for comparison
%
%    NOTE: You will need to complete the following functions:
%
%       calc_rad.m
%       calc_conv.m
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
raw = [];

global IF_PRINT_TABLES
IF_PRINT_TABLES = 1;

disp(' ')
disp(' --------------------------------------------------------')
fprintf('<strong>            Lab 2: Extended Surfaces | Radiation               </strong>\n')
disp(' --------------------------------------------------------')
disp(' ')

%% =========== Part 0: SETUP / PATHS ============= 
% In this section you must tell MATLAB where your data is. For each data
% set, you must provide: (1) name of your excel sheet, (2) h coefficient
% value, (3) a proper title/description for your plots.  An example is
% provided to you using the sample dataset.

% set path to folder containing data (best to leave this alone)
pDIR = './data';

% set 1
fname{1,1} = 's1_h9.xlsx';
h(1) = 9;    % [W/m^2 C]
titles{1,1} = 'Temperature Distribution: h = 9 [W/m^2 C]';

% set 2
fname{1,2} = 's3_h30.xlsx';
h(2) = 30;   % [W/m^2 C]
titles{1,2} = 'Temperature Distribution: h = 30 [W/m^2 C]';

% set 3
fname{1,3} = 's5_h40.xlsx';
h(3) = 40;    % [W/m^2 C]
titles{1,3} = 'Temperature Distribution: h = 40 [W/m^2 C]';

%% =========== Part 1: Input Properties ============= 
% Now, using the procedures document for reference, fill in the necessary
% information below

fprintf(['<strong>' 'PART 0:' '</strong>'])
fprintf(' Set Properties. \n');

% set globals
global sigma ep As Tinf

% Fin Properties **FIX ME**
D = 0.01;                    % (Diameter) [m]

% Surface area -- Note: we assume 1/3 of the length!
L = 0.33 * 0.35;
As = pi * 0.01 * L;

% boltzmann
sigma = 5.67e-8;            % [W/(m^2 K^4)]

% calibrated ep from FLIR camera (0.78 - 0.82)
ep = 0.82;

% Set Tinf -- as measured in lab
Tinf = 23.5 + 273;     % [K]

% break
%break_msg; dbstack; return;

%% =========== Part 2: Loop over data & Plot ============= 
% Now, this section performs the computations and plots our data. This is
% done by looping over each dataset. Therefore, you must complete each of
% the functions above before continuting on.

disp(' ');
cprintf('comments', '>> DONE.\n');

% loop over stations
for ii = 1:length(fname)
    
    % make sure files exists
    if ~exist([pDIR '/' fname{ii}],'file')
        error(['   FILE: ' fname{ii} ' NOT FOUND! CHECK FILENAME!'])
    end

    % load data
    raw = xlsread([pDIR '/' fname{ii}]);

    % get temps
    dat = raw(:,2:9)+ 273;          % [K]
    
    % take average of last N points (~20)
    N = 20;
    Tm = mean(dat(end-N:end,:));
    
    % should use FLIR camera to get this temperature (use box average over
    % 1/3 of area)
    T = (Tm(1) + Tm(2))/2;
    
    % radiation & convection estimations
    q_rad(ii) = calc_rad(T);
    q_conv(ii)= calc_conv(T,h(ii));
    
    pct_rad(ii) = q_rad(ii)/( q_conv(ii) + q_rad(ii));
    
end



%% PRINT FIGURES & TABLES

% plotting
plot_bargraph;

% print figs
if ispc  % if windows
    print('figs/rad_estimation', '-dtiff','-r150');
else
    print('figs/rad_estimation', '-dpng','-r150');
end

% print table
T1 = set_array(q_conv, q_rad, pct_rad, 'round', 3);
descr = ' Heat Transfer Rate [W]:';
var_names = {'CONV';'RAD';'PCT_RAD'};
lbl = {'Free';'Med';'High';};
print_table(T1, descr, lbl, var_names, 'radiation');

