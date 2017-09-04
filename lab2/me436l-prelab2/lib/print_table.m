function Tbl = print_table(A, varargin)
% PRINT_TABLE - loads & prints table to command window
%
% Note: if IF_PRINT_TABLES is set, then this will print to csv
%
% Syntax:  [Tbl] = print_table(T, descr, row_names, var_names, varargin)
%
% Inputs:
%    A - Array of variables (from set_array) 
%    descr      - (string) to be printed before table
%    row_names  - (Cell of strings)
%    col_names  - (Cell of strings)
%    file_name  - if print to csv, output filename
%
% Outputs:
%    Tbl - optional
%
% Examples:
%   descr = 'Zukauskas Correlation:';
%   row_names = {'20 mph','30 mph','40 mph','50 mph'};
%   var_names = {'h','Nu','Re','Pr'};
%   file_name = 'file_name'
%
%% SETUP

global IF_PRINT_TABLES;

% defaults
descr = ''; row_names = []; col_names = [];
set_descr = 1;

% get size
[r,c] = size(A);

if nargin >= 2
    for ii = 1:length(varargin)
        tmp = varargin{ii};
        
        % set description
        if ischar(tmp) && ~strcmpi(descr, tmp)
            if set_descr, descr = tmp; end
            set_descr = 0;

        % row names
        elseif iscell(tmp) && length(tmp) == r && isempty(row_names)
            row_names = tmp;

        % column names
        elseif iscell(tmp) && length(tmp) == c && isempty(col_names)
            col_names = tmp;
        end    
    end
end

% if printing table, set name
if IF_PRINT_TABLES, fname = varargin{end}; end

%% MAIN

% convert array to table
if ~isa(A,'table')
    Tbl = array2table(A);
else
    Tbl = A;
end

% set properties, if available
Tbl.Properties.Description = descr;
if ~isempty(row_names), Tbl.Properties.RowNames = row_names; end
if ~isempty(col_names), Tbl.Properties.VariableNames = col_names; end

% print to screen
disp(' ')
fprintf([ '<strong>' Tbl.Properties.Description '</strong>\n'])
disp(' ')
disp(Tbl)
disp(' ')

%% PRINT TABLE TO CSV

% write table to excel
if IF_PRINT_TABLES

    % make sure output folder exists
    if ~exist('output','dir'),  mkdir('output'); end
    
    % write to file
    writetable(Tbl,['output/' fname '.csv'],'Delimiter',',')
end




