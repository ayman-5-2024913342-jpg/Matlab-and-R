clc;
close all;
clear all;

%% Step 1: Load Data
A = readmatrix("a.txt");
b = readmatrix("b.txt");

%====================== Part I: Gauss-Jordan Exact Solution ======================
Aug = [A, b];
R = rref(Aug);
x_exact = R(:, end);

disp('===================================================');
disp('--- (i) Exact Solution (Gauss-Jordan) ---');
disp(x_exact);

%====================== Part II: Positive Definiteness Check ======================
disp('--- (ii) Positive Definiteness Check ---');
check_eig(A);

%====================== Part III: Row Reordering for Convergence ======================
% Reorder rows so largest absolute elements sit on the main diagonal
[~, max_cols] = max(abs(A), [], 2);
A_dom = zeros(size(A));
b_dom = zeros(size(b));

for i = 1:length(b)
    A_dom(max_cols(i), :) = A(i, :);
    b_dom(max_cols(i)) = b(i);
end

% Set parameters for iterative methods
tol = 5e-5; % 5 significant digits (0.5 * 10^(1-5))
max_iter = 500;
x0 = zeros(size(b));

%====================== Part IV: Iterative Solvers ======================
disp('===================================================');
disp('--- Iterative Results (Correct to 5 Significant Digits) ---');

% (a) Jacobi Method
[x_jacobi, iter_j, status_j] = jacobi_method(A_dom, b_dom, x0, tol, max_iter);
fprintf('Jacobi Solution (%d iterations, Status: %s):\n', iter_j, status_j);
disp(x_jacobi);

% (b) Gauss-Seidel Method
[x_gs, iter_gs, status_gs] = gauss_seidel_method(A_dom, b_dom, x0, tol, max_iter);
fprintf('Gauss-Seidel Solution (%d iterations, Status: %s):\n', iter_gs, status_gs);
disp(x_gs);

% (c) SOR Method (omega = 1.1)
omega = 1.1;
[x_sor, iter_sor, status_sor] = sor_method(A_dom, b_dom, x0, omega, tol, max_iter);
fprintf('SOR (omega = 1.1) Solution (%d iterations, Status: %s):\n', iter_sor, status_sor);
disp(x_sor);


%=================================================================================
%                               LOCAL FUNCTIONS
%=================================================================================

function [] = check_eig(a) 
    % Positive definiteness requires symmetry: A = A'
    if ~isequal(a, a')
        disp("Matrix A is NOT Positive Definite.");
        disp("Reason: Matrix is asymmetric (A ~= A').");
        return;
    end
    
    eigen = eig(a); 
    if all(eigen > 0) 
        disp("Matrix A is Positive Definite."); 
    else 
        disp("Matrix A is NOT Positive Definite (Eigenvalues <= 0)."); 
    end
end

function [x, iter, status] = jacobi_method(A, b, x0, tol, max_iter)
    n = length(b);
    D = diag(diag(A));
    LU = A - D;
    x = x0;
    status = 'Converged';
    
    for iter = 1:max_iter
        x_new = D \ (b - LU * x);
        
        % Divergence Guard
        if any(isnan(x_new)) || any(isinf(x_new)) || max(abs(x_new)) > 1e10
            status = 'Diverged';
            x = x_new;
            return;
        end
        
        % Relative Error Check
        if max(abs(x_new - x) ./ (abs(x_new) + 1e-12)) < tol
            x = x_new;
            return;
        end
        x = x_new;
    end
    status = 'Max iterations reached';
end

function [x, iter, status] = gauss_seidel_method(A, b, x0, tol, max_iter)
    L_D = tril(A); % Lower triangular + Diagonal
    U = triu(A, 1); % Upper triangular
    x = x0;
    status = 'Converged';
    
    for iter = 1:max_iter
        x_new = L_D \ (b - U * x);
        
        if any(isnan(x_new)) || any(isinf(x_new)) || max(abs(x_new)) > 1e10
            status = 'Diverged';
            x = x_new;
            return;
        end
        
        if max(abs(x_new - x) ./ (abs(x_new) + 1e-12)) < tol
            x = x_new;
            return;
        end
        x = x_new;
    end
    status = 'Max iterations reached';
end

function [x, iter, status] = sor_method(A, b, x0, omega, tol, max_iter)
    D = diag(diag(A));
    L = tril(A, -1);
    U = triu(A, 1);
    
    M = D + omega * L;
    N = (1 - omega) * D - omega * U;
    c = omega * (M \ b);
    T = M \ N;
    
    x = x0;
    status = 'Converged';
    
    for iter = 1:max_iter
        x_new = T * x + c;
        
        if any(isnan(x_new)) || any(isinf(x_new)) || max(abs(x_new)) > 1e10
            status = 'Diverged';
            x = x_new;
            return;
        end
        
        if max(abs(x_new - x) ./ (abs(x_new) + 1e-12)) < tol
            x = x_new;
            return;
        end
        x = x_new;
    end
    status = 'Max iterations reached';
end