clc; close all; clear all;

%========Define Functions================
y_anal = @(t) (2*t  + 1) / (t^2 + 1);
y_prime = @(t,y) (2 - 2*t*y) ./ (t^2 + 1);
%========================================

%=================Constants=============
h_vals = [0.5, 0.25, 0.1, 0.01];
t0 = 0; y0 = 1;

disp("[Comparison]")
fprintf("\n")
% Print the overall Table Header
fprintf("%-6s    %-10s    %-10s    %-10s    %-10s\n", 'h', 'Total_Iter', 'Exact_Val', 'Approx_Val', 'Abs_Error');
fprintf("-----------------------------------------------------------------\n");

for i = 1:length(h_vals)
    [iter, t_vals, y_vals, exact, err] = euler(1, t0, y0, h_vals(i), y_prime, y_anal);
    
    % Use 'end' to grab the final computed value at target_T
    final_y = y_vals(end); 
    
    % Print a clean, formatted row for each step size
    fprintf("%-6.2f    %-10d    %-10.5f    %-10.5f    %-10.5e\n", ...
            h_vals(i), iter, exact, final_y, err);
end


fprintf("\n")
disp("[Detailed Table]")
for i = 1:length(h_vals)

    current_h = h_vals(i); % Changed name to avoid variable collisions
    [total_steps, t_vals, y_vals, final_exact, final_err] = euler(1, t0, y0, current_h, y_prime, y_anal);
    
    % Fixed format token from .2%f to %.2f
    fprintf("\nTable for h = %.2f\n", current_h);
    
    % Cleaned up 5 structural columns matching 5 column names
    fprintf("%-6s  %-10s  %-10s  %-10s  %-10s\n", "iter", "t_vals", "exact", "y_vals", "error");
    fprintf("===============================================================\n");
    
    for j = 1:length(t_vals)
        % Compute exact solution dynamically for the current time step t_vals(j)
        step_exact = y_anal(t_vals(j));
        step_error = abs(step_exact - y_vals(j));
        
        % Print each step row cleanly (j-1 gives us step 0, step 1, step 2...)
        fprintf("%-6d  %-10.2f  %-10.4f  %-10.4f  %-10.4e\n", ...
                j-1, t_vals(j), step_exact, y_vals(j), step_error);
    end
end

function [iter, t_vals, y_vals, exact, err] = euler(target_X, x0, y0, h, y_prime, y_anal)
    x = x0;
    y = y0;
    iter = 0;
    t_vals = [x];
    y_vals = [y];
    iter = 0;

    while x < target_X-1e-9
        iter = iter + 1;
        
        y = y + h * y_prime(x,y);
        x = x + h;
        
        t_vals(iter+1) = x;
        y_vals(iter+1) = y;
    end
    
    exact = y_anal(target_X);
    err = abs(exact - y);
end
