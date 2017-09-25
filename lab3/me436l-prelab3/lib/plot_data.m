function  [] = plot_data(t,T, T_lcm, T1, titl)
% PLOT_DATA: simple plotting function for simplicity

% set colors
[bl, rd, ~, gry] = set_colors();

figure;
h1 = plot(t, T,'o');
set(h1,'Color',gry,'MarkerSize', 6);

xlabel('Time, t');
ylabel('Temperature, [C]');
title(titl,'FontSize',20);
hold on

h1 = plot(t, T_lcm);
set(h1,'Color',rd,'LineStyle','-','LineWidth',2.0);

h1 = plot(t, T1);
set(h1,'Color',bl,'LineStyle','-','LineWidth',2.0);

xlim([0,175])
ylim([20,65])
grid on
legend('Experimental','LCM', 'One-Term Approx' , 'Location','Southeast')

end


