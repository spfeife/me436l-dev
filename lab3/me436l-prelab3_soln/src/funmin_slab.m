function y = funmin_slab(hb)

% run: x = fminsearch(@funmin,2200)

addpath('./lib');
addpath('./data');

global alfa h k 
global Ti Tinf

%% =================    SETUP    ==================
fname = 'brass_slab'; matl_type = 'Brass';
%fname = 'steel_slab'; matl_type = 'SS';


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
Lc_one_term = 0.01;
Lc_lcm = 0.005;

%hb = 2300;
%hs = 1800;

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
[z1, C1] = set_coeffients(Bi, 'slab');

% compute one-term approximation
T1 = one_term(t, Lc_one_term, z1, C1);

% compute LCM
[T_lcm, Bi_lcm] = lcm(t, Lc_lcm);

%% PLOTTING
%plot_data(t,T, T_lcm, T1, titl);
T = T(5:end);
T1 = T1(5:end);
T_lcm = T_lcm(5:end);

err1 = norm(T-T1)/norm(T);

err2 = norm(T-T_lcm)/norm(T);

y = sqrt(err1^2 + err2^2);



