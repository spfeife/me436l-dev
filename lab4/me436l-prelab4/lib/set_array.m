function [T] = set_array(varargin)

% is filename a char
if (ischar(varargin{end-1}))
    rnd = varargin{end};
    idx = 2;
else
    rnd = 2;
    idx = 0;
end

% preallocate
T = zeros(1,nargin-idx);

% set table array
for jj = 1:nargin-idx
    T(1,jj) = round(varargin{jj}, rnd);
end

end

