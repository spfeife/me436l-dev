
%% PRINT TO SCREEN

sq_avg = sprintf('% 5.3f   [W/m2]', round(q_avg, 3));
sq_max = sprintf('% 5.3f   [W/m2]', round(q_max, 3));
sTi = sprintf('% 5.3f   [K]', round(Ti, 2));

sep = sprintf('% 5.3f', round(ep, 3));
sep_max = sprintf('% 5.3f', round(ep_max, 3));
sepub = sprintf('% 5.3f', round(ep_pub, 3));
serr = sprintf('%5.2f%%', round(err, 3));
serr2 = sprintf('%5.2f%%', round(err2, 3));

disp(' ')
cprintf('*black',['Matl:  ' stitle '\n']);

disp(' ')
cprintf('*black','Data: \n');
disp([' q_avg =  ' sq_avg])
disp([' q_max =  ' sq_max])
disp([' Tavg =  ' sTi])

disp(' ')
cprintf('*black','Emissivity: \n');

disp([' ep_pub =   ' sepub])
disp([' ep_calc =  ' sep])
disp([' ep_max =   ' sep_max])
disp(' ')
disp([' error =     ' serr])
disp([' error =     ' serr2])
disp(' ')