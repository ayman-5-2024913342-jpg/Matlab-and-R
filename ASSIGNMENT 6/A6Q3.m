clc; close all; clear all;

% Differential equation & Analytical exact solution handles
f = @(t,y) (y/t - (y/t)^2); 
f_anal = @(t) (t ./ (1 + log(t)));

% Parameters
x0 = 1; 
x = 2; 
y = 1; 
h = 0.1;

% Solve using custom euler function
[iter, x_history, y_history, err] = euler(x, x0, y, h, f, f_anal);

% Print results table
fprintf('Iteration count: %d\n', iter);
fprintf('Final error at x = %.2f: %.6f\n\n', x_history(end), err);

fprintf('%-10s %-12s %-12s %-12s\n', 't', 'Exact', 'Euler Appr', 'Abs Error');
fprintf('%s\n', repmat('-', 1, 48));

for k = 1:length(x_history)
    t_val = x_history(k);
    y_appr = y_history(k);
    y_exact = f_anal(t_val);
    err_val = abs(y_exact - y_appr);
    
    fprintf('%-10.2f %-12.6f %-12.6f %-12.6f\n', t_val, y_exact, y_appr, err_val);
end

% ---------------- Plotting Both Curves on Same Graph ----------------
figure('Position', [100, 100, 800, 500]);
hold on; grid on;

% Fine time vector for smooth analytical plot
t_fine = x0:0.001:x;
plot(t_fine, f_anal(t_fine), 'm-', 'LineWidth', 2, 'DisplayName', 'Analytical Exact Solution');

% Plot Euler approximation points
plot(x_history, y_history, 'ro--', 'LineWidth', 1.5, 'MarkerSize', 6, ...
    'DisplayName', sprintf('Euler Appr (h = %.2f)', h));

xlabel('t', 'FontSize', 12);
ylabel('y(t)', 'FontSize', 12);
title("Oiler Method vs Analytical Solution", 'FontSize', 14);
legend('Location', 'best', 'FontSize', 11);
hold off;


%%===========================================================
%OILED UP METHOD
function [iter, x_history, y_history, err] = euler(x, x0, y, h, f, y_exact_fn)

    x_new = x0;      
    iter = 0;

    x_history = x_new;
    y_history = y;

    while (x - x_new) > 1e-9
        %step = min(h, x - x_new); 
        
        y = y + h * f(x_new, y);
        x_new = x_new + h; 
        iter = iter + 1;

        x_history(end+1) = x_new; %#ok<AGROW>
        y_history(end+1) = y;     %#ok<AGROW>
    end

    exact_sol = y_exact_fn(x_new);
    err = abs(exact_sol - y);
end