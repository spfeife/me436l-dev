function [z1, C1] = set_coeffients(Bi,str)
% SET_COEFFIENTS: find C1 & z1, use table 5.1 as guess
%   -- change index for shape

s1 = lower(str);
if strcmp(s1,'slab')
    ind = 2;
elseif strcmp(s1,'cylinder')
    ind = 4;
elseif strcmp(s1,'sphere')
    ind = 6;
end

% load table 5.1
tbl = xlsread('table5.1.xlsx');


% find C1 & z1, use table 5.1 as guess -- change index for shape
l1 = tbl(:,1);
a = length(l1(l1<Bi));

z1 = interp1([tbl(a,1), tbl(a+1,1)],[tbl(a,ind), tbl(a+1,ind)],Bi);
C1 = interp1([tbl(a,1), tbl(a+1,1)],[tbl(a,ind+1), tbl(a+1,ind+1)],Bi);



%f = fit(Fo,theta_star,'exp1','StartPoint',[C1,z1^2]);
end