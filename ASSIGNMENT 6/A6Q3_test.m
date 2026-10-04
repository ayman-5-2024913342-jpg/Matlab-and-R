clc; close all; clear all;

% Differential equation & Analytical exact solution handles
f = @(t,y) (y/t - (y/t)^2); 
f_anal = @(t) (t ./ (1 + log(t)));

% Parameters
t0 = 1; 
t_end = 2; 
y0 = 1; 
h = 0.1;

% Define time vector for the steps
t_steps = t0:h:t_end;
N = length(t_steps);

%% ===========================================================
% a) ODE45 Solver (Evaluated at specific t steps)
%% ===========================================================
[~, y_ode45] = ode45(f, t_steps, y0);

%% ===========================================================
% b) Euler's Method
%% ===========================================================
y_euler = zeros(N, 1);
y_euler(1) = y0;
for i = 1:N-1
    y_euler(i+1) = y_euler(i) + h * f(t_steps(i), y_euler(i));
end

%% ===========================================================
% c) RK-2 Method (Heun's Method / Modified Euler)
%% ===========================================================
y_rk2 = zeros(N, 1);
y_rk2(1) = y0;
for i = 1:N-1
    k1 = f(t_steps(i), y_rk2(i));
    k2 = f(t_steps(i) + h, y_rk2(i) + h * k1);
    y_rk2(i+1) = y_rk2(i) + (h / 2) * (k1 + k2);
end

%% ===========================================================
% d) RK-4 Method (FIXED: Changed [] to () indexing)
%% ===========================================================
y_rk4 = zeros(N, 1);
y_rk4(1) = y0;
for i = 1:N-1
    k1 = f(t_steps(i), y_rk4(i));
    k2 = f(t_steps(i) + h/2, y_rk4(i) + h*k1/2);
    k3 = f(t_steps(i) + h/2, y_rk4(i) + h*k2/2);
    k4 = f(t_steps(i) + h, y_rk4(i) + h*k3);
    y_rk4(i+1) = y_rk4(i) + (h / 6) * (k1 + 2*k2 + 2*k3 + k4);
end

%% ===========================================================
% Generate Data Table
%% ===========================================================
% Calculate Exact Values
y_exact = f_anal(t_steps)';

% Display table with exact requested headings
fprintf('\n%-5s %-10s %-10s %-10s %-10s %-10s\n', 't', 'Exact', 'ODE45', 'Euler', 'RK2', 'RK4');
fprintf('%s\n', repmat('-', 1, 60));
for i = 1:N
    % FIXED: Changed t_steps[i] to t_steps(i)
    fprintf('%-5.1f %-10.6f %-10.6f %-10.6f %-10.6f %-10.6f\n', ...
        t_steps(i), y_exact(i), y_ode45(i), y_euler(i), y_rk2(i), y_rk4(i));
end

%% ===========================================================
% Plotting Results
%% ===========================================================
figure('Position', [100, 100, 900, 600]);
hold on; grid on;

% Smooth curve for exact analytical solution
t_fine = t0:0.001:t_end;
plot(t_fine, f_anal(t_fine), 'k-', 'LineWidth', 2.5, 'DisplayName', 'Exact Solution');

% Plot approximations
plot(t_steps, y_ode45, 'b-^', 'LineWidth', 1.5, 'MarkerSize', 7, 'DisplayName', 'ODE45');
plot(t_steps, y_euler, 'r-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Euler Method');
plot(t_steps, y_rk2, 'g-s', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'RK-2');
plot(t_steps, y_rk4, 'm--x', 'LineWidth', 1.5, 'MarkerSize', 8, 'DisplayName', 'RK-4');

xlabel('t', 'FontSize', 12);
ylabel('y(t)', 'FontSize', 12);
title('Comparison of Numerical Solvers vs Exact Solution', 'FontSize', 14);
legend('Location', 'best', 'FontSize', 11);
hold off;
