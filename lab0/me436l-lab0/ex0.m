%% ME 436L Heat Transfer
% Lab 0 | MATLAB Tutorial
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
%
%  You will only need to comment out the 'return' command at the end of 
%  each section. Otherwise, you will NOT need to change any code in this 
%  file, only those mentioned above.
%
%#ok<*UNRCH>

%% Initialization
clear ; close all; clc
addpath('./lib');
raw = [];

disp(' ')
disp(' --------------------------------------------------------')
disp('                Lab 0: PLOTTING                ')
disp(' --------------------------------------------------------')
disp(' ')

%% LOAD DATA
%  We start by first loading a sample dataset
fprintf('Loading data... \n');

% load tab separated data - see assignment sheet for column info
M = load('data.txt'); 

fprintf('Done. \n\n'); 

% COMMENT ME OUT!!
break_msg; dbstack; return;


% extract time vector
t = M(:,1);           % [s]

% get temps
dat = M(:,2:9);       % [C]

% get voltage/current
V = M(:,10);          % [V]
I = M(:,11);          % [A]

% remove break
break_msg; dbstack; return;

%% =========== Part 0: Warm Up / Systems Check ============= 
% The data has been loaded and separated. Now, let's visualize it
% and make sure the data is at steady-state. If you experience troubles
% completing this section, you may have an outdated version of matlab.

% open figure and plot data
fprintf('PART 0: Plot Data... \n');
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

cprintf('*comments', '>> DONE.');
fprintf('  No deliverable for this exercise.\n\n\n');

%% =========== Part 1a: Visualize SS Data ============= 
%  Now, we start our first exercise by visualizing the steady-state
%  Temperature data for each T/C. You will need to complete `plotData.m' 
%  before continuing

fprintf('PART 1: Visualize SS Data...\n\n');

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
fprintf('Program exited. Uncomment this line to continue. \n'); dbstack; return;

%% =========== Part 1b: Add Regression Lines ============= 
% Now, let's clean up our plot a little bit by:
%   - Adding regression lines
%   - Adding slopes to our lines
%
% NOTE: IF you did everything correctly above, you should not need to complete 
%       anything here.

% compute regression & slopes
[m,xv,yv] = setRegression(x,Tm);

% plot with regression lines
plotFull(x,Tm);

cprintf('*comments', '>> DONE.\n');
cprintf('*keyword', '>> Deliverable: Check prelab assignment! \n\n\n');








