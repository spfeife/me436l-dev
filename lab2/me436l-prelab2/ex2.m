%% ME 436L Heat Transfer
% Lab 2 | Extended Surfaces
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
fprintf('<strong>                Lab 2: Extended Surfaces               </strong>\n')
disp(' --------------------------------------------------------')
disp(' ')

%% SETUP

% set path to folder containing excel sheets
pDIR = './data';

% grab all excel files in directory
xl_files = dir( [pDIR '/*.xlsx']);
NX = length(xl_files);

% Data Info (Spring 2017)
% s1/s2 - Natural Convection (h=9)
% s3/s4 - Low Forced (h = 30)
% s5/s6 - High Forced (h = 40)

% plot title
titles{1,1} = 'Temperature Distribution: h = 9 [W/m^2 C]';
titles{1,2} = 'Temperature Distribution: h = 30 [W/m^2 C]';
titles{1,3} = 'Temperature Distribution: h = 40 [W/m^2 C]';

% export figure name
str_print{1,1} = 'h_09';
str_print{1,2} = 'h_30';
str_print{1,3} = 'h_40';

% set station numbers for each dataset
st = {'1';'3';'5';};

%% =========== Part 1: Input Properties ============= 
% From the procedures document, fill in all of the necessary info

fprintf(['<strong>' 'PART 0:' '</strong>'])
fprintf(' Set Properties. \n');

% set globals
global D k P L Ac Af T_inf

% x vec for plotting
xe = 0:0.05:0.35;            % (Position - experiment) [m]
x = linspace(0,0.35,200);    % (Position - theory) [m]

% Fin Properties **FIX ME**
h = [9, 30, 40];             % [W/m^2 C]
D = 1;                       % (Diameter) [m]
k = 400;                     % (Conductivity, Brass) [W/m C]
P = pi * D;                  % (Perimeter) [m]
L = 1;                       % (Length of fin) [m]
Ac = 1;                      % (Cross Sectional Area) [m^2]
Af = pi * D * L;             % (Fin Surface Area) [m^2]

% Set Tinf -- as measured in lab
T_inf = 23.5;     % [C]

disp(' ');
cprintf('comments', '>> DONE.\n');

% break
break_msg; dbstack; return;

%% =========== Part 2: Loop over data & Plot ============= 

% loop over stations
for ii = 1:3 
    
    % load data
    raw = xlsread([pDIR '/' xl_files(ii).name]);
    
    % get time vector
    t = raw(:,1);       % [s]
    
    % get temps
    dat = raw(:,2:9);           % [C]
    
    % get voltage/current
    V = raw(:,11);        % [V]
    I = raw(:,12);        % [A]
    
    % take average of last N points (~20)
    N = 20;
    Tm = mean(dat(end-N:end,:));
    Vm = mean(V(end-N:end));
    Im = mean(I(end-N:end));
    
    % set T_base
    Tb = Tm(1);        % [C]
    
    % determine power input
    PWR(ii) = Vm * Im;
    
    % The fin excess temperatures
    theta_x = Tm - T_inf;
    theta_b = Tb - T_inf;
    
    % m & M
    M = sqrt((h(ii) * P * k * Ac)) * theta_b;
    m = ((h(ii) * P) / (k * Ac))^0.5;
    mL = m * L;
    h_mk = h(ii)/(m*k);
    
    % Case A
    [TA, qA(ii)] = caseA(x, theta_b, m, M, h(ii));

    % Case B
    [TB, qB(ii)] = caseB(x, theta_b, m, M);

    % Case D
    [TD, qD(ii)] = caseD(x, theta_b, m, M);
    
    % efficiency (eta)
    eta_A(ii) = calc_eta(qA(ii), theta_b, h(ii));
    eta_B(ii) = calc_eta(qB(ii), theta_b, h(ii));
    eta_D(ii) = calc_eta(qD(ii), theta_b, h(ii));
    
    % effectiveness (epsilon)
    ep_A(ii) = calc_epsilon(qA(ii), theta_b, h(ii));
    ep_B(ii) = calc_epsilon(qB(ii), theta_b, h(ii));
    ep_D(ii) = calc_epsilon(qD(ii), theta_b, h(ii));

    % calculate error (percent)
    p_error_A(ii) = abs(PWR(ii) - qA(ii))/PWR(ii) * 100;
    p_error_B(ii) = abs(PWR(ii) - qB(ii))/PWR(ii) * 100;
    p_error_D(ii) = abs(PWR(ii) - qD(ii))/PWR(ii) * 100;
    
    %% PLOTTING

    [bl, rd, org, gry] = setColors();

    figure;
    plot(xe,Tm,'ko','MarkerSize', 7,'MarkerFaceColor','k');
    hold on;
    
    hp = plot(x,TA);
    set(hp,'Color',bl,'LineStyle','--','LineWidth',2);
    
    hp = plot(x,TB);
    set(hp,'Color',rd,'LineStyle','-.','LineWidth',2);
    
    
    hp = plot(x,TD);
    set(hp,'Color',org,'LineStyle','-','LineWidth',2);
    
    
    % add labels
    xlabel('T/C Position [m]');
    ylabel('Temperature [C]');
    title(titles{1,ii},'FontSize',18);
    legend('data','case A', 'case B','case D')
    grid on
    
    % limits
    xlim([0 0.35]);
    ylim([20 65]);
    hold off
    
    % print figs
    %print(['figs/' str_print{1,ii}], '-dpng','-r200');
    
end


%% OUTPUT

% heat rate
qAs = round(qA,3);
qBs = round(qB,3);
qDs = round(qD,3);
Pin = round(PWR,3);
Tq = table(st,Pin',qAs',qBs',qDs','VariableNames',{'Station';'Pin';'qA';'qB';'qD'});


% error
peA = round(p_error_A,3);
peB = round(p_error_B,3);
peD = round(p_error_D,3);
Pin = round(PWR,3);
Te = table(st,peA',peB',peD','VariableNames',{'Station';'qA';'qB';'qD'});


% efficiency
eA = round(eta_A,3);
eB = round(eta_B,3);
eD = round(eta_D,3);
Teta = table(st,eA',eB',eD','VariableNames',{'Station';'CaseA';'CaseB';'CaseD'});

% effectiveness
eA = round(ep_A,3);
eB = round(ep_B,3);
eD = round(ep_D,3);
Tep = table(st,eA',eB',eD','VariableNames',{'Station';'CaseA';'CaseB';'CaseD'});



%% PRINT to SCREEN

disp(' ')
disp( ' Heat Rate [W]:')
disp(' ')
disp(Tq)

disp(' ')
disp( ' Error [%]:')
disp(' ')
disp(Te)

disp(' ')
disp( ' Efficiency [%]:')
disp(' ')
disp(Teta)

disp(' ')
disp( ' Effectiveness [-]:')
disp(' ')
disp(Tep)



