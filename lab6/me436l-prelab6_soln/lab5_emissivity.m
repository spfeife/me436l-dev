%% Lab 5: Radiation
%
% Written By:    SP
% Last Update:   4/05/17
%
%
% NOTES:     Be sure to clean up excel sheet first 
%                - each run should have 90s of data
%                - Make sure all data is roughly steady-state (especially
%                the first few rows)
%

%#ok<*SAGROW>

%% MAIN
clear; close all;
addpath('./includes')


%% LOAD DATA

sec = 's7g1';
%sec = 's8g4_250';
%sec = 's1g1';
%sec = 's2g2_250';
%sec = 's6g2_250';
%sec = 's9g4_250';


L = 0.200;      % [m]
mno = 3;

matl{1} = 'copper';
matl{2} = 'stainless';
matl{3} = 'aluminum';

epv(1) = 0.25;
epv(2) = 0.40;
epv(3) = 0.25;

% load data - repeat for 3 materials
%sname = ['./data/' sec '/' matl{mno} '.xlsx']; ep_pub = epv(mno);

sname = '/Users/spfeife/Dropbox/ME436L/Labs/6 Radiation/solutions/matlab/data/s1g1/aluminum.xlsx';  ep_pub = epv(mno);
qmat = zeros(90,3);
Ti_avg_mat = zeros(90,3);

% loop over sheets
for ii = 1:1

    [raw,txt] = xlsread(sname,ii);
    
    % remove first column (time stamp)
    raw(:,1) = [];
    
    % extract temps
    temps = raw(1:90,1:4);
    T10 = raw(1:90,5);
    
    %% Average data
    
    % set Ti,avg
    Ti_avg_mat(:,ii) = mean(temps,2);       % [C]
    
    % set q,avg  (radiometer)
    qmat(:,ii) = raw(1:90,6);                  % [W/m^2]

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

% convert Temp to K
Ti = Ti + 273.15;       % [K]


% IF SET MANUALLY
q_avg = 18.10;
Ti = 323.10;

%% Properties

Di = 0.1;       % [m]
Dj = 0.013;     % [m]

ri = Di/2;      % [m]
rj = Dj/2;      % [m]

Ri = ri/L;      % [m]
Rj = rj/L;      % [m]

Aj = pi * rj^2;     % [m^2]
Ai = pi * ri^2;     % [m^2]

sigma = 5.67E-08;   % [W/(m^2 K^4)]

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








% plot transient q data
function plotq (qmat)

q_mavg = movmean(mean(qmat,2),10);      % [W/m^2]

bl = [0 0.445 0.738];           % parula blue
rd = [0.62891 0 0.12109];       % parula red
gry = [0.3 0.3 0.3];

h = plot(qmat(:,1)); hold on;
set(h,'Color', [bl, 0.5],'LineWidth',1.25);

h = plot(qmat(:,2));
set(h,'Color', [rd, 0.5],'LineWidth',1.25);

h = plot(qmat(:,3));
set(h,'Color', [gry, 0.5],'LineWidth',1.25);

h = plot(q_mavg,'-.');
set(h,'Color', [0.1,0.1,0.1,0.9],'LineWidth',1.5);

legend('Run1','Run2','Run3','Avg','Location','southeast');
xlabel('Time, t [sec]');
ylabel('Heat Flux, q [W/m2]');
grid on

end








