clc;
clear;
close all;

%% Function
f = @(x) x^3 - x - exp(x) - 2;

%% Initial values
a = 2;
b = 3;

% Secant initial guesses
x0 = 2;
x1 = 3;

% Number of iterations
N = 25;

% Tolerance
tol = 1e-6;


%% Storage

x_bisec = zeros(N,1);
x_secant = zeros(N,1);
x_rfp = zeros(N,1);

error_bisec = zeros(N,1);
error_secant = zeros(N,1);
error_rfp = zeros(N,1);


%% =========================================================
%                    BISECTION METHOD
% ==========================================================

a_b = a;
b_b = b;

for i = 1:N

    % Midpoint
    c = (a_b + b_b)/2;

    x_bisec(i) = c;

    % Error
    if i == 1
        error_bisec(i) = NaN;
    else
        error_bisec(i) = abs(x_bisec(i) - x_bisec(i-1));
    end

    % Check interval
    if f(a_b)*f(c) < 0
        b_b = c;
    else
        a_b = c;
    end

end


%% =========================================================
%                     SECANT METHOD
% ==========================================================

xs0 = x0;
xs1 = x1;

for i = 1:N

    % Secant formula
    xs2 = xs1 - f(xs1)*(xs1-xs0)/(f(xs1)-f(xs0));

    x_secant(i) = xs2;

    % Error
    if i == 1
        error_secant(i) = NaN;
    else
        error_secant(i) = abs(x_secant(i) - x_secant(i-1));
    end

    % Update
    xs0 = xs1;
    xs1 = xs2;

end


%% =========================================================
%                  REGULA-FALSI METHOD
% ==========================================================

a_r = a;
b_r = b;

for i = 1:N

    % Regula-Falsi formula
    c = (a_r*f(b_r) - b_r*f(a_r)) / ...
        (f(b_r) - f(a_r));

    x_rfp(i) = c;

    % Error
    if i == 1
        error_rfp(i) = NaN;
    else
        error_rfp(i) = abs(x_rfp(i) - x_rfp(i-1));
    end

    % Update interval
    if f(a_r)*f(c) < 0
        b_r = c;
    else
        a_r = c;
    end

end


%% =========================================================
%                       TABLE
% ==========================================================

Iteration = (1:N)';

T = table(Iteration, ...
          x_bisec, ...
          x_secant, ...
          x_rfp, ...
          error_bisec, ...
          error_secant, ...
          error_rfp);

T.Properties.VariableNames = { ...
    'Iteration', ...
    'x_bisec', ...
    'x_secant', ...
    'x_rfp', ...
    'error_bisec', ...
    'error_secant', ...
    'error_rfp'};

disp(' ');
disp('==============================================================');
disp('                 ITERATION TABLE');
disp('==============================================================');

disp(T);


%% =========================================================
%                 ROOTS AFTER N ITERATIONS
% ==========================================================

fprintf('\n');
fprintf('Approximate roots after %d iterations:\n', N);

fprintf('Bisection     = %.10f\n', x_bisec(N));
fprintf('Secant        = %.10f\n', x_secant(N));
fprintf('Regula-Falsi  = %.10f\n', x_rfp(N));


%% =========================================================
%                  CHECK 6 DECIMAL PLACES
% ==========================================================

fprintf('\nRoots correct to 6 decimal places:\n');

fprintf('Bisection     = %.6f\n', x_bisec(N));
fprintf('Secant        = %.6f\n', x_secant(N));
fprintf('Regula-Falsi  = %.6f\n', x_rfp(N));


%% =========================================================
%                     ERROR PLOT
% ==========================================================

figure;

semilogy(Iteration, error_bisec, '-o', ...
    'LineWidth', 1.5);

hold on;

semilogy(Iteration, error_secant, '-s', ...
    'LineWidth', 1.5);

semilogy(Iteration, error_rfp, '-^', ...
    'LineWidth', 1.5);

grid on;

xlabel('Iteration');
ylabel('Error');

title('Convergence of Root-Finding Methods');

legend('Bisection', ...
       'Secant', ...
       'Regula-Falsi', ...
       'Location','best');

hold off;