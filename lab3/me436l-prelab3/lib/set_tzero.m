function [T, t] = set_tzero(raw)
% SET_TZERO: Takes the raw data and shifts everything to start at t = 0

    % set vars
    t = raw(:,1);
    T = raw(:,4);
    
    % shift time based on start point
    [~,I] = max(diff(raw(:,3)));
    tshift = t(I);
    
    % truncate time vec to start at 0
    t = t-tshift;       % [s]
    t(1:I-1) = [];      % [s]
    T(1:I-1) = [];      % [C]
    
end

