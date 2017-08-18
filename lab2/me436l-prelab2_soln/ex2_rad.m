%% ME 436L Heat Transfer
% Lab 2 | Extended Surfaces: Radiation
%
%  INSTRUCTIONS
%  ------------
%
%  This script loads three sets of data and calculations the relative
%  impact of radiation. A bar graph and table are produced.
%
%  NOTE: You will need to complete the following functions:
%
%       caseB.m
%       caseD.m
%       calc_eta.m
%       calc_epsilon.m
%
%#ok<*SNASGU>
%#ok<*NUSED>
%#ok<*SAGROW>
%#ok<*UNRCH>

%% Initialization
clear ; close all; clc
addpath('./lib');
raw = [];

disp(' ')
disp(' --------------------------------------------------------')
fprintf('<strong>            Lab 2: Extended Surfaces | Radiation               </strong>\n')
disp(' --------------------------------------------------------')
disp(' ')

%% SETUP

% set path to folder containing excel sheets
pDIR = './data';

% grab all excel files in directory
xl_files = dir( [pDIR '/*.xlsx']);
NX = length(xl_files);

% Data Info
% s1/s2 - Natural Convection (h=9)
% s3/s4 - Low Forced (h = 30)
% s5/s6 - High Forced (h = 40)

global sigma ep As Tinf

% Fin Properties 
h = [9, 30, 40];             % [W/m^2 C]
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

% loop over stations
for ii = 1:3
    
    % load data
    raw = xlsread([pDIR '/' xl_files(ii).name]);
    
    % get temps
    dat = raw(:,2:9)+ 273;              % [K]
    
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


%% PLOT BARGRAPH
figure; hold on;

% set colors
[bl, rd, org, gry] = setColors();
wht = [1,1,1];

% set y values
y = [q_rad(1), q_conv(1);q_rad(2), q_conv(2);q_rad(3), q_conv(3)];

% plot, set bar colors
b = bar(y); b(1).FaceColor = rd; b(2).FaceColor = bl;

% labels
xlabh = get(gca,'XLabel');
set(xlabh,'Position',get(xlabh,'Position') - [0 0.5 0])
set(gca,'XTick', 1:3,'XTickLabel',{'Free Convection','Med-Forced','High-Forced'})
ylabel('Power [W]');
title('Heat Transfer Rate, q [W]','FontSize',20);
legend('Radiation', 'Convection','Location','northwest')
grid on
%ylim([0 2]);
hold off;

% table
lbl = {'Free';'Med';'High';};
r1 = round(q_conv,3);
r2 = round(q_rad,3);
r3 = round(pct_rad,3)*100;
Tr = table(lbl,r1',r2',r3','VariableNames',{'Station';'CONV';'RAD';'PCT_RAD'});

%% PRINT to SCREEN

disp(' ')
disp( ' Heat Transfer Rate [W]:')
disp(' ')
disp(Tr)


% print PNG
print('figs/rad_estimation', '-dpng','-r200');
