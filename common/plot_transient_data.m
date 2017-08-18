function plot_transient_data(qmat)
% PLOTQ - plot transient q data

global IF_PRINT_FIGS;

% open figure
figure;

% plot q matrix
h = plot(qmat);
set(h,'LineWidth', 2.0);

% titles & labels
title(' Heat Flux vs. Time', 'FontSize', 18)
l = legend('200mm','300mm','400mm','500mm','600mm','700mm', ...
    'Location','northwest');
set(l,'FontSize', 14);
xlabel('Time, t [sec]');
ylabel('Heat Flux, q [W/m2]');
grid on

%% PRINT FIG

% print plot to .png
if IF_PRINT_FIGS

    % make sure 'figs' folder exists
    if ~exist('figs','dir'),  mkdir('figs'); end
    
    % print fig
    print('figs/tranient_heat_flux', '-dpng','-r150');
end

