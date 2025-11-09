% Load the raw table
S = load('wind_coeff.mat');          % adjust the field name if needed
T_wind = S.wind_coeff;                    % [alpha_deg, Cx, Cy, Cz, Croll, Cpitch, Cyaw]

alpha_raw = T_wind(:,1);
Craw      = T_wind(:,2:7);                % 6 columns

% Wrap angles to (-180, 180] and sort
alpha = mod(alpha_raw + 180, 360) - 180;   % e.g. 0→-180, 360→180
[alpha, idx] = sort(alpha);
C = Craw(idx, :);

% Merge duplicate angles (interp1 requires distinct X)
tol = 1e-9;                           % tolerance for grouping
alpha_rounded = round(alpha./tol).*tol;
[alpha_unique, ~, g] = unique(alpha_rounded, 'stable');
C_unique = zeros(numel(alpha_unique), size(C,2));
for k = 1:numel(alpha_unique)
    C_unique(k,:) = mean(C(g==k, :), 1);   % average duplicates
end

% Ensure strictly increasing
[alpha_unique, idx2] = sort(alpha_unique);
C_unique = C_unique(idx2, :);

% Add periodic endpoints at -180 and 180 to keep continuity
% If already present, reuse; if not, create by copying the opposite end
have_m180 = any(abs(alpha_unique + 180) < tol);
have_p180 = any(abs(alpha_unique - 180) < tol);

if ~have_m180
    alpha_unique = [-180; alpha_unique];
    C_unique     = [C_unique(end,:); C_unique];   % copy values near +180
end
if ~have_p180
    alpha_unique = [alpha_unique; 180];
    C_unique     = [C_unique; C_unique(2,:)];     % copy values near -180
end

% Column vectors for Simulink
alpha_deg_tab = alpha_unique(:);
Cx_tab        = C_unique(:,1);
Cy_tab        = C_unique(:,2);
Cz_tab        = C_unique(:,3);
C_roll_tab    = C_unique(:,4);
C_pitch_tab   = C_unique(:,5);
C_yaw_tab     = C_unique(:,6);

% alpha_deg_tab = Simulink.Parameter(alpha_deg_tab);  % etc.

% Current (North - East)
mu1 = 0.00001; w1 = 0.00000005;
mu2 = 0.000001; w2 = 0.0000005;

% Wind
Ubar_10 = 10;
kappa_wind = 0.003;
z0 = 10*exp(-2/(5*sqrt(kappa_wind)));
z = 7;
Ubar = Ubar_10 * (5/2) * sqrt(kappa_wind) * log(z/z0);
mu3 = 0.001; w3 = 0.001;
mu4 = 0.001; w4 = 0.0001;


% Gust parameters
gust_amp = 2;        % [m/s] amplitude of gusts
gust_freq = 0.1;     % [rad/s] frequency of gust oscillation

mean_dir = 0;        % [deg] mean wind direction
dir_var_max = 5;     % [deg] max variation
dir_freq = 0.001;    % [rad/s] slow oscillation

V_wind = 10;

% --- Gust shaping parameters ---
T_g       = 3;                    % [s]
sigma_g   = 0.08 * V_wind;        % [m/s] ~ 5–15% of mean
Gain_gust = sqrt(2/T_g) * sigma_g;
V_c = 0.5;
psi_c = deg2rad(90); %flows towards N/E
psi_w = deg2rad(180);

T_dir=200;