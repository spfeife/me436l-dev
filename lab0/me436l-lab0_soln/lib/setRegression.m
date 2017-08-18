function [m,xv,yv] = setRegression(x,Tm)

m = zeros(1,3);
xv = zeros(100,3);
yv = zeros(100,3);

% add regression line & get slopes
[m(1),xv(:,1),yv(:,1)] = get_slope(x(1:3),Tm(1:3));
[m(2),xv(:,2),yv(:,2)] = get_slope(x(4:5),Tm(4:5));
[m(3),xv(:,3),yv(:,3)] = get_slope(x(6:8),Tm(6:8));

end










