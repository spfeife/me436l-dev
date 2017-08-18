function  [C, rmin, no] = preloader(fname)
% PRELOADER - Loads excel data and performs sanity checks.
%
% Syntax:  [C, rmin, no] = preloader(fname)
%
% Inputs:
%    fname - filename, syntax: 'heat_flux.xlsx'
%
% Outputs:
%    C    - Cell of raw data
%    rmin - minimum number of rows in each tab of the excel sheet
%    no   - number of sheets in excel sheet 
%
%#ok<*AGROW>
%%

fprintf('Loading data... \n');

% get excel sheet info
[~,sheets,~] = xlsfinfo(fname);

% get no of sheets in excel sheet
no = length(sheets);

% create datastructure
C = cell(1, no);

% loop over number of sheets
for ii = 1:no
    [raw, ~] = xlsread(fname,ii);
    [r(ii), ~] = size(raw);

    % store in cell
    C{ii} = raw;

    if r(ii) < 70
        error('Number of Rows < 70! - CHECK DATA!');
    end
    
    if r(ii) < 90
        warning('Number of Rows < 90! - This may not be enough data!');
    end

end

% get minimum number of rows
rmin = min(r);

% cut down each dataset to rmin number of rows
for ii = 1:no
    C{ii} = C{ii}(1:rmin,:);
end

fprintf('Done. \n\n');
end




