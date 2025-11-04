M_inv = vesselABC.Minv([1 2 6], [1 2 6]);
D = [2.6486e5 0 0;
     0 8.8164e5 0;
     0 0 3.3774e8];

wave_period = 9;
wave_freq = 2*pi/wave_period;
diag_natwavefreq = diag([wave_period, wave_period, wave_period]);
diag_reldampratios = diag([0.05, 0.05, 0.05]);

Aw = [zeros(3) eye(3); -diag_natwavefreq^2 -2*diag_reldampratios*diag_natwavefreq];
Cw = [zeros(3) eye(3)];
Ew = [zeros(3); diag([0.1, 0.1, 0.1])];

x = [39.3, 36.5, 34.3, -28.5, -28.5];  % x-coordinates
y = [0, 0, 0, 5, -5];                   % y-coordinates

Bu = [0     1     0     0     1     0     1     0;  % Surge forces  
     1     0     1     1     0     1     0     1;  % Sway forces    
     x(1) -y(2)  x(2)  x(3) -y(4)  x(4) -y(5)  x(5)]; % Yaw moments

P0 = zeros(15);
x0 = zeros([15 1]);

Q_kalman = eye(3)*10;
R_kalman = 10;