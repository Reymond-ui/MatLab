clear all
clear
clc

ro = 1000;
D = 0.25;
Vx = 1.5;
Rx = 60;
t = 0.1;
Vp = Vx;

T_req = Rx/(1-t);
k_d = D*Vp*sqrt(ro/T_req);
%==По графикам==
lambda_p = 0.64;
k1 = 0.194;
H_D = 1.0;
k2 = 0.032;
%===============
n = Vp/(lambda_p*D);
n_rpm = n*60;

T = k1*ro*n^2*D^4;
M = k2*ro*n^2*D^5;

ro_gv = 7700;
h = 0.004;
J_gv = ro_gv*pi*(D/2)^4*h/2;

U_nom = 18;
R_a = 0.358;
L_a = 0.070e-3;
k_m = 19.9e-3;
k_omega = 19.9e-3;
J_sum = 35.9e-7;
J_dv = 35.9e-7;
M_nom = 75.5e-3;
I_nom = M_nom/k_m;
I_0 = 0.213;
n_0 = 8590;
n_nom = 7910;
w_0 = n_0 * 2 * pi / 60;


i_p = n_nom/n_rpm;

k2L = M/n;
C = k2L/(2*pi*i_p^2);

T_dv = (R_a*J_dv/k_m)/(k_omega + R_a*C/k_m);
K_dv = 1/(k_omega + R_a*C/k_m);

W_dv = tf(K_dv, [T_dv 1]);
W_dv_p = W_dv/i_p;

disp(table(T_req,k_d,lambda_p,k1,H_D,k2,n,n_rpm,T,M,J_gv,i_p,k2L,C,T_dv,K_dv))