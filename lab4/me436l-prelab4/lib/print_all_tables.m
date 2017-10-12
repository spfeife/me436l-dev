
% set row names
row_names = {'20 mph','30 mph','40 mph','50 mph'};

% print heat rate
descr = 'Heat Transfer rate:';
var_names = {'Pin','qconv', 'qrad','qcond'};
print_table(T1, descr, row_names, var_names, 'heat_rate');

% Pct loss per HT mode
descr = 'Percentage loss by heat transfer mode:';
var_names = {'conv','rad','cond','totalLosses'};

for ii = 1:4
    a(:,ii) = cellstr(num2str(T2(:,ii)*100,'%5.2f%%'));
end

print_table(a, descr, row_names, var_names, 'pct_loss');

% Hilpert Correlation
descr = 'Hilpert Correlation:';
var_names = {'h','Nu','Re','Pr'};
print_table(Th, descr, row_names, var_names, 'hilpert');

% Zuk Correlation
descr = 'Zukauskas Correlation:';
print_table(Tz, descr, row_names, var_names, 'zuk');

% CB Correlation
descr = 'Churchill-Bernstein Correlation:';
print_table(Tc, descr, row_names, var_names, 'CB');


% Pct error per correlation
for ii = 1:3
    b(:,ii) = cellstr(num2str(Te(:,ii)*100,'%5.2f%%'));
end

descr = 'Percent Error:';
var_names = {'hExp','Hil','Zuk','CB'};

T = table; T.hExp = round(h_exp',2); T.Hilpert = b(:,1);
T.Zukauskas = b(:,2); T.CB = b(:,3);
print_table(T, descr, row_names, var_names, 'pct_error');

% H Exp + delta
if delta(1) ~= 0
    T = table; T.hExp = h_exp'; T.Uncertainty = delta';
    descr = 'Uncertainty';
    var_names = {'hExp','Delta'};
    print_table(T, descr, row_names, var_names, 'uncertainty');
end