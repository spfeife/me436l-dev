%% PLOT_HEAT_FLUX
%
% Script to plot the heat flux (simplifies main code)
%
%%

global IF_PRINT_FIGS;

% set colors
[bl, rd, ~, gry] = set_colors();

% open figure
figure;

% plot collected data
h1 = plot(L,q); hold on;
set(h1,'Color', [bl,0.3]);

% scatter function provides more options
s1 = scatter(L,q,100,'^','MarkerFaceAlpha',0.6, ...
    'MarkerFaceColor',h1.Color,'MarkerEdgeColor',h1.Color);

% plot calculated data
h2 = plot(L,qc); hold on;
set(h2,'Color', [rd,0.3]);
s2 = scatter(L,qc,100,'s','MarkerFaceAlpha',0.4, ...
    'MarkerFaceColor',h2.Color,'MarkerEdgeColor',h2.Color);

% Create PowerLaw Fit
[xData, yData] = prepareCurveData( L, q );
ft = fittype( 'power1' ); opts = fitoptions( 'Method', 'NonlinearLeastSquares' ); 
opts.Display = 'Off'; opts.StartPoint = [18.6 -1.8];
[fitresult, gof] = fit( xData, yData, ft, opts );
p = coeffvalues(fitresult);

% plot fit
x = linspace(L(1),L(end),100);
f = p(1)*x.^p(2);
h = plot(x, f,'k--','LineWidth',1.5);

% legend/labels
l = legend([s1,s2,h],'Measured','Calc','fit');
set(l,'FontSize', 14);
ylim([0 450])
title('Heat Flux vs. Distance', 'FontSize', 18);
xlabel('Distance, L [m]');
ylabel('Heat Flux, q [W/m2]');
grid on

hold off;

%% PRINT FIGs

% print plot
if IF_PRINT_FIGS

    % make sure 'figs' folder exists
    if ~exist('figs','dir'),  mkdir('figs'); end
    
    str_print = 'figs/heat_flux_distance';

    % print figs
    if ispc  % if windows
        print(str_print, '-dtiff','-r150');
    else
        print(str_print, '-dpng','-r150');
    end
end
