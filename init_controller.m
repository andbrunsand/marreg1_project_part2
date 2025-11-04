w_b_surge = 0.05;
w_b_sway = 0.12;
w_b_yaw = 0.17;

OMEGA_b = diag([w_b_surge,w_b_sway,w_b_yaw]);

zetta_surge = 0.9;
zetta_sway = 1;
zetta_yaw = 0.9;

Z = diag([zetta_surge,zetta_sway,zetta_yaw]);

w_n_surge=computeNaturalFreq(zetta_surge,w_b_surge);
w_n_sway=computeNaturalFreq(zetta_sway,w_b_sway);
w_n_yaw=computeNaturalFreq(zetta_yaw,w_b_yaw);

OMEGA_n = diag([w_n_surge,w_n_sway,w_n_yaw]);

M=diag([vesselABC.MRB(1,1),vesselABC.MRB(2,2),vesselABC.MRB(6,6)]);

K_p = M*OMEGA_n^2;
K_i = 0.1*K_p*OMEGA_n;
K_d = 2*M*Z*OMEGA_n;

surge_p = 5;
surge_i = 5;
surge_d = 5;

sway_p = 5;
sway_i = 5;
sway_d = 5;

yaw_p = 5;
yaw_i = 5;
yaw_d = 5;