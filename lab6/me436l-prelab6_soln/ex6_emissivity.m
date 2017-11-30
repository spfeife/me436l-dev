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
%%
% Written By: Spencer Pfeifer | Revision: Paola G. Pittoni
% Date:   8/25/17
%
%#ok<*SNASGU>
%#ok<*NUSED>
%#ok<*SAGROW>
%#ok<*UNRCH>

%% Initialization
clear ; close all; clc
addpath('./lib');
addpath('./data');

disp(' ')
disp(' --------------------------------------------------------')
fprintf('<strong>                Lab 6: Radiation: Emissivity               </strong>\n')
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
L = 0.200;      % [m]

Di = 0.1;       % [m]
Dj = 0.013;     % [m]

ri = Di/2;      % [m]
rj = Dj/2;      % [m]

Ri = ri/L;      % [m]
Rj = rj/L;      % [m]

% Define Area
Aj = pi * rj^2;     % [m^2]
Ai = pi * ri^2;     % [m^2]

sigma = 5.67E-08;   % [W/(m^2 K^4)]

% set published values (vector)
ep_pub = 0.25;      % copper
%ep_pub = 0.40;      % SS
%ep_pub = 0.25;      % AL

% PATH TO EXCEL SHEET
pdata = './data/emissivity_data/s1_polished_cu.xlsx';

% set material labels
stitle = 'Polished Copper';
%stitle = 'stainless';
%stitle = 'aluminum';

% break
%break_msg; dbstack; return;

%% =========== PART 1: PLOT DATA =============


% make sure data exists
if ~exist(pdata,'file')
    error(['   FILE: ' sname ' NOT FOUND! CHECK FILENAME!'])
end
cprintf('comments', '>> DONE.\n');

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
plot_q(qmat);
title(stitle)

% convert Temp to K
Ti = Ti + 273.15;       % [K]


%% =========== PART 2: CALCULATIONS ============= 
% Now we perform the calculations for View Factor and Emissivity. See text
% for equations. Then, we compute the error with published values.

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


%% OUTPUT
print_to_screen;








