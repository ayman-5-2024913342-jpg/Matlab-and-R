clc 
close all 
clear all 

a = -pi;
b = pi;
tol = 10^(-5);
i = 0;
rel = 1;
%f_ = @(x) x .* cos(x) - 2*x.^2 + 3*x - 1; 
f_ = @(x) 1/2 + 1/4*x^2 - x*sin(x) - 1/2*cos(2*x);
exact_val = fzero(f_, 0)

fplot(f_, [-2, 2])

[i,a,b,tol,rel] = MAIN(i,a,b,tol,rel, exact_val);

function [i,a,b,tol,rel] = MAIN(i,a,b,tol,rel, exact_val)
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

            rel = abs(exact_val - t_old) / exact_val; 

            fprintf("%d  %0.5f  %0.5f  %0.5f  %0.5f  %f \n", i, a, b, t, A_FUNC(t), rel)

            if A_FUNC(t) * A_FUNC(a) < 0
               b = t;
            else
               a = t;
            end

        end
    else       
        fprintf("Root doesnt exist between %f and %f\n\n", a, b)
    end
   % fprintf("Ans = %f\n", t) 
end


function f = A_FUNC(x)
    f = 1/2 + 1/4*x^2 - x*sin(x) - 1/2*cos(2*x);
end

%function f = A_FUNC(x)
%    f = x * cos(x) - 2*x^2 + 3*x - 1; 
%end 
