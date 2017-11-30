function [ ] = plot_q(qmat, stitle)
% PLOT_FULL - simple plotting function
% plot transient q data

global IF_PRINT_FIGS;

% new figure
figure; 
hold on;

q_mavg = movmean(mean(qmat,2),10);      % [W/m^2]

bl = [0 0.445 0.738];           % parula blue
rd = [0.62891 0 0.12109];       % parula red
gry = [0.3 0.3 0.3];

h = plot(qmat(:,1)); hold on;
set(h,'Color', [bl, 0.5],'LineWidth',1.5);

h = plot(qmat(:,2));
set(h,'Color', [rd, 0.5],'LineWidth',1.5);

h = plot(qmat(:,3));
set(h,'Color', [gry, 0.5],'LineWidth',1.5);

h = plot(q_mavg,'-.');
set(h,'Color', [0.1,0.1,0.1,0.9],'LineWidth',1.5);

title(stitle)

legend('Run1','Run2','Run3','Avg','Location','southeast');
xlabel('Time, t [sec]');
ylabel('Heat Flux, q [W/m2]');
grid on
hold off

% print plot
if IF_PRINT_FIGS

    % make sure 'figs' folder exists
    if ~exist('figs','dir'),  mkdir('figs'); end
    
    str_print = 'figs/plot_q';

    % print figs
    if ispc  % if windows
        print(str_print, '-dtiff','-r150');
    else
        print(str_print, '-dpng','-r150');
    end
end

end