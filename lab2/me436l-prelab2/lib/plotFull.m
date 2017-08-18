function [m,xv,yv] = plotFull(x,Tm)

% new figure
figure; 
hold on;

[m,xv,yv] = setRegression(x,Tm);

% set colors 
[bl, rd, org, gry] = setColors();

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

