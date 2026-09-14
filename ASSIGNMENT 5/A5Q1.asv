clc 
close all 
clear all 

a = 0.5;
b = 1.5;
tol = 10^(-5);
i = 0;
rel = 1;

[i,a,b,tol,rel] = MAIN(i,a,b,tol,rel);


function [i,a,b,tol,rel] = MAIN(i,a,b,tol,rel)
    fprintf("i  a         b       c        f(c)     Rel\n")

    if (A_FUNC(a) * A_FUNC(b)) < 0
        while rel > tol
            i = i + 1;
            t_old = a;
            t = (a+b)/2;

            if A_FUNC(t) == 0
               fprintf("Root found %0.2f\n", t)
               break;
            end

            rel = abs(b - a) / 2; 

            fprintf("%d  %0.5f  %0.5f  %0.5f  %0.5f  %f \n", i, a, b, t, A_FUNC(t), rel)

            if A_FUNC(t) * A_FUNC(a) < 0
               b = t;
            else
               a = t;
            end

        end
    else       
        fprintf("Root doesnt exist between %f and %f\n", a, b)
    end
end


function f = A_FUNC(x)
    f = x * cos(x) - 2*x^2 + 3*x - 1; 
end 
