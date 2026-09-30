clc; clear; close all;

% Differential equation & Exact solution
f = @(t,y) (2 - 2*t*y) / (t^2 + 1);
y_exact_fn = @(t) (2*t + 1) ./ (t.^2 + 1);

step_sizes = [0.5, 0.25, 0.1, 0.01];
colors = ["#D95319", "#EDB120", "#7E2F8E", "#77AC30"];

figure('Position', [100, 100, 800, 500]);
hold on; grid on;

% Plot Exact Solution
t_fine = 0:0.001:1;
plot(t_fine, y_exact_fn(t_fine), 'k-', 'LineWidth', 2.5, 'DisplayName', 'Exact Solution');

% Plot Euler approximations for each h
for i = 1:length(step_sizes)
    h = step_sizes(i);
    t_vec = 0:h:1;
    y_vec = zeros(size(t_vec));
    y_vec(1) = 1; % initial condition y(0)=1
    
    for k = 1:(length(t_vec)-1)
        y_vec(k+1) = y_vec(k) + h * f(t_vec(k), y_vec(k));
    end
    
    plot(t_vec, y_vec, 'o--', 'LineWidth', 1.5, 'MarkerSize', 5, ...
        'Color', colors(i), 'DisplayName', sprintf('Euler (h = %.2f)', h));
end

fuction 


xlabel('t', 'FontSize', 12);
ylabel('y(t)', 'FontSize', 12);
title("Euler's Method Approximation vs. Exact Solution", 'FontSize', 14);
legend('Location', 'southeast', 'FontSize', 11);
hold off;