function plotData(x, y)
% PLOTDATA(x,y) Plots the data points x and y onto a new figure

% open a new figure window
figure; 
hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the temperature data (y) using the "plot" command. The
%               code provided is incorrect and needs to be fixed to match   
%               Fig. 2. 
%
%               Then set the axes labels using the "xlabel" and "ylabel" 
%               commands. 
%
% Hint: Pay close attention to the indices.


% plot first three T/Cs -- Hint: make sure each statement is correct!
plot(x(2:4),y(1:3),'ko-','MarkerSize', 8);

% plot middle two T/Cs
plot(x,y,'b','MarkerSize', 2);

% plot last three T/Cs
plot(x(6:8),y(6:8),'ko-','MarkerSize', 8);

% set labels & axis limits
xlabel();
ylabel('Temperature [C]');

% ============================================================

xlim([0 120])
ylim([0 110])
hold off;
end
