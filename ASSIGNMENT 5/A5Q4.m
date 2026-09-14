clc 
close all 
clear all 

% 1. Choose values greater than 1 because log(x-1) requires x > 1
% f(1.1) is negative, f(2) is positive -> Valid bracket!
a = 1.3; 
b = 2.0; 
tol = 10^(-5);
i = 0;
rel = 1;

[i,a,b,tol,rel] = MAIN(i,a,b,tol,rel);

function [i,a,b,tol,rel] = MAIN(i,a,b,tol,rel)
    fprintf("i   a                  b               c                    f(c)                   Rel\n")

    c_old = a; 

    while rel > tol
        i = i + 1;
        
        fa = A_FUNC(a);
        fb = A_FUNC(b);
        
        t = b - (fb * (a - b)) / (fa - fb);

        ft = A_FUNC(t);

        if ft == 0
           fprintf("Exact root found: %0.5f\n", t)
           break;
        end

        rel = abs(t - c_old); 
        c_old = t;

        fprintf("%d  %0.5f          %0.5f            %0.5f             %0.5f           %f \n", i, a, b, t, ft, rel)

        if fa * ft < 0
            b = t; 
        else
            a = t; 
        end
    end
    fprintf("\nAns = %f\n", c_old)
end

function f = A_FUNC(x)
    f = log(x - 1) + cos(x - 1); 
end 
