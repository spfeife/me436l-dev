%% ME 436L Heat Transfer
% Lab 6 | Radiation: Emissivity Single Plot
%
%  INSTRUCTIONS
%  ------------
%
%  This file contains code that will guide you through the assignment. Be 
%  sure to follow the instructions provided in the attached document.
%
%  You will only need to complete the following functions:
%   TODO: What files need edited?
%           * fcn1.m
%           * fcn1.m
%
%  In addition, you will need to input the proper properties.
%
%  NOTES: Be sure to clean up excel sheet first: 
%            - Each run should have at least 90s of data
%            - Place each dataset into a tab in your excel sheet (like the
%               sample data provided)
%                o  Order: 200mm, 300mm, ... ,700mm
%
%   See assignment description for more information.
%
%#ok<*SAGROW>
%#ok<*NUSED>

%% Initialization
clear ; close all; clc

global IF_PRINT_TABLES;
global IF_PRINT_FIGS;

clear; close all;

%addpath('./lib')
addpath('../lib')

disp(' ')
disp(' --------------------------------------------------------')
fprintf('<strong>                Lab 6: Radiation: Emissivity               </strong>\n')
disp(' --------------------------------------------------------')
disp(' ')

% if print tables to csv
IF_PRINT_FIGS = 0;

%% =========== PART 1: PLOT DATA ============= 

% set path
pdata = './data/emissivity_data/s1_polished_cu.xlsx';
stitle = 'Polished Copper';

% load data
[dat, rmin, nSheets] = preloader(pdata);

% loop over sheets
for ii = 1:nSheets

    % load data
    raw = dat{ii};
    
    % extract temps
    temps = raw(:,2:5);
    T10 = raw(:,6);
    
    % Average data
    Ti_avg_mat(:,ii) = mean(temps,2);       % [C]
    
    % set q,avg  (radiometer)
    qmat(:,ii) = raw(:,7);                  % [W/m^2]

end

% set qmax
q_max = max(max(qmat));  

% vecs over time
qa = mean(qmat,2);                       % [W/m^2]
q_mavg = movmean(mean(qmat,2),10);       % [W/m^2]
Ti_avg = mean(Ti_avg_mat,2);

q_avg = max(qa(end-30:end));             % [W/m^2]
Ti = mean(Ti_avg(end-30:end));           % [C]

% plot q
plotq(qmat);
title(stitle)

% convert Temp to K
Ti = Ti + 273.15;       % [K]


% plot transient q data
function plotq (qmat)
q_mavg = movmean(mean(qmat,2),10);      % [W/m^2]

bl = [0 0.445 0.738];           % parula blue
rd = [0.62891 0 0.12109];       % parula red
gry = [0.3 0.3 0.3];

h = plot(qmat(:,1)); hold on;
set(h,'Color', [bl, 0.5],'LineWidth',1.5);

h = plot(qmat(:,2));
set(h,'Color', [rd, 0.5],'LineWidth',1.5);

h = plot(qmat(:,3));
set(h,'Color', [gry, 0.5],'LineWidth',1.5);

h = plot(q_mavg,'-.');
set(h,'Color', [0.1,0.1,0.1,0.9],'LineWidth',1.5);


legend('Run1','Run2','Run3','Avg','Location','southeast');
xlabel('Time, t [sec]');
ylabel('Heat Flux, q [W/m2]');
grid on
hold off

end



