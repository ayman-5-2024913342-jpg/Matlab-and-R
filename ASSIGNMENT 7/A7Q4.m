clc; close all; clear all;

% Given data
t = [0, 1, 3, 4, 6, 7, 9];
NB = [500, 600, 1000, 1400, 2100, 2700, 4100];
t_est = 5.0;
t_dense = linspace(min(t), max(t), 200);

%% ==========================================
% Part a: Exponential Fit (NB = N * exp(alpha * t))
% ==========================================
% Linearize via natural logarithm: ln(NB) = ln(N) + alpha * t
p = polyfit(t, log(NB), 1);
alpha = p(1);
N_coeff = exp(p(2));

% Estimate at t = 5h
NB_exp_5 = N_coeff * exp(alpha * t_est);

fprintf('--- Part a: Exponential Fit ---\n');
fprintf('Equation: NB = %.2f * exp(%.4f * t)\n', N_coeff, alpha);
fprintf('Estimated NB at t = 5h: %.2f\n\n', NB_exp_5);

% Plot for Part a
figure('Name', 'Exponential Fit', 'Position', [100, 100, 800, 500]);
scatter(t, NB, 60, 'black', 'filled', 'DisplayName', 'Data Points');
hold on;
plot(t_dense, N_coeff * exp(alpha * t_dense), 'r-', 'LineWidth', 1.5, ...
    'DisplayName', sprintf('Exp Fit: N_B = %.2f e^{%.3ft}', N_coeff, alpha));
scatter(t_est, NB_exp_5, 100, 'magenta', 'p', 'filled', ...
    'DisplayName', sprintf('Estimate at 5h: %.2f', NB_exp_5));
xlabel('Time t (h)');
ylabel('Bacteria Count N_B');
title('a) Exponential Curve Fitting');
legend('Location', 'northwest');
grid on;
hold off;


%% ==========================================
% Part b: Interpolation Methods
% ==========================================
% 1. Linear Interpolation
NB_linear_5 = interp1(t, NB, t_est, 'linear');

% 2. Cubic Spline Interpolation (using 'spline')
NB_spline_5 = spline(t, NB, t_est);

% 3. PCHIP Interpolation (Shape-preserving piecewise cubic)
NB_pchip_5 = pchip(t, NB, t_est);

fprintf('--- Part b: Interpolation Estimates at t = 5h ---\n');
fprintf('Linear Interpolation: %.2f\n', NB_linear_5);
fprintf('Cubic Spline Interpolation: %.2f\n', NB_spline_5);
fprintf('PCHIP Interpolation: %.2f\n', NB_pchip_5);

% Evaluate dense curves for plotting
y_linear = 	(t, NB, t_dense, 'linear');
y_spline = spline(t, NB, t_dense);
y_pchip = pchip(t, NB, t_dense);

% Plot for Part b
figure('Name', 'Interpolation Methods', 'Position', [150, 150, 800, 500]);
scatter(t, NB, 60, 'black', 'filled', 'DisplayName', 'Data Points');
hold on;
plot(t_dense, y_linear, 'b--', 'LineWidth', 1.5, 'DisplayName', 'Linear Interpolation');
plot(t_dense, y_spline, 'g-', 'LineWidth', 1.5, 'DisplayName', 'Cubic Spline');
plot(t_dense, y_pchip, 'Color', [0.85, 0.33, 0.1], 'LineStyle', '-.', 'LineWidth', 1.5, 'DisplayName', 'PCHIP Interpolation');

% Mark estimates at t = 5h
scatter(t_est, NB_linear_5, 80, 'blue', 'o', 'filled', 'HandleVisibility', 'off');
scatter(t_est, NB_spline_5, 80, 'green', 's', 'filled', 'HandleVisibility', 'off');
scatter(t_est, NB_pchip_5, 80, [0.85, 0.33, 0.1], '^', 'filled', 'HandleVisibility', 'off');

xlabel('Time t (h)');
ylabel('Bacteria Count N_B');
title('b) Interpolation Methods (Linear, Spline, PCHIP)');
legend('Location', 'northwest');
grid on;
hold off;