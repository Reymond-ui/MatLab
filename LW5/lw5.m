% Параметры для двигателя 268213 (нечетный)
U_nom = 18;                 % В
R_a = 0.358;                % Ом
L_a = 0.070e-3;             % Гн
k_m = 19.9e-3;              % Н*м/А
J_sum = 35.9e-7;            % кг*м^2
M_nom = 78.6e-3;            % Н*м
I_nom = 3.47;               % А
I_0 = 0.213;                % А
n_0 = 8490;                 % об/мин
n_nom = 8160;               % об/мин

w_0 = n_0 * 2 * pi / 60;

M = out.M.Data
n = out.n.Data

n_target = (2/3) * n_nom;

[~, idx] = min(abs(n - n_target));
M_target = M(idx)+20;

figure;
plot(n, M, 'k-', 'LineWidth', 2); hold on;
xline(n_target, 'r:', 'LineWidth', 1.5); 
plot(n_target, M_target, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
grid on;
xlabel('n, об/мин');
ylabel('M, мН*м');
text(n_target, M_target, sprintf('  M=%.1f, n=%.0f', M_target, n_target));