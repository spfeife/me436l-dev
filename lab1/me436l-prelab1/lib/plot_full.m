function [m,xv,yv] = plot_full(x,Tm)
% PLOT_FULL - simple plotting function: Plots data, adds regression and
% other aesthetics 
%
% DESCR: This function essentially hides some of the complexity involved in
% making the plot for the Lab 1: Linear Conduction experiment
%
% Syntax:  [m,xv,yv] = plot_full(x,Tm)
%
% Inputs:
%    x  - Position vector
%    Tm - Temperature vector (mean)
%
% Outputs:
%    m  - Slope of regression line
%    xv - Regression (x-value)
%    yv - Regression (y-value)
%
%% MAIN

% new figure
figure; 
hold on;

% calculate regression
[m,xv,yv] = set_regression(x,Tm);

% set plotting colors 
[bl, rd, org, gry] = set_colors();

% plot regression
h(1) = plot(x,Tm,'ko','MarkerSize', 8);
h(2) = plot(xv(:,1),yv(:,1),'Color', rd, 'LineStyle', '-', 'LineWidth',1.5);
h(3) = plot(xv(:,2),yv(:,2),'Color', org, 'LineStyle', '-', 'LineWidth',1.5);
h(4) = plot(xv(:,3),yv(:,3),'Color', bl, 'LineStyle', '-', 'LineWidth',1.5);

% add slope to plot
str_m1 = sprintf('% 5.3f', round(m(1), 3));
str_m2 = sprintf('% 5.3f', round(m(2), 3));
str_m3 = sprintf('% 5.3f', round(m(3), 3));
text(median(xv(:,1)),max(Tm), ['m= ' str_m1], 'Color',rd,'FontSize',14)
text(median(xv(:,2)),Tm(4), ['m= ' str_m2], 'Color',org,'FontSize',14)
text(median(xv(:,3)),Tm(6), ['m= ' str_m3], 'Color',bl,'FontSize',14)

% labels
xlabel('T/C Position [mm]');
ylabel('Temperature [C]');
title('Steady Data, T/C','FontSize',16);
grid on

% add vertical lines for clarity
y = get(gca,'ylim');
plot([45 45],y,'--',[75 75], y, '--', 'Color', gry )

% legend
legend(h,'data','Heated','Specimen','Cooled'); hold off

