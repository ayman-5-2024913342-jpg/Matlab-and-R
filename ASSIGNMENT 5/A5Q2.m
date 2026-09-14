clc 
close all
clear all

args = [pi/4, pi, -pi];
for i = 1:3
    arg = args(i);
    fprintf("For initial value x0 = %f\n", arg);
    fprintf("%-6s %-10s %-10s %-10s %-10s %-10s\n", 'iter', 'Pn-1', 'df(Pn-1)', 'Pn', 'f(Pn)', 'err')
    the_func(arg)
    fprintf("\n\n")
end

function the_func(arg)
    for i=1:1000
        x_old = arg; 
        
        df_val = df(x_old);
        
        x_new = x_old - f(x_old)/df_val; 
        f_new = f(x_new);
        
        rel = abs((x_new - x_old) / (x_new + 1e-12));
        err = abs(x_new - x_old);
        
        fprintf("%-6d %-10.5f %-10.5f %-10.5f %-10.5f %-10.5f\n", i, x_old, df_val, x_new, f_new, rel)
        
        if err < 10^-5
            break;
        end 
        
        arg = x_new; 
    end
    fprintf("Ans %f ", x_new)
end

function y = f(x)
    y = 1/2 + 1/4*x^2 - x*sin(x) - 1/2*cos(2*x);
end

function y_prime = df(x)
    y_prime = x/2 - sin(x) - x*cos(x) + sin(2*x);
end
