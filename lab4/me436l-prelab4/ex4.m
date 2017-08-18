%% ME 436L Heat Transfer
% Lab 4 | External Convection
%
%  INSTRUCTIONS
%  ------------
%
%  Complete the script below to perform the analysis for this experiment
%
%       ** BE SURE TO INPUT THE CORRECT PROPERTIES ** 
%
%  NOTE: You will need to complete the following functions:
%
%       hilpert.m
%       zukauskas.m
%       churchill_bernstein.m
%       calc_uncertainty.m
%
%#ok<*SNASGU>
%#ok<*NUSED>
%#ok<*SAGROW>
%#ok<*UNRCH>

%% Initialization
clear ; close all; clc
addpath('./lib');
addpath('./data')
raw = [];

disp(' ')
disp(' --------------------------------------------------------')
fprintf('<strong>                Lab 4: External Convection               </strong>\n')
disp(' --------------------------------------------------------')
disp(' ')

%% PROPERTIES / SETUP

% set to 1 if you wish to print the figs to png
IF_PRINT_FIGS = 0;

global T_inf V I As
global D

% dimensions
D = 0.000;          % [m]
L = 0.000;          % [m]

% boltzman & emissivity
ep = 0.0;         % [ ]      
sigma = 00;       % [W/m2 K^4]

% air temp
T_inf = 00 + 273.15;     % [K]

% input velocities
v_mph = [20, 30, 40, 50];
v = v_mph .* 00;       % [m/s]

% air thermal conductivity
kf = airProp2(T_inf,'k');   % [W/m-K]

% surface area
Ad = pi * D;          % [m^2]
As = Ad * L;          % [m^2]
delta = zeros(1,4);

% break

disp('Make sure the properties are set correctly')
break_msg; dbstack; return;
%% load data

% INPUT names of excel files
% NOTE: This script loops over the TABS in the excel sheet.

%sname = 's1_Al.xlsx';
sname = 's2_Brass.xlsx';
%sname = 's3_SS.xlsx';
titles = {'20mph', '30mph','40mph','50mph'};

% loop over velocities
for ii = 1:4
    
    % load data
    raw = xlsread(sname,ii);
    
    % take average of last N points (~20)
    N = 20;
    dat = mean(raw(end-N:end,:));
    
    % get power, P
    V = dat(:,4); I = dat(:,5);
    P = V*I;    % [W]
    
    % set mean temp,
    Tm = dat(2:3);
    
    % set Ts & Tf, convert to kelvins
    Ts = (Tm(1) + Tm(2))/2;     % [C]
    Ts = Ts + 273.15;           % [K]
    Tf = (Ts + T_inf)/2;        % [K]
    
    %% Energy balance & Estimate h_exp
    
    % power-in and radiation
    q_in = P;
    q_rad = sigma * ep * As * (Ts^4 - T_inf^4);
    
    % use C-B for Nu estimation
    Nu = hilpert(Tf, v(ii));
    h = Nu * kf/D;
    
    q_conv = h * As * (Ts - T_inf);
    q_cond = q_in - (q_conv + q_rad);
    
    % pct loss
    pct_conv(ii) = q_conv/q_in;
    pct_cond(ii) = q_cond/q_in;
    pct_rad(ii)  = q_rad/q_in;
    pct_loss = round(abs(pct_rad(ii)) + abs(pct_cond(ii)),2);
     %= 0.1
    % newtons law of cooling:
    h_exp(ii) = q_in * (1-pct_loss)/(As * (Ts - T_inf));
    
    % load table
    T1(ii,:) = set_array(P, q_conv, q_rad, q_cond,'round', 2);
    T2(ii,:) = set_array(pct_conv(ii), pct_rad(ii), pct_cond(ii), pct_loss,'round', 6);
    
    %% Hilpert Correlation
    
    % calculate h from correlations
    [Nu, Re, Pr, ~] = hilpert(Tf, v(ii));
    h_hil(ii) = Nu * kf/D;
    
    % load table
    Th(ii,:) = set_array(h_hil(ii), Nu, Re, Pr,'round', 2);
    
    %% Zukauskas Correlation
    [Nu, Re, Pr, ~] = zukauskas(T_inf, Ts, v(ii));
    h_zuk(ii) = Nu * kf/D;
    
    % load table
    Tz(ii,:) = set_array(h_zuk(ii), Nu, Re, Pr,'round', 2);
    
    %% Churchill-Bernstein Correlation
    [Nu, Re, Pr, nu] = churchill_bernstein(Tf, v(ii));
    h_church(ii) =  Nu * kf/D;
    
    % load table
    Tc(ii,:) = set_array(h_church(ii), Nu, Re, Pr,'round', 2);

    %% CALCULATE ERROR
    
    err_hil(ii) = abs(h_hil(ii) - h_exp(ii))/h_exp(ii);
    err_zuk(ii) = abs(h_zuk(ii) - h_exp(ii))/h_exp(ii);
    err_church(ii) = abs(h_church(ii) - h_exp(ii))/h_exp(ii);
    
    % load table
    Te(ii,:) = set_array(err_hil(ii), err_zuk(ii), err_church(ii),'round', 6);
    
    %% uncertainty // propagation of error

    % delta(ii) = calc_uncertainty(Tm,pct_conv(ii));

end







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%        END       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% TABLES & OUTPUT

row_names = {'20 mph','30 mph','40 mph','50 mph'};

% print heat rate
descr = 'Heat Transfer rate:';
var_names = {'Pin','qconv', 'qrad','qcond'};
print_table(T1, descr, row_names, var_names, 'heat_rate');

% Pct loss per HT mode
descr = 'Percentage loss by heat transfer mode:';
var_names = {'conv','rad','cond','totalLosses'};

for ii = 1:4
    a(:,ii) = cellstr(num2str(T2(:,ii)*100,'%5.2f%%'));
end

print_table(a, descr, row_names, var_names, 'pct_loss');

% Hilpert Correlation
descr = 'Hilpert Correlation:';
var_names = {'h','Nu','Re','Pr'};
print_table(Th, descr, row_names, var_names, 'hilpert');

% Zuk Correlation
descr = 'Zukauskas Correlation:';
print_table(Th, descr, row_names, var_names, 'zuk');

% CB Correlation
descr = 'Churchill-Bernstein Correlation:';
print_table(Tc, descr, row_names, var_names, 'CB');


% Pct error per correlation
for ii = 1:3
    b(:,ii) = cellstr(num2str(Te(:,ii)*100,'%5.2f%%'));
end

descr = 'Percent Error:';
var_names = {'hExp','Hil','Zuk','CB'};

T = table; T.hExp = round(h_exp',2); T.Hilpert = b(:,1);
T.Zukauskas = b(:,2); T.CB = b(:,3);
print_table(T, descr, row_names, var_names, 'pct_error');

% H Exp + delta
if delta(1) ~= 0
    T = table; T.hExp = h_exp'; T.Uncertainty = delta';
    descr = 'Uncertainty';
    var_names = {'hExp','Delta'};
    print_table(T, descr, row_names, var_names, 'uncertainty');
end
%% PLOTTING

% colors
bl = [0 114 189]./256;      % parula blue
rd = [161 0 31]./256;       % parula red
org = [217 83 25]./256;     % parula orange


% plot h
h = plot(v_mph, h_exp,'o-'); hold on;
set(h,'Color', 'k' , 'MarkerFaceColor','k', 'MarkerSize',5, 'LineWidth',1.75);

h = plot(v_mph, h_hil,'s-.');
set(h,'Color', bl, 'MarkerSize',10, 'LineWidth',1.25);

h = plot(v_mph, h_zuk,'v-.');
set(h,'Color', rd, 'MarkerSize',10, 'LineWidth',1.25);

h = plot(v_mph, h_church,'>-.');
set(h,'Color', org, 'MarkerSize',10, 'LineWidth',1.25);


xlabel('Velocity [mph]');
ylabel('h [W/m2 K]');
title('Convection Coefficient','FontSize',20);
legend('Exp.', 'Churchill-Bernstein', 'Location','Northwest')
legend('Exp.', 'Hilpert','Zukauskas', 'Churchill-Bernstein', 'Location','Northwest')
grid on
hold off

% print figs
if IF_PRINT_FIGS
    print(['figs/' 'conv_coeff'], '-dpng','-r150');
end

% plot error
figure;
h = plot(v_mph, err_hil*100,'s-.'); hold on
set(h,'Color', bl, 'MarkerSize',10, 'LineWidth',1.25);
h = plot(v_mph, err_zuk*100,'v-.');
set(h,'Color', rd, 'MarkerSize',10, 'LineWidth',1.25);

h = plot(v_mph, err_church*100,'>-.');
set(h,'Color', org, 'MarkerSize',10, 'LineWidth',1.25);

xlabel('Velocity [mph]');
ylabel('% error');
title('Error','FontSize',20);
legend('Hilpert' ,'Churchill-Bernstein', 'Location','Northwest')
legend('Hilpert','Zukauskas', 'Churchill-Bernstein', 'Location','Northwest')
grid on
hold off
%ylim([0 10])

% print figs
if IF_PRINT_FIGS
    print(['figs/' 'err'], '-dpng','-r150');
end

% plot percent loss by mode
figure;
y = [pct_cond', pct_conv', pct_rad'].*100;
b = bar(v_mph, y); hold on

b(3).FaceColor = bl;
b(1).FaceColor = rd;
b(2).FaceColor = org;

xlabel('Velocity [mph]');
ylabel('% HT Loss');
title('HT Mode Comparison','FontSize',20);
l = legend('Conduction','Convection', 'Radiation', 'Location','Southoutside');
set(l,'Orientation','horizontal','Location','southoutside');

y1 = 0:0.05:0.15;
y2 = 0.20:0.1:1.0;
%yticks([y1 y2].*100)

%ytickformat('percentage')

grid on
hold off

% print figs
if IF_PRINT_FIGS
    print(['figs/' 'pct_mode'], '-dpng','-r150');
end