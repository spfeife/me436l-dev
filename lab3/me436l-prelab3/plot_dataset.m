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

clear ; close all; clc
addpath('./lib');
addpath('./data');


%% =================    SETUP    ==================
matl_type = 'SS';
%matl_type = 'Brass';

%fname = 'brass_cylinder';
fname = 'steel_cylinder';

%titl = 'Thermal Response, Brass Cylinder';
titl = 'Thermal Response, SS Cylinder';

[bl, rd, org, gry] = setColors();

%% Calculations

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





