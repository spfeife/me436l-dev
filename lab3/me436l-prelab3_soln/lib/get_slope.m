function [varargout] = get_slope(xl,yl,varargin)
% GET_SLOPE  Finds slope of line using poly1 fit
%
% General Context:
%       m = get_slope(xl,yl);
%
% If plotting 
%       [m,xh,yh] = get_slope(xl,yl);
%
% Input:
%       xl, yl : line segment to take slope (vectors)
%
% Output:
%       m: slope of line
%       xh,yh: interpolated line with slight overhang, see below.
%
%
% Written By:    SP
% Last Update:   8/31/16
%% MAIN

% if an x-range is given, truncate xl, yl
if nargin >= 3
    rng = varargin{1};
    
    % make sure all vectors are columns
    if ~iscolumn(xl), xl = xl'; end
    if ~iscolumn(yl), yl = yl'; end
    if ~iscolumn(rng), rng = rng'; end
    
    % find
    k = dsearchn(xl,rng);
    
    % truncate xl,yl
    xls = xl(k(1):k(2));
    yls = yl(k(1):k(2));
    
else
    xls = xl;
    yls = yl;
end

% set overhang (if any)
oh = 7.5;
%oh = 0;

% fit a 1st order polynomial to each dataset
[xData, yData] = prepareCurveData( xls, yls );ft = fittype( 'poly1' );
f = fit(xData, yData, ft);
p = coeffvalues(f);
xf = linspace(xls(1)-oh,xls(end)+oh,100);
m = p(1);
fn = p(1).*xf + p(2);

varargout{1} = m;
varargout{2} = xf;
varargout{3} = fn;
