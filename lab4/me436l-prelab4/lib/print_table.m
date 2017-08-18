function Tbl = print_table(T, descr, row_names, var_names, varargin)

% convert to table
if ~isa(T,'table')
    Tbl = array2table(T);
else
    Tbl = T;
end

Tbl.Properties.Description = descr;
Tbl.Properties.RowNames = row_names;
Tbl.Properties.VariableNames = var_names;


% print to screen
disp(' ')
fprintf([ '<strong>' Tbl.Properties.Description '</strong>\n'])
disp(' ')
disp(Tbl)
disp(' ')

% write table to excel
if (ischar(varargin{end}))
    writetable(Tbl,['output/' varargin{end} '.csv'],'Delimiter',',')
end