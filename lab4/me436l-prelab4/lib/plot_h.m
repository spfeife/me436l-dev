%% PLOTTING
% Short plotting script

% title
str_print = 'conv_coeff';
[bl, rd, org, gry] = set_colors();

% plot h
figure;
h = plot(v_mph, h_exp,'o-'); hold on;
set(h,'Color', 'k' , 'MarkerFaceColor','k', 'MarkerSize',5, 'LineWidth',1.75);

h = plot(v_mph, h_hil,'s-.');
set(h,'Color', bl, 'MarkerSize',10, 'LineWidth',1.25);

h = plot(v_mph, h_zuk,'v-.');
set(h,'Color', rd, 'MarkerSize',10, 'LineWidth',1.25);

h = plot(v_mph, h_church,'>-.');
set(h,'Color', org, 'MarkerSize',10, 'LineWidth',1.25);


xlabel('Velocity [mph]');
ylabel('h [W/m2 K]');
title('Convection Coefficient','FontSize',20);
legend('Exp.', 'Hilpert','Zukauskas', 'Churchill-Bernstein', 'Location','Northwest')
grid on
hold off



% print figs
if ispc  % if windows
    print(['figs/' str_print], '-dtiff','-r150');
else
    print(['figs/' str_print], '-dpng','-r150');
end
