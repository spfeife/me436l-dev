%% PLOTTING

[bl, rd, org, gry] = set_colors();

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