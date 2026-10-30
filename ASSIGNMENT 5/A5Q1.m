clc 
close all 
clear all 

a = 0.5;
b = 1.5;
tol = 10^(-5);
i = 0;
rel = 1;

% Define the function handle
f_ = @(x) x .* cos(x) - 2*x.^2 + 3*x - 1; 
% Alternate function option:
% f_ = @(x) 1/2 + 1/4*x^2 - x*sin(x) - 1/2*cos(2*x);

% Find exact value using the bracket interval [a, b]
exact_val = fzero(f_, [a, b]);

fplot(f_, [-2, 2])
grid on;

% Call MAIN function passing the function handle
MAIN(i, a, b, tol, rel, exact_val, f_);

function MAIN(i, a, b, tol, rel, exact_val, f)
    fprintf("i  a         b       c        f(c)     Rel\n");
    
    if (f(a) * f(b)) < 0
        t = a; % Initialize t for the first iteration
        while rel > tol
            i = i + 1;
            t = (a + b) / 2;
            fc = f(t);
            
            if fc == 0
               fprintf("Root found exactly at %0.5f\n", t);
               break;
            end
            
            % Compute relative error using current midpoint approximation t
            rel = abs(exact_val - t) / abs(exact_val); 
            
            fprintf("%d  %0.5f  %0.5f  %0.5f  %0.5f  %f \n", i, a, b, t, fc, rel);
            
            if fc * f(a) < 0
               b = t;
            else
               a = t;
            end
        end
        fprintf("\nFinal Root Approximation = %0.6f\n", t);
    else       
        fprintf("Root doesn't exist between %f and %f\n\n", a, b);
    end
end