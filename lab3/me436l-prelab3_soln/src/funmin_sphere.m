function y = funmin_sphere(hs)

% run: x = fminsearch(@funmin,2200)

addpath('./lib');
addpath('./data');

global alfa h k 
global Ti Tinf

%% =================    SETUP    ==================
%fname = 'brass_sphere'; matl_type = 'Brass';
fname = 'steel_sphere'; matl_type = 'SS';


%% =================    PROPERTIES    ==================
% From the procedures document and the textbook, fill in all of the
% necessary info

% diffusivity
alfa_b = 0.000037;
alfa_ss = 0.000006;

% thermal conductivity
kb = 121;
ks = 25;

% characteristic length scales
Lc_one_term = 0.0225;
Lc_lcm = 0.0075;

%hb = 2500;
%hs = 1200;

%% ==================================================

% based on input, set properties
s1 = lower(matl_type);
if strcmp(s1,'brass')
    alfa = alfa_b;
    k = kb;
    h = hb;
    titl = 'Thermal Response, Brass Cylinder';
elseif strcmp(s1,'ss')
    alfa = alfa_ss;
    k = ks;
    h = hs;
    titl = 'Thermal Response, SS Cylinder';
end

%% Calculations

% load data
raw = xlsread(fname);

% truncate t & T to start at 0
[T, t] = set_tzero(raw);

% extract Tinf & Ti
Tinf = mean(T(end-20:end));
Ti = T(1);

% estimate Bi (one-term approx)
Bi = (h * Lc_one_term)/k;

% find coefficients C1 & z1 from table 5.1
[z1, C1] = set_coeffients(Bi, 'sphere');

% compute one-term approximation
T1 = one_term(t, Lc_one_term, z1, C1);

% compute LCM
[T_lcm, Bi_lcm] = lcm(t, Lc_lcm);

%% PLOTTING
%plot_data(t,T, T_lcm, T1, titl);
T = T(1:end);
T1 = T1(1:end);
T_lcm = T_lcm(1:end);

err1 = norm(T-T1)/norm(T);

err2 = norm(T-T_lcm)/norm(T);

y = sqrt(err2^2);



