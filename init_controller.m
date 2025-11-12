w_b_surge = 0.03;
w_b_sway = 0.05;
w_b_yaw = 0.08;

OMEGA_b = diag([w_b_surge,w_b_sway,w_b_yaw]);

zeta_surge = 1.2;
zeta_sway = 1.0;
zeta_yaw = 0.9;

Z = diag([zeta_surge,zeta_sway,zeta_yaw]);

w_n_surge=computeNaturalFreq(zeta_surge,w_b_surge);
w_n_sway=computeNaturalFreq(zeta_sway,w_b_sway);
w_n_yaw=computeNaturalFreq(zeta_yaw,w_b_yaw);

OMEGA_n = diag([w_n_surge,w_n_sway,w_n_yaw]);

M = diag([vesselABC.MRB(1,1),vesselABC.MRB(2,2),vesselABC.MRB(6,6)]);

%alpha_I = diag([0.045, 0.035, 0.035]);

K_p = M*OMEGA_n^2;
K_i = 0.1 * K_p * OMEGA_n;
%K_i = 0;
K_d = 2*M*Z*OMEGA_n;