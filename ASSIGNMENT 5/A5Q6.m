clc;
clear all;
close all;

% Initial interval
a = 2;
b = 3;

% Run root-finding algorithms
[x_b, re_b]     = bisection(a, b);
[x_new, re_ne]  = newton(a, b);
[x_sec, re_sec] = secant(a, b);
[x_fal, re_fal] = false(a, b);

% Pad vectors with NaN to match maximum iteration length
n_max = max([length(x_b), length(x_new), length(x_sec), length(x_fal)]);

x_b(end+1:n_max)    = NaN;
x_new(end+1:n_max)  = NaN;
x_sec(end+1:n_max)  = NaN;
x_fal(end+1:n_max)  = NaN;

re_b(end+1:n_max)   = NaN;
re_ne(end+1:n_max)  = NaN;
re_sec(end+1:n_max) = NaN;
re_fal(end+1:n_max) = NaN;

% 1. Run algorithms
[x_b, re_b]     = bisection(a, b);
[x_new, re_ne]  = newton(a, b);
[x_sec, re_sec] = secant(a, b);
[x_fal, re_fal] = false(a, b);

% 2. Find maximum length
n_max = max([length(x_b), length(x_new), length(x_sec), length(x_fal)]);

% 3. Pad roots by repeating the final value
x_b(end+1:n_max)   = x_b(end);
x_new(end+1:n_max) = x_new(end);
x_sec(end+1:n_max) = x_sec(end);
x_fal(end+1:n_max) = x_fal(end);

% 4. Pad errors with 0
re_b(end+1:n_max)   = 0;
re_ne(end+1:n_max)  = 0;
re_sec(end+1:n_max) = 0;
re_fal(end+1:n_max) = 0;

% 5. NOW create the matrix (or table) AFTER padding is done!
matrix = [x_b(:), x_new(:), x_sec(:), x_fal(:), re_b(:), re_ne(:), re_sec(:), re_fal(:)];

% Optional: Display it cleanly as a Table so you see column names
Iteration = (1:n_max)';
T = table(Iteration, x_b(:), x_new(:), x_sec(:), x_fal(:), re_b(:), re_ne(:), re_sec(:), re_fal(:));
T.Properties.VariableNames = {'Iteration', 'x_bisection', 'x_newton', 'x_secant', 'x_false', 'err_bisection', 'err_newton', 'err_secant', 'err_false'};

disp(' ');
disp('=============================================================================================================');
disp('                                    ROOT-FINDING METHODS ITERATION TABLE');
disp('=============================================================================================================');
disp(T);

% Plot Relative Error vs Iteration
figure;
plot(1:n_max, re_b, 'r-o', 'LineWidth', 1.5, 'DisplayName', 'Bisection');
hold on;
plot(1:n_max, re_ne, 'g-s', 'LineWidth', 1, 'DisplayName', 'Newton-Raphson');
plot(1:n_max, re_sec, 'b-d', 'LineWidth', 0.5, 'DisplayName', 'Secant');
plot(1:n_max, re_fal, 'm-^', 'LineWidth', 0.25, 'DisplayName', 'False Position');
hold off;
%plot function to do

xlabel('Iteration');
ylabel('Relative Error (%)');
title('Convergence Comparison of Root-Finding Methods');
legend('Location', 'northeast');
grid on;


%% =========================================================================
%                             LOCAL FUNCTIONS
% =========================================================================

function y = f(x)
    y = x^3 - x - exp(x) - 2;
end

function dy = df(x)
    dy = 3*x^2 - 1 - exp(x);
end

function [x_b, re_b] = bisection(a, b)
    i = 1;
    tol = 1e-5;
    FA = f(a);
    po = 0;
    x_b = [];
    re_b = [];
    
    if (f(a) * f(b)) < 0
        while i <= 100
            p = a + (b - a)/2;
            FP = f(p);
            re_b(i) = abs((p - po)/p) * 100;
            x_b(i) = p;
            
            if FP == 0 || abs((b - a)/2) < tol
                break;
            end
            
            i = i + 1;
            if (FA * FP) > 0 
                a = p;
            else
                b = p;
            end
            po = p;
        end
    elseif (f(a) * f(b)) >= 0
        disp('Bisection not possible: f(a) and f(b) must have opposite signs.');
    end
end

function [x_new, re_ne] = newton(a, b)
    i = 1;
    tol = 1e-5;
    p0 = (a + b)/2;
    x_new = [];
    re_ne = [];
    
    if df(p0) == 0
        return;
    else
        while i <= 100
            p = p0 - f(p0)/df(p0);
            re_ne(i) = abs((p - p0)/p) * 100;
            x_new(i) = p;
            
            if abs(p0 - p) < tol
                break;
            end
            
            i = i + 1;
            p0 = p;
        end
    end
end

function [x_sec, re_sec] = secant(a, b)
    i = 1;
    tol = 1e-5;
    x_sec = [];
    re_sec = [];
    
    if df(a) < df(b)
        p1 = a;
        p0 = b;
    else
        p1 = b;
        p0 = a;
    end
    
    q0 = f(p0);
    q1 = f(p1);
    
    while i <= 100
        q0 = f(p0);
        q1 = f(p1);
        if (q1 - q0) == 0
            break;
        end
        
        p = p1 - q1 * (p1 - p0) / (q1 - q0);
        re_sec(i) = abs((p - p1)/p) * 100;
        x_sec(i) = p;
        
        if abs(p - p1) < tol
            %fprintf('Secant Output: %f\n', p);
            break;
        end
        
        i = i + 1;
        p0 = p1;
        p1 = p;
    end
end

function [x_fal, re_fal] = false(a, b)
    tol = 1e-5;
    i = 1;
    p0 = a;
    p1 = b;
    q0 = f(p0);
    q1 = f(p1);
    x_fal = [];
    re_fal = [];
    
    while i <= 100
        p = p1 - q1 * (p1 - p0) / (q1 - q0);
        re_fal(i) = abs((p - p1)/p) * 100;
        x_fal(i) = p;
        
        if abs(p - p1) < tol
            break;
        end
        
        i = i + 1;
        q = f(p);
        
        if q * q1 < 0 
            p0 = p1;
            q0 = q1;
        end
        p1 = p;
        q1 = q;
    end
end