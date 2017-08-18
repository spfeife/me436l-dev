%% ME 436L Heat Transfer
% Lab 6 | Radiation: Heat Flux
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

%addpath('./lib')
addpath('../lib')
addpath('./data')

disp(' ')
disp(' --------------------------------------------------------')
fprintf('<strong>                Lab 6: Radiation: Heat Flux               </strong>\n')
disp(' --------------------------------------------------------')
disp(' ')

%% =========== PART 0: SETUP & PROPERTIES ============= 
% Next, we need to set the properties

Di = 0.1;       % [m]
Dj = 0.013;     % [m]

L = [0.200 0.300 0.400 0.500 0.600 0.700];      % [m]

ri = Di/2;              % [m]
rj = Dj/2;              % [m]

Ri = ri./L;             % [m]
Rj = rj./L;             % [m]

Aj = pi * rj^2;         % [m^2]
Ai = pi * ri^2;         % [m^2]

sigma = 5.67E-08;       % [W/(m^2 K^4)]
ep = 0.9;

% if print tables to csv
IF_PRINT_TABLES = 0;
IF_PRINT_FIGS = 0;

%% =========== PART 1: PLOT DATA ============= 
%  We start by first loading a sample dataset and plotting the heat fluxes
%  vs distance

% set name of excel sheet
fname = 'heat_flux.xlsx';

% load data, truncate rows 
[dat, rmin, nSheets] = preloader(fname);

% preallocate for speed
qmat = zeros(rmin, nSheets);
Ti_avg_mat = zeros(rmin, nSheets);

% loop over sheets (distances)
for ii = 1:nSheets

    % load data
    raw = dat{ii};
  
    % extract temps
    temps = raw(:,2:5);
    T10 = raw(:,6);
    
    % set q,avg  (radiometer)
    qmat(:,ii) = raw(:,7);              % [W/m^2]
end

% average over last 30 sec
q = mean(qmat(end-20:end,:));            % [W/m^2]
Ts = mean(T10);                          % [C]

% plot q-flux
plot_transient_data(qmat);

% convert Temp to K
Ts = Ts + 273.15;       % [K]

% remove break when completed
%break_msg; dbstack; return;

%% =========== PART 2: CALCULATIONS ============= 

fprintf('Calculating Heat Flux... \n');

% loop over distances, calculate heat flux
for ii = 1:length(L)
    
    % view factor
    S = 1 + (1 + Rj(ii)^2)/(Ri(ii)^2);
    Fij = 1/2 * (S - (S^2 - 4 * (rj/ri)^2)^(1/2));
    Fji = Ai * Fij/Aj;
    
    % calc q rad
    J = ep * sigma * Ts^4;
    qc(ii) = J * Fji;
    
    % error
    err(ii) = abs( q(ii) - qc(ii))/q(ii) * 100;
end

fprintf('Done. \n\n');

%% TABLES & OUTPUT

% round, place into matrix
T1 = set_array(L, q, qc, err);

% fill table
descr = 'Heat Flux:';
col_names = {'L','qrad', 'qcalc','err'};
[Tbl] = print_table(T1, descr, col_names, 'heat_flux');

% plotting
plot_heat_flux;

%% ERROR
disp(' ')
total_err = norm(q-qc,2)/norm(q,2);
fprintf(['<strong> L2 Norm: ' num2str(total_err) '</strong>\n'])


