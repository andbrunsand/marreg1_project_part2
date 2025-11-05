M_inv = vesselABC.Minv([1 2 6], [1 2 6]);
D = [2.6486e5 0 0;
     0 8.8164e5 0;
     0 0 3.3774e8];

wave_period = 7*0.7;
wave_freq = 2*pi/wave_period;
diag_natwavefreq = diag([wave_freq, wave_freq, wave_freq]);
diag_reldampratios = diag([0.1, 0.1, 0.1]);

Aw = [zeros(3) eye(3); -diag_natwavefreq^2 -2*diag_reldampratios*diag_natwavefreq];
Cw = [zeros(3) eye(3)];

%test params
%K1 = [-diag([2.2059, 2.2059, 2.2059]);
 %      diag([1.6157, 1.6157, 1.6157])];
%K2 = diag([1.1, 1.1, 1.1]);
%K4 = diag([0.1, 0.1, 0.01]);
%K3 = 0.1*K4;

%T = diag([100, 100, 100]);

omega_peak = [0.2, 0.74, 0.9];             % [surge, sway, yaw]
omega_cutoff = 20 .* omega_peak;            % cutoff frequencies

% Damping ratios
zeta_n = [0.03, 0.03, 0.03];                % desired damping
zeta    = [0.03, 0.03, 0.03];               % actual damping

% Compute k_i terms from eqs. (47)–(49)
k1  = -2*(zeta_n(1)-zeta(1))*omega_cutoff(1)/omega_peak(1);
k2  = -2*(zeta_n(2)-zeta(2))*omega_cutoff(2)/omega_peak(2);
k3  = -2*(zeta_n(3)-zeta(3))*omega_cutoff(3)/omega_peak(3);

k4  =  2*omega_cutoff(1)*(zeta_n(1)-zeta(1));
k5  =  2*omega_cutoff(2)*(zeta_n(2)-zeta(2));
k6  =  2*omega_cutoff(3)*(zeta_n(3)-zeta(3));

k7  =  omega_cutoff(1);
k8  =  omega_cutoff(2);
k9  =  omega_cutoff(3);

% K1 from eq. (43)
K1 = [ diag([k1 k2 k3]);
       diag([k4 k5 k6]) ];

% K2 from eq. (44)
K2 = diag([k7 k8 k9]);

% K3 from eq. (45)
M = vesselABC.MA([1 2 6], [1 2 6]) + vesselABC.MRB([1 2 6], [1 2 6]);
K3 = diag(diag(M) * 1e-1);

% K4 from eq. (46)
K4 = diag(diag(M));

% Bias scaling matrix T
T = diag([100, 100, 100]);