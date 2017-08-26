function plotData(x, y)
% PLOTDATA(x,y) Plots the data points x and y onto a new figure. This
% function is identical to the 'plotData.m' from the Lab0 tutorial.

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the temperature data (y) using the "plot" command. The
%               code provided is incorrect and needs to be fixed to match   
%               Fig. 2. 
%
%               Then set the axes labels using the "xlabel" and "ylabel" 
%               commands. 
%
% Hint: Pay close attention to the indices.

% open a new figure window
figure; 
hold on;

% plot first three T/Cs
plot(x(2:4),y(1:3),'ko-','MarkerSize', 8);

% plot middle two T/Cs
% ====================== YOUR CODE HERE ======================

% plot last three T/Cs
% ====================== YOUR CODE HERE ======================


% set labels & axis limits
% ====================== YOUR CODE HERE ======================
xlabel('');
ylabel('');

% add axis limits
xlim([0 120])
ylim([0 110])
hold off;
end
