clc; close all; clear all;

% Differential equation & Exact solution
f = @(t,y) (2 - 2*t*y) / (t^2 + 1);
f_exact_fn = @(t) (2*t + 1)./(t.^2 + 1);

h_vals = [0.5, 0.25, 0.1, 0.01];

t0 = 0; target_x = 1; y0 = 1;

%t = cell(1, length(h_vals));
%err_arr = cell(1, length(h_vals));
t = [];
err_arr = [];

for i = 1:length(h_vals)
    h = h_vals(i);
    
    [iter, x_history, y_history, err_history, final_err] = euler(target_x, t0, y0, h, f, f_exact_fn);
    t{i} = x_history;
    err_arr{i} = err_history;
end

t_grid = 0:0.1:target_x;
err_history_mat = zeros(length(h_vals), length(t_grid));
for k = 1:length(h_vals)
    err_history_mat(k, :) = interp1(t{k}, err_arr{k}, t_grid, 'linear');
end

% Display vectors for each step size (Your Original Structure Preserved)
fprintf("t              h=0.5          h=0.25        h=0.1         h=0.01\n");
for i = 1:length(t_grid)
    fprintf("%f      %f        %f      %f      %f\n", ...
        t_grid(i), err_history_mat(1,i), err_history_mat(2,i), err_history_mat(3,i), err_history_mat(4,i)); 
end

function [iter, x_history, y_history, err_history, err] = euler(x, x0, y, h, f, y_exact_fn)

    x_new = x0;      
    iter = 0;

    x_history = x_new;
    y_history = y;
    
    % Initialize err and err_history at initial condition (x0, y0)
    err = abs(y - y_exact_fn(x0));
    err_history = err;

    while (x - x_new) > 1e-9
        y = y + h * f(x_new, y);
        x_new = x_new + h; 
        iter = iter + 1;
        
        x_history(end+1) = x_new; %#ok<AGROW>
        y_history(end+1) = y; %#ok<AGROW>
        err = abs(y - y_exact_fn(x_new));
        err_history(end+1) = err; %#ok<AGROW>
    end

    exact_sol = y_exact_fn(x_new);
    err = abs(exact_sol - y);

end