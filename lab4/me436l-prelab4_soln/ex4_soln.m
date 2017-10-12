%% ME 436L Heat Transfer
% Lab 4 | External Convection
%
%  INSTRUCTIONS
%  ------------
%
%  This file contains code that will guide you through the assignment. Be
%  sure to follow the instructions provided in the accompanying document.
%
%  NOTE(1): You will need to complete the following functions:
%
%       hilpert.m
%       zukauskas.m
%       churchill_bernstein.m
%       calc_uncertainty.m
%
%  NOTE(2): This script will automatically print figures in the /figs
%       folder and it will output tables to .csv in the /output folder
%
%%
% Written By: Spencer Pfeifer | Revisions: Paola G. Pittoni
% Date:   10/12/17
%
%#ok<*SNASGU>
%#ok<*NUSED>
%#ok<*SAGROW>
%#ok<*UNRCH>

%% Initialization
clear ; close all; clc
addpath('./lib');
addpath('./data');

% initialize globals
global T_inf V I As
global D
global IF_PRINT_TABLES
IF_PRINT_TABLES = 1;

disp(' ')
disp(' --------------------------------------------------------')
fprintf('<strong>                Lab 4: External Convection               </strong>\n')
disp(' --------------------------------------------------------')
disp(' ')

%% =========== PART 0: PROPERTIES // SETUP  =============
% In this section you must tell MATLAB where your data is and provide the
% relevant material specifications and properties. That is, for each data
% set, you must provide:
%   (1) Name of your excel sheet
%   (2) Material properties and specifications. Take note of units!
%
%   NOTE: This assumes that your data is stored in the /data folder.
%   Otherwise, you must provide the full path.

fprintf(['<strong>' 'PART 0:' '</strong>'])
fprintf(' Set Properties. \n');

% dimensions
D = .75*.0254;          % [m]
L = 4.5*.0254;          % [m]

% surface area
Ad = pi * D;          % [m^2]
As = Ad * L;          % [m^2]

% boltzman & emissivity
ep = 0.71;               % [-]
sigma = 5.67E-08;        % [W/m2 K^4]

% Ambient air temp
T_inf = 21.3 + 273.15;     % [K]

% input velocities
v_mph = [20, 30, 40, 50];
v = v_mph .* 0.44704;       % [m/s]

% air thermal conductivity
kf = airProp2(T_inf,'k');   % [W/m-K]

delta = zeros(1,4);

%% LOAD DATA

% input names of excel files
sname = 's1_Al.xlsx';
%sname = 's2_Brass.xlsx';
%sname = 's3_SS.xlsx';

titles = {'20mph', '30mph','40mph','50mph'};

% break
%break_msg; dbstack; return;

% make sure data exists
if ~exist(sname,'file')
    error(['   FILE: ' sname ' NOT FOUND! CHECK FILENAME!'])
end
cprintf('comments', '>> DONE.\n');


%% =========== PART 1: COMPUTATIONS =============
% This section performs the computations and plots our data. This is
% done by looping over each velocity. Therefore, you must complete each of
% the functions above before continuting on.
%
% NOTE: This script loops over the TABS in the excel sheet.

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
    Tm1(ii) = Tm(1);
    Tm2(ii) = Tm(2);
    
    % set Ts & Tf, convert to K
    Ts = (Tm(1) + Tm(2))/2;     % [C]
    Ts = Ts + 273.15;           % [K]
    Tf = (Ts + T_inf)/2;        % [K]
    
    %% ENERGY BALANCE // ESTIMATE h_exp
    
    % power-in and radiation
    q_in = P;
    q_rad = sigma * ep * As * (Ts^4 - T_inf^4);
    
    % Use C-B OR Hilpert for Nu estimation
    %Nu = hilpert(Tf, v(ii));
    Nu = churchill_bernstein(Tf, v(ii));
    
    % Estimated h
    h = Nu * kf/D;
    
    % Estimated q_conv & q_cond
    q_conv = h * As * (Ts - T_inf);
    q_cond = q_in - (q_conv + q_rad);
    
    % Estimate pct loss
    pct_conv(ii) = q_conv/q_in;
    pct_cond(ii) = q_cond/q_in;
    pct_rad(ii)  = q_rad/q_in;
    
    % Since this is an estimate, we round it off to 2 decimal places
    pct_loss = round(abs(pct_rad(ii)) + abs(pct_cond(ii)), 2);
    
    % Estimate h_exp via Newton's law of cooling:
    h_exp(ii) = q_in * (1-pct_loss)/(As * (Ts - T_inf));
    
    % load table
    T1(ii,:) = set_array(P, q_conv, q_rad, q_cond,'round', 2);
    T2(ii,:) = set_array(pct_conv(ii), pct_rad(ii), pct_cond(ii), pct_loss,'round', 6);
    
    %% CALCULATE CORRELATIONS
    % calculate h from correlations
    
    % Hilpert Correlation
    [Nu, Re, Pr, ~] = hilpert(Tf, v(ii));
    h_hil(ii) = Nu * kf/D;
    
    % Fill table for output
    Th(ii,:) = set_array(h_hil(ii), Nu, Re, Pr,'round', 2);
    
    % Zukauskas Correlation
    [Nu, Re, Pr, ~] = zukauskas(T_inf, Ts, v(ii));
    h_zuk(ii) = Nu * kf/D;
    Tz(ii,:) = set_array(h_zuk(ii), Nu, Re, Pr,'round', 2);
    
    % Churchill-Bernstein Correlation
    [Nu, Re, Pr, nu] = churchill_bernstein(Tf, v(ii));
    h_church(ii) =  Nu * kf/D;
    Tc(ii,:) = set_array(h_church(ii), Nu, Re, Pr,'round', 2);
    
    %% CALCULATE ERROR & UNCERTAINTY
    err_hil(ii) = abs(h_hil(ii) - h_exp(ii))/h_exp(ii);
    err_zuk(ii) = abs(h_zuk(ii) - h_exp(ii))/h_exp(ii);
    err_church(ii) = abs(h_church(ii) - h_exp(ii))/h_exp(ii);
    
    % fill table
    Te(ii,:) = set_array(err_hil(ii), err_zuk(ii), err_church(ii),'round', 6);
    
    % Uncertainty // propagation of error
    delta(ii) = calc_uncertainty(Tm, pct_conv(ii));
    
end


%% OUTPUT

print_all_tables;
plot_h;
plot_err;
plot_pct_loss;
