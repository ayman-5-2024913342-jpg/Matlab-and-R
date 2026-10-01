clc; close all; clear all;

% Problem settings
x_target = 1;
x0 = 0;
y0 = 1;

h_vec = [0.5, 0.25, 0.1, 0.01];
t_common = 0:0.1:1; % Grid for comparison table

% Preallocate storage table (rows = t points, cols = exact + 4 step sizes)
table_data = NaN(length(t_common), 1 + length(h_vec));

% Fill exact column
for i = 1:length(t_common)
    table_data(i, 1) = f(t_common(i));
end


% Graphic Plotting Setup
figure('Position', [100, 100, 800, 500]);
t_dense = linspace(0, 1, 200);
plot(t_dense, f(t_dense), 'k-', 'LineWidth', 2, 'DisplayName', 'Exact Solution');
hold on;
colors = {'r--o', 'b--s', 'm--^', 'g--.'};

% Solve IVP for each h using your euler function structure
for k = 1:length(h_vec)
    h = h_vec(k);
    
    % Evaluate trajectory at every step from x0 to x_target
    t_steps = x0:h:x_target;
    y_steps = zeros(size(t_steps));
    
    for j = 1:length(t_steps)
        % Call your custom euler function to reach target time point t_steps(j)
        [~, ~, y_steps(j), ~] = euler(t_steps(j), x0, y0, h);
    end
    
    % Plot trajectory
    plot(t_steps, y_steps, colors{k}, 'LineWidth', 1.2, ...
        'MarkerSize', 6, 'DisplayName', sprintf('h = %.2f', h));
    
    % Align values onto common table grid
    for i = 1:length(t_common)
        idx = find(abs(t_steps - t_common(i)) < 1e-6, 1);
        if ~isempty(idx)
            table_data(i, k+1) = y_steps(idx);
        end
    end
end


xlabel('t', 'FontSize', 12);
ylabel('y(t)', 'FontSize', 12);
title('Euler Method Approximations vs Exact Solution', 'FontSize', 14);
legend('Location', 'NorthWest');
grid on;

% Display Table Output
fprintf('\n%8s | %10s | %10s | %10s | %10s | %10s\n', ...
    't', 'Exact', 'h=0.5', 'h=0.25', 'h=0.1', 'h=0.01');
fprintf('%s\n', repmat('-', 1, 72));

for i = 1:length(t_common)
    fprintf('%8.2f | %10.6f | ', t_common(i), table_data(i, 1));
    for k = 1:length(h_vec)
        if isnan(table_data(i, k+1))
            fprintf('%10s | ', '—');
        else
            fprintf('%10.6f | ', table_data(i, k+1));
        end
    end
    fprintf('\n');
end


function [iter, x_new, y, err] = euler(x, x0, y0, h)
    iter = 0;
    x_new = x0;
    y = y0;
    
    while abs(x_new - x) >  1e-9
        y = y + h * f_anal(x_new, y);
        iter = iter + 1;
        x_new = x0 + h * iter;
    end
    
    exact_sol = f(x);
    err = abs(y - exact_sol);
end

function y = f(t)
    % Exact analytical solution matching ODE
    y = (2*t + 1) ./ (t.^2 + 1);
end

function y_prime = f_anal(t, y)
    % ODE derivative dy/dt = (2 - 2*t*y) / (t^2 + 1)
    y_prime = (2 - 2*t*y) ./ (t.^2 + 1);
end