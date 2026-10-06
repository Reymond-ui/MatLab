close all;

t = out.tout;
Omega_d = out.Omega_d.Data;
Omega_p = out.Omega_p.Data;
M = out.M.Data;
T = out.T.Data;

figure;
subplot(3,1,1);
plot(t, Omega_d); grid on;
xlabel('t, с'); ylabel('\Omega_d, рад/с');

subplot(3,1,2);
plot(t, Omega_p); grid on;
xlabel('t, с'); ylabel('\Omega_p, рад/с');

subplot(3,1,3);
plot(t, M); grid on;
xlabel('t, с'); ylabel('M, Н\cdotм');

figure;
plot(t, T); grid on;
xlabel('t, с'); ylabel('T, Н');