%% PLOT BARGRAPH
figure; hold on;

% set colors
[bl, rd, org, gry] = set_colors();
wht = [1,1,1];

% set y values
y = [q_rad(1), q_conv(1);q_rad(2), q_conv(2); q_rad(3), q_conv(3)];

% plot, set bar colors
b = bar(y); b(1).FaceColor = rd; b(2).FaceColor = bl;

% labels
xlabh = get(gca,'XLabel');
set(xlabh,'Position',get(xlabh,'Position') - [0 0.5 0])
set(gca,'XTick', 1:3,'XTickLabel',{'Free Convection','Med-Forced','High-Forced'})
ylabel('Power [W]');
title('Heat Transfer Rate, q [W]','FontSize',20);
legend('Radiation', 'Convection','Location','northwest')
grid on
%ylim([0 2]);
hold off;
