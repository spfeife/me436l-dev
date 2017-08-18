%% ME 436L Heat Transfer
% Lab 1 | Linear Heat Conduction
%
%  INSTRUCTIONS
%  ------------
%
%  This file contains code that will guide you through the assignment. Be 
%  sure to follow the instructions provided in the attached document.
%
%  NOTE: You will only need to complete the following functions:
%
%       plotData.m
%       calc_ks.m
%       fouriers_law.m
%       calc_contact_res.m
%
%  You will only need to comment out the 'return' command at the end of 
%  each section. Otherwise, you will NOT need to change any code in this 
%  file, only those mentioned above.
%
%#ok<*UNRCH>

%% Initialization
clear ; close all; clc
addpath('./lib');
addpath('./data');
raw = [];

disp(' ')
disp(' --------------------------------------------------------')
fprintf('<strong>                Lab 1: Linear Conduction               </strong>\n')
disp(' --------------------------------------------------------')
disp(' ')

%% LOAD DATA

%  We start by first loading a sample dataset
fprintf('Loading data... \n');

% load tab separated data into matrix M - see assignment sheet for column
% info
M = load('data.txt');

% Load from Excel (save this for later)
% M = xlsread('s1_raw.xlsx');

fprintf('Done. \n\n'); 

% extract time vector
t = M(:,1);           % [s]

% get temps
dat = M(:,2:9);       % [C]

% get voltage/current
V = M(:,10);          % [V]
I = M(:,11);          % [A]

%% =========== Part 0: Warm Up / Systems Check ============= 
% The data has been loaded and separated. Now, let's visualize it
% and make sure the data is at steady-state. If you experience troubles
% completing this section, you may have an outdated version of matlab.

fprintf(['<strong>' 'PART 0:' '</strong>'])
fprintf(' Plot Data... \n');

% open figure and plot data
figure;
h = plot(dat);
set(h, 'LineStyle', '-', 'LineWidth', 2)

% add labels
xlabel('Time [s]');
ylabel('Temperature [C]');
title('Transient Data, T/C','FontSize',16);
grid on

disp(' ');
fprintf('  CHECK: Is your plot correct?\n');
fprintf('  CHECK: Is your data at steady-state?\n\n');

% remove break
break_msg; dbstack; return;

cprintf('comments', '>> DONE.');
fprintf('  No deliverable for this exercise.\n\n\n');

%% =========== Part 1a: Visualize SS Data ============= 
%  Now, we start our first exercise by visualizing the steady-state
%  Temperature data for each T/C. You will need to complete `plotData.m' 
%  before continuing

fprintf(['<strong>' 'PART 1:' '</strong>'])
fprintf(' Visualize SS Data.\n\n');

% take an average of the last (~20) points 
N = 20;
Tm = mean(dat(end-N:end,:));      % [C]
Vm = mean(V(end-N:end));          % [V]
Im = mean(I(end-N:end));          % [A]

% set x-vector (position along apparatus)
x = 7.5:15:112.5;       % [mm]

% plot data
plotData(x, Tm);

fprintf('  CHECK: Does your plot match Fig. 2?\n\n')
break_msg; dbstack; return;

%% =========== Part 1b: Add Regression Lines ============= 
% Now, let's clean up our plot a little bit by:
%   - Adding regression lines
%   - Adding slopes to our lines
%
% NOTE: IF you did everything correctly above, you should not need to complete 
%       anything here.

% compute regression & slopes
[m,xv,yv] = set_regression(x,Tm);

% plot with regression lines
plot_full(x,Tm);

cprintf('*comments', '>> DONE.\n');
cprintf('*keyword', '>> Deliverable: Check prelab assignment! \n\n\n');

% remove break
break_msg; dbstack; return;

%% =========== Part 2: Calculate Sample k ============= 
% Now, we use the information above to calculate the sample thermal
% conductivity, ks.

fprintf(['<strong>' 'PART 2:' '</strong>'])
fprintf(' Calculate ks: \n\n');

% calculate ks
[ks] = calc_ks(m);

% print to screen
str_ks = sprintf('% 5.2f [W/mC]', round(ks, 3));
fprintf(['     ks:' str_ks '\n\n'])


cprintf('*comments', '>> DONE.\n');
cprintf('*keyword', '>> Check Deliverable. \n\n\n');

% remove break
break_msg; dbstack; return;

%% =========== Part 3: Calculate Heat Rate ============= 
% Next, we use Fourier's Law to calculate the heat rate, q, for each
% section.

fprintf(['<strong>' 'PART 3:' '</strong>'])
fprintf(' Heat Rate: \n\n');

% set derivatives from regression slopes
[q] = fouriers_law(ks, m);

% calculate power
P = Vm * Im;

% table for Heat Rate
P = round(P,2);
qh = round(q(1),2);
qm = round(q(2),2);
qc = round(q(3),2);

% print table to screen
fprintf('  q[W]: \n\n');
T = table(P,qh',qm',qc',...
    'VariableNames',{'Pin';'qh';'qs';'qc'});

disp(T)
fprintf(' \n')

cprintf('*comments', '>> DONE.\n');
cprintf('*keyword', '>> Check Deliverable. \n\n\n');

% remove break
break_msg; dbstack; return;

%% =========== Part 4: Calculate Contact Resistance ============= 
% Now we can calculate the contact resistance between each section

fprintf(['<strong>' 'PART 4:' '</strong>'])
fprintf(' Contact Resistance: \n\n');

dT(1) = min(yv(:,1))-max(yv(:,2));
dT(2) = min(yv(:,2))-max(yv(:,3));

% calculate contact resistance
[R1, R2] = calc_contact_res(dT, P);

% print to screen
str_R1 = sprintf('% 5.2e [m^2 C/W]', R1);
str_R2 = sprintf('% 5.2e [m^2 C/W]', R2);
fprintf(['    R1:' str_R1 '\n'])
fprintf(['    R2:' str_R2 '\n\n'])

cprintf('*comments', '>> DONE.\n');
cprintf('*keyword', '>> Check Deliverable. \n\n\n');









