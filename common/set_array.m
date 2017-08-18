function [A] = set_array(varargin)
% PRINT_TABLE - simple function that rounds-off values before filling an
% array.
%
% DESCR: This is used inconjunction with PRINT_TABLE and is simply used to
% save space & round-off values.
%
% Syntax:  [A] = set_array(Var1,Var2, ... , VarN);
%
%   OR     [A] = set_array(Var1,Var2, ... , VarN, 'round', n);
%
%   This last syntax will round each varable to n decimal places
%
% Default Round: round(var, 2)
%
% Inputs:
%    Var1 - variable 1
%    Var2 - variable 2
%      .
%      .
%    VarN - variable N
%    str  - 'round' -- if this variable is a 'char' then the above values
%                      will be rounded & next argument the number of places
%     n   - (Last Arg) number of decimals in which to round.
%
% Outputs:
%    A - Array (matrix)
%
%% SETUP
% Default round value
rnd = 2;

% No. of arguments (from end) to ignore.
idx = 0;

% If 2nd to last variable is a char
if (ischar(varargin{end-1}))
    rnd = varargin{end};
    idx = 2;
end

% check if variable is a scalar or an array
n = length(varargin{1});

% preallocate
A = zeros(n, nargin-idx);

% set table array
for jj = 1:nargin-idx
    A(:,jj) = round(varargin{jj}, rnd);
end




end



