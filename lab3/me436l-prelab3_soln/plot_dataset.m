%% ME 436L Heat Transfer
% Lab 3 | Transient Conducton: Quick Plotting Tool
%
%  INSTRUCTIONS
%  ------------
%
%  This is a short script that can be used to quickly plot the experimental
%  data. Two figures will be created:
%
%       1. Raw data plot, showing T1 (Water Temp), T2 (Time Stamp), &
%           T3 (Sample Temperature)
%       2. The 'Shifted' Sample Temperature (see assignment instructions
%           for more details)
%
%   NOTE: To run this script, you need only to supply the data
%   filename/path
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

%% =========== Part 0: SETUP / PATHS ============= 
% In this section you must tell MATLAB where your data is. For each data
% set, you must provide: (1) name of your excel sheet and (2) the material
% type. Examples are provided below. NOTE: This assumes that your data is
% stored in the /data folder. Otherwise, you must provide the full path.

% you will find it easiest to simply comment out one or the other.
fname = 'brass_slab'; matl_type = 'Brass';
%fname = 'steel_slab'; matl_type = 'SS';

% You may also want to change the plot title:
%titl = 'Thermal Response, Brass Cylinder';
titl = 'Thermal Response, SS Cylinder';

[bl, rd, org, gry] = set_colors();

%% =========== PLOTTING: Nothing to be done here ============= 

% load data
raw = xlsread(fname);
t = raw(:,1);

% plot raw data
figure;
h = plot(t,raw(:,2));
set(h,'Color',bl,'LineStyle','-','LineWidth',2.5);

hold on
h = plot(t,raw(:,3));
set(h,'Color','k','LineStyle','--','LineWidth',1.5);

hold on
h = plot(t,raw(:,4));
set(h,'Color',rd,'LineStyle','-','LineWidth',2.5);

xlabel('Time, [s]');
ylabel('Temperature, [C]');
title(titl,'FontSize',20);
legend('T_1 - Water Temperature','T_2 - Time Stamp' ,'T_3 - Sample Temperature', 'Location','Southeast')
grid on

xlim([0,180])
ylim([20,65])


% print figs
if ispc  % if windows
    print(['figs/' fname '-raw'], '-dtiff','-r150');
else
    print(['figs/' fname '-raw'], '-dpng','-r150');
end


% truncate t & T to start at 0
[T, t] = set_tzero(raw);

% plot truncated data
figure;
h1 = plot(t, T,'');
set(h1,'Color',org,'LineStyle','-','LineWidth',2.5);


xlabel('Time, [s]');
ylabel('Temperature, [C]');
title('Shifted Data','FontSize',20);
legend('T_3 - Sample Temperature', 'Location','Southeast')
grid on

xlim([0,180])
ylim([20,65])





