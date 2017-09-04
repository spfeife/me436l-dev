%% ME 436L Heat Transfer
% Lab 2 | Extended Surfaces: Main
%
%  INSTRUCTIONS
%  ------------
%
%  This file contains code that will guide you through the assignment. Be 
%  sure to follow the instructions provided in the attached document.
%
%  This script performs the following operations:
%
%       - Plots data from 3 stations and compares with models A, B, D
%       - Compares heat transfer rates to input power
%       - Compares fin effectiveness & efficiency
%
%       * NOTE(1): This script does not include the radiation portion of
%       the experiment
%
%       * NOTE(2): This script will automatically print figures in the /figs
%       folder and it will output tables to .csv in the /output folder
%
%  NOTE: You will need to complete the following functions:
%
%       caseB.m
%       caseD.m
%       calc_eta.m
%       calc_epsilon.m
%
%      * caseA.m has been completed for your reference.
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
fprintf('<strong>                Lab 2: Extended Surfaces               </strong>\n')
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
global D k P L Ac Af T_inf

% Fin Properties **FIX ME**
D = 1; %???                      % (Diameter) [m]
k = 1; %???                      % (Conductivity, Brass) [W/m C]
P = pi * D;                      % (Perimeter) [m]
L = 1; %???                      % (Length of fin) [m]
Ac = 1; %???                     % (Cross Sectional Area) [m^2]
Af = pi * D * L;                 % (Fin Surface Area) [m^2]

% Set Tinf -- as measured in lab
T_inf = 22.5;     % [C]

% break
break_msg; dbstack; return;

% x vec for plotting
xe = 0:0.05:0.35;            % (Position - experiment) [m]
x = linspace(0,0.35,200);    % (Position - theory) [m]

% export figure names
str_print = {['h_' num2str(h(1))],['h_' num2str(h(2))], ... 
    ['h_' num2str(h(3))]};

disp(' ');
cprintf('comments', '>> DONE.\n');

%% =========== Part 2: Loop over data & Plot ============= 
% Now, this section performs the computations and plots our data. This is
% done by looping over each dataset. Therefore, you must complete each of
% the functions above before continuting on.

% loop over stations
for ii = 1:length(fname)
    
    % make sure files exists
    if ~exist([pDIR '/' fname{ii}],'file')
        error(['   FILE: ' fname{ii} ' NOT FOUND! CHECK FILENAME!'])
    end

    % load data
    raw = xlsread([pDIR '/' fname{ii}]);

    % get time vector
    t = raw(:,1);         % [s]
    
    % get temps
    dat = raw(:,2:9);     % [C]
    
    % get voltage/current
    V = raw(:,11);        % [V]
    I = raw(:,12);        % [A]
    
    % take average of last N points (~20)
    N = 20;
    Tm = mean(dat(end-N:end,:));
    Vm = mean(V(end-N:end));
    Im = mean(I(end-N:end));
    
    % set T_base
    Tb = Tm(1);        % [C]
    
    % determine average power input
    PWR(ii) = Vm * Im;
    
    % Set fin excess temperatures
    theta_x = Tm - T_inf;
    theta_b = Tb - T_inf;
    
    % Calculate m & M
    M = sqrt((h(ii) * P * k * Ac)) * theta_b;
    m = ((h(ii) * P) / (k * Ac))^0.5;
    mL = m * L;
    h_mk = h(ii)/(m*k);
    
    % Case A
    [TA, qA(ii)] = caseA(x, theta_b, m, M, h(ii));

    % Case B
    [TB, qB(ii)] = caseB(x, theta_b, m, M);

    % Case D
    [TD, qD(ii)] = caseD(x, theta_b, m, M);
    
    % efficiency (eta)
    eta_A(ii) = calc_eta(qA(ii), theta_b, h(ii));
    eta_B(ii) = calc_eta(qB(ii), theta_b, h(ii));
    eta_D(ii) = calc_eta(qD(ii), theta_b, h(ii));
    
    % effectiveness (epsilon)
    ep_A(ii) = calc_epsilon(qA(ii), theta_b, h(ii));
    ep_B(ii) = calc_epsilon(qB(ii), theta_b, h(ii));
    ep_D(ii) = calc_epsilon(qD(ii), theta_b, h(ii));

    % calculate error (percent)
    p_error_A(ii) = abs(PWR(ii) - qA(ii))/PWR(ii) * 100;
    p_error_B(ii) = abs(PWR(ii) - qB(ii))/PWR(ii) * 100;
    p_error_D(ii) = abs(PWR(ii) - qD(ii))/PWR(ii) * 100;

    plot_data;

    % print figs
    if ispc  % if windows
        print(['figs/' str_print{1,ii}], '-dtiff','-r150');
    else
        print(['figs/' str_print{1,ii}], '-dpng','-r150');
    end
end

%% PRINT TABLES TO SCREEN

% set row names
row_names = {['h = ' num2str(h(1))],['h = ' num2str(h(2))], ... 
    ['h = ' num2str(h(3))]};

% print heat rate
T1 = set_array(PWR, qA, qB, qD, 'round', 3);
descr = ' Heat Transfer Rate [W]:';
var_names = {'Pin','qA', 'qB','qD'};
print_table(T1, descr, row_names, var_names, 'heat_rate');

% print error
T2 = set_array(p_error_A, p_error_B, p_error_D, 'round', 3);
descr = '  Error [pct]:';
var_names = {'qA';'qB';'qD'};
print_table(T2, descr, row_names, var_names, 'error');

% print efficiency
T3 = set_array(eta_A, eta_B, eta_D, 'round', 3);
descr = '  Efficiency [pct]:';
var_names = {'CaseA';'CaseB';'CaseD'};
print_table(T3, descr, row_names, var_names, 'efficiency');

% print effectiveness
T4 = set_array(ep_A, ep_B, ep_D, 'round', 3);
descr = '  Effectiveness [-]:';
var_names = {'CaseA';'CaseB';'CaseD'};
print_table(T4, descr, row_names, var_names, 'effectiveness');



