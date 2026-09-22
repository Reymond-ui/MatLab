Gain = 59;
K_os1 = 21;
K_os2 = 36;

W1 = tf(14,[0.15 1]);
W2 = tf(0.0067, [1 0]);

W = feedback(W2, K_os1, -1);
W = W * W1;
W = feedback(W, K_os2, -1);
W = W * Gain * tf(1, [1 0]);
W = feedback(W, 1, -1)

syms x(t)
g = 0

[V] = odeToVectorField(0.15 * diff(x,3)+1.021 * diff(x,2)+3.518 * diff(x,1) + 5.534 * x == 5.534 * g );
M = matlabFunction(V, 'Vars',{'t', 'Y'});
sol = ode45(M, [0 5], [1 0 0]);

fplot(@(t)deval(sol,t,1), [0 5]);
hold on;

t_num=0:0.1:5;
prec_sol = deval(sol, t_num, 1);
plot(t_num, prec_sol, '-r');

xlabel("t");
ylabel("x(t)");
