%% PLOTTING
% Short plotting script

% title
str_print = 'pct_mode';
[bl, rd, org, gry] = set_colors();

% plot percent loss by mode
figure;
y = [pct_cond', pct_conv', pct_rad'].*100;
b = bar(v_mph, y); hold on

b(3).FaceColor = bl;
b(1).FaceColor = rd;
b(2).FaceColor = org;

xlabel('Velocity [mph]');
ylabel('% HT Loss');
title('HT Mode Comparison','FontSize',20);
l = legend('Conduction','Convection', 'Radiation', 'Location','Southoutside');
set(l,'Orientation','horizontal','Location','southoutside');

y1 = 0:0.05:0.15;
y2 = 0.20:0.1:1.0;
yticks([y1 y2].*100)

ytickformat('percentage')

grid on
hold off

% print figs
if ispc  % if windows
    print(['figs/' str_print], '-dtiff','-r150');
else
    print(['figs/' str_print], '-dpng','-r150');
end
