function [bl, rd, org, gry, clr] = setColors()

% plotting colors
clr = [0 114 189; ...     % parula blue
    161 00   31;   ...    % parula red
    217 83  25;  ...      % parula orange
    106 81 163; ...       % parula purple
    100 100 100]./256;    % gray

bl = [0 114 189]./256;      % parula blue
rd = [161 0 31]./256;       % parula red
org = [217 83 25]./256;     % parula orange
gry = [100 100 100]./256;

end
