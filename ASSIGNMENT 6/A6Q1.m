clc; clear; close all;

f = @(t,y) (2 - 2*t*y) / (t^2 + 1);
y_exact_fn = @(t) (2*t + 1) ./ (t.^2 + 1);

step_sizes = [0.5, 0.25, 0.1, 0.01];
colors = ["#D95319", "#EDB120", "#7E2F8E", "#77AC30"];

t0 = 0; target_x = 1; y0 = 1;

plot_euler_results(target_x, t0, y0, step_sizes, colors, f, y_exact_fn);


function plot_euler_results(target_x, t0, y0, step_sizes, colors, f, y_exact_fn)


    t_common = (t0:0.1:target_x)';
    sol_matrix = zeros(length(t_common), length(step_sizes));

    figure('Position', [100, 100, 800, 500]);
    hold on; grid on;

    t_fine = 0:0.001:target_x;
    plot(t_fine, y_exact_fn(t_fine), 'k-', 'LineWidth', 2.5, 'DisplayName', 'Exact Solution');

    for i = 1:length(step_sizes)
        h = step_sizes(i);

        [iter, x_history, y_history, final_err] = euler(target_x, t0, y0, h, f, y_exact_fn);

        sol_matrix(:, i) = interp1(x_history, y_history, t_common, 'linear');

        plot(x_history, y_history, 'o--', 'LineWidth', 1.5, 'MarkerSize', 5, ...
            'Color', colors(i), ...
            'DisplayName', sprintf('h = %.2f (Iter: %d, Err: %.4f)', h, iter, final_err));
    end

    xlabel('t', 'FontSize', 12);
    ylabel('y(t)', 'FontSize', 12);
    title("Euler's Method Approximation vs. Exact Solution", 'FontSize', 14);
    legend('Location', 'southeast', 'FontSize', 10);
    hold off;

    fprintf('\n%-10s %-12s %-12s %-12s %-12s %-12s\n', 't', 'Exact', 'h=0.5', 'h=0.25', 'h=0.1', 'h=0.01');
    fprintf('%s\n', repmat('-', 1, 72));
    
    for k = 1:length(t_common)
        t_val = t_common(k);
        y_exact = y_exact_fn(t_val);
        fprintf('%-10.2f %-12.6f %-12.6f %-12.6f %-12.6f %-12.6f\n', ...
            t_val, y_exact, sol_matrix(k, 1), sol_matrix(k, 2), sol_matrix(k, 3), sol_matrix(k, 4));
    end
    fprintf('\n');
end


function [iter, x_history, y_history, err] = euler(x, x0, y, h, f, y_exact_fn)

    x_new = x0;      
    iter = 0;

    x_history = x_new;
    y_history = y;

    while (x - x_new) > 1e-9
        step = min(h, x - x_new); 
        
        y = y + step * f(x_new, y);
        x_new = x_new + step; 
        iter = iter + 1;

        x_history(end+1) = x_new; %#ok<AGROW>
        y_history(end+1) = y;     %#ok<AGROW>
    end

    exact_sol = y_exact_fn(x_new);
    err = abs(exact_sol - y);
end