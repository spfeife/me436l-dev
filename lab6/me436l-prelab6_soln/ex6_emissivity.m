%% ME 436L Heat Transfer
% Lab 6 | Radiation: Emissivity Calculations
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


%% =========== PART 0: SETUP & PROPERTIES =============
% Next, we need to set the properties

L = 0.200;      % [m]

Di = 0.1;       % [m]
Dj = 0.013;     % [m]

ri = Di/2;      % [m]
rj = Dj/2;      % [m]

Ri = ri/L;      % [m]
Rj = rj/L;      % [m]

Aj = pi * rj^2;     % [m^2]
Ai = pi * ri^2;     % [m^2]

sigma = 5.67E-08;   % [W/(m^2 K^4)]

% set published values
epv(1) = 0.25;      % copper
epv(2) = 0.40;      % SS
epv(3) = 0.25;      % AL

% if print tables to csv
IF_PRINT_TABLES = 0;
IF_PRINT_FIGS = 0;

% data path
path = './data/emissivity_data';

%% =========== PART 1: PLOT DATA =============

% grab all excel files in directory
xl_files = dir([path '/' '*.xlsx']);
Nx = length(xl_files);

matl{1} = 'copper';
matl{2} = 'stainless';
matl{3} = 'aluminum';

rm_tmp_files(path);

% load data - repeat for 3 materials
%sname = ['./data/' sec '/' matl{mno} '.xlsx'];
%ep_pub = epv(mno);

% loop over stations
for jj = 1:Nx
    
    pdata = [path '/' xl_files(jj).name];
    
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
end

% % set qmax
% q_max = max(max(qmat));
%
% % vecs over time
% qa = mean(qmat,2);                       % [W/m^2]
% q_mavg = movmean(mean(qmat,2),10);       % [W/m^2]
% Ti_avg = mean(Ti_avg_mat,2);
%
% q_avg = max(qa(end-30:end));             % [W/m^2]
% Ti = mean(Ti_avg(end-30:end));           % [C]
%
% % plot q
% plotq(qmat);
%
% % convert Temp to K
% Ti = Ti + 273.15;       % [K]
%
%
% % IF SET MANUALLY
% q_avg = 18.10;
% Ti = 323.10;

%% Calculations

% view factor
S = 1 + (1 + Rj^2)/Ri^2;
Fij = 1/2 * (S - (S^2 - 4 * (rj/ri)^2)^(1/2));
Fji = Ai * Fij/Aj;

% solve for emissivity
ep = q_avg/(Fji * sigma * Ti^4);
ep_max = q_max/(Fji * sigma * Ti^4);

% error
err = abs(ep - ep_pub)/ep_pub * 100;
err2 = abs(ep_max - ep_pub)/ep_pub * 100;








%% PRINT TO SCREEN

sq_avg = sprintf('% 5.3f   [W/m2]', round(q_avg, 3));
sq_max = sprintf('% 5.3f   [W/m2]', round(q_max, 3));
sTi = sprintf('% 5.3f   [K]', round(Ti, 2));

sep = sprintf('% 5.3f', round(ep, 3));
sep_max = sprintf('% 5.3f', round(ep_max, 3));
sepub = sprintf('% 5.3f', round(ep_pub, 3));
serr = sprintf('%5.2f%%', round(err, 3));
serr2 = sprintf('%5.2f%%', round(err2, 3));

disp(' ')
disp(' --------------------------------------------------------')
disp('      Lab 5: Emissivity Calculation')
disp(' --------------------------------------------------------')
disp(' ')

disp(' ')
cprintf('*black',['Matl:  ' matl{mno} '\n']);

disp(' ')
cprintf('*black','Data: \n');
disp([' q_avg =  ' sq_avg])
disp([' q_max =  ' sq_max])
disp([' Tavg =  ' sTi])

disp(' ')
cprintf('*black','Emissivity: \n');

disp([' ep_pub =   ' sepub])
disp([' ep_calc =  ' sep])
disp([' ep_max =   ' sep_max])
disp(' ')
disp([' error =     ' serr])
disp([' error =     ' serr2])
disp(' ')









