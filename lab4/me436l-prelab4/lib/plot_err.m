%% PLOTTING
% Short plotting script

% title
str_print = 'error';
[bl, rd, org, gry] = set_colors();

% plot error
figure;
h = plot(v_mph, err_hil*100,'s-.'); hold on
set(h,'Color', bl, 'MarkerSize',10, 'LineWidth',1.25);
h = plot(v_mph, err_zuk*100,'v-.');
set(h,'Color', rd, 'MarkerSize',10, 'LineWidth',1.25);

h = plot(v_mph, err_church*100,'>-.');
set(h,'Color', org, 'MarkerSize',10, 'LineWidth',1.25);

xlabel('Velocity [mph]');
ylabel('% error');
title('Error','FontSize',20);
legend('Hilpert' ,'Churchill-Bernstein', 'Location','Northwest')
legend('Hilpert','Zukauskas', 'Churchill-Bernstein', 'Location','Northwest')
grid on
hold off
%ylim([0 10])


% print figs
if ispc  % if windows
    print(['figs/' str_print], '-dtiff','-r150');
else
    print(['figs/' str_print], '-dpng','-r150');
end
