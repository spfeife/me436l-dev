function  [] = plot_fo(Fo, theta_star)
% PLOT_DATA: simple plotting function

% set colors
[~, rd, ~, gry] = setColors();

figure;
h1 = plot(Fo, theta_star,'o');hold on
set(h1,'Color',gry,'MarkerSize', 6);

xlabel('Fo, [-]');
ylabel('theta, [-]');
title('Dimensionless Data','FontSize',20);

h1 = plot(Fo, theta_star);
set(h1,'Color',rd,'LineStyle','-','LineWidth',1.0);
grid on

ylim([0,1.2])
x1 = 0.2;

% set line at 0.2
y1=get(gca,'ylim');
hold on
plot([x1 x1],y1,'Color','k','LineStyle','--','LineWidth',2.0)

hold off
end


