%% Lab 3: Transient Conduction: SPHERE Only
%   LAB3_SLAB: This script performs the calculations for the sphere
%
%% Description:
%   Performs calculations for both Brass and SS
%
%   Input:
%     Bi: This script requires the Biot number to be somewhat known before
%     running.  Use CFTOOL to find an exact Biot number.
%
%   Note: Make sure the data is good!
%
% Written By:    Spencer Pfeifer
% Last Update:   10/22/16

%#ok<*SAGROW>

%% BEGIN
clear; close all;

% Path to data & includes
addpath('./data')
%addpath('./includes')

%% Known Parameters

% diffusivity
alpha(1) = 0.000037;
alpha(2) = 0.000006;

% thermal conductivity
k(1) = 121;
k(2) = 25;

% colors
bl = [0 114 189]./256;      % parula blue
rd = [161 0 31]./256;       % parula red
org = [217 83 25]./256;     % parula orange
ppl = [106 81 163]./256;    % parula purple
gn = [24, 106, 59]./256;
gry = [0.3,0.3,0.3];

%% LOAD DATA

sheet{1} = 'brass_sphere';
sheet{2} = 'steel_sphere';
titl{1} = 'Thermal Response, Brass Sphere';
titl{2} = 'Thermal Response, SS Sphere';

% BIOT NUMBER
Bi(1) = 0.4545;
Bi(2) = 1.1223;


for ii = 2:2

    % load data
    raw = xlsread('raw_data.xlsx',sheet{ii});

    t = raw(:,1);
    
    % load table 5.1
    tbl = xlsread('table5.1.xlsx');
    
    %% Calculations
    
    % set T (sample)
    T = raw(:,4);
    
    % shift time based on start point
    [~,I] = max(diff(raw(:,3)));
    tshift = t(I);
    
    % truncate time vec to start at 0
    t = t-tshift;       % [s]
    t(1:I) = [];        % [s]
    T(1:I) = [];        % [C]

    % Extract Tinf & Ti
    Tinf = mean(T(end-20:end));
    Ti = T(1);
    
    % Set theta and Fo
    Lc = 0.0225;
    theta = (T - Tinf)/(Ti - Tinf);         %[-]
    Fo = (alpha(ii) * t)/Lc^2;              %[-]
    
    % calculate h
    h = k(ii)*Bi(ii)/Lc;

    % find C1 & z1, use table 5.1 as guess -- change index for shape
    l1 = tbl(:,1);
    a = length(l1(l1<Bi(ii)));
    x0 = tbl(a,6);

    z1 = interp1([tbl(a,1), tbl(a+1,1)],[tbl(a,6), tbl(a+1,6)],Bi(ii));
    C1 = interp1([tbl(a,1), tbl(a+1,1)],[tbl(a,7), tbl(a+1,7)],Bi(ii));

    % the coefficients do not fit the sphere well for SS
    if ii == 2
        z1 = z1 * 1.25;
        C1 = C1*0.9;
    end

    % find z1 (eq. 5.42c)
    %fun1 = @(x) x.*tan(x) - Bi(ii);
    %z1 = fzero(fun1, x0);
    
    % find C1 (eq. 5.42b)
    %C1 = (4 * sin(z1))/(2*z1 + sin(2*z1));
    
    % set temperatures
    theta_star = C1 .* exp( - z1.^2 .* Fo);
    T1 =  Tinf + (Ti - Tinf) * theta_star;            % [C] one-term approx
    
    Lc = 0.0075;
    Bi_lcm = h * Lc/k(ii);
    Fo = (alpha(ii) * t)/Lc^2;
    LCM = Tinf + (Ti - Tinf) * exp(-Bi_lcm .* Fo);        % [C] LCM
    
    %% PLOTTING
    figure;
    h1 = plot(t, T,'o');
    set(h1,'Color',gry,'MarkerSize',6);
    
    xlabel('Time, t');
    ylabel('Temperature, [C]');
    title(titl{ii},'FontSize',20);
    hold on
    
    h1 = plot(t, LCM);
    set(h1,'Color',rd,'LineStyle','-','LineWidth',2.0);
    
    h1 = plot(t, T1);
    set(h1,'Color',bl,'LineStyle','-','LineWidth',2.0);
    
    xlim([0,200])
    ylim([20,65])
    grid on
    legend('Experimental','LCM', 'One-Term Approx' , 'Location','Southeast')
    
    % Output Variables
    t_Tinf(ii) = round(Tinf, 2);
    t_Ti(ii) = round(Ti, 2);
    t_h(ii) = round(h, 2);
    t_z1(ii) = round(z1, 4);
    t_C1(ii) = round(C1, 4);
    t_Bi(ii) = round(Bi(ii), 3);
    t_Bi_lcm(ii) = round(Bi_lcm, 3);
end


%% PRINT to SCREEN
return
% load table
st = {'Brass';'SS';};
Tbl = table(st, t_Ti', t_Tinf', t_h', t_z1', t_C1', t_Bi',t_Bi_lcm', ...
    'VariableNames',{'Material';'Ti';'Tinf';'h';'z1';'C1';'Bi';'BiLcm'});

% print
disp(' ')
disp('              --------------------------------------------------------')
disp('                             Lab 3: Transient Conduction: SPHERE              ')
disp('              --------------------------------------------------------')
disp(' ')
disp(' ')

disp(Tbl)
disp(' ')