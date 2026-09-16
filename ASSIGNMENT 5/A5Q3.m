clc 
close all 
clear all 

a = -3;
b = -0.5;
tol = 10^(-5);
i = 0;
rel = 1;

f_ = @(x) 54*x.^6 + 45*x.^5 + - 102*x.^4 -69*x.^3 + 35*x.^2 + 16*x -4; 
exact_val = roots(f_)
fplot(f_, [-5, 5])
yline(0, '--r', 'LineWidth', 1.5) 

[i,a,b,tol,rel] = MAIN(i,a,b,tol,rel);

function [i,a,b,tol,rel] = MAIN(i,a,b,tol,rel)
    fprintf("i   a                  b               c                    f(c)                   rel_err\n")

    while rel > tol
        i = i + 1;
        
        fa = A_FUNC(a);
        fb = A_FUNC(b);
        
        t = b - fb * (b - a) / (fb - fa);
        
        fprintf("%d  %0.5f          %0.5f            %0.5f             %0.5f           %f \n", i, a, b, t, A_FUNC(t), rel)
        
        if A_FUNC(t) == 0
           fprintf("Root found %0.5f\n", t)
           break;
        end

        rel = abs(t - b); 

        a = b;
        b = t;
    end
    fprintf("\n Ans = %f\n", t)
end

function f = A_FUNC(x)
    f = 54*x^6 + 45*x^5 + - 102*x^4 -69*x^3 + 35*x^2 + 16*x -4; 
end 
