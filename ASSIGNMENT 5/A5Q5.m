<<<<<<< HEAD
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
=======
clc; 
close all;
clear all;

A = readmatrix("a.txt");
b = readmatrix("b.txt");

%======================Part I=================================
Aug = [A, b];
R = rref(Aug);
x_exact = R(:, end)


x = [0; 0; 0; 0; 0;]

%====================Part II==================================
%Diagonally Dominant
[~,max_cols] = max(abs(A), [] , 2);
A_dom (max_cols,:) = A;
b_dom (max_cols) = b;

%ns = jacobi(A, b, zeros(size(b)), 100);   % <- the one fix you need (see below)
%n = numel(ns);
jacobi(A,b, 0, 100)

function [x, iter, err] = jacobi(A, b, x0, max_iter)
    tol = 10^-5;
>>>>>>> f3c9d3c8d02da75f1a2bded44b87d29adb2a484b
    n = length(b);
    D = diag(diag(A));
    LU = A - D;
    x = x0;
<<<<<<< HEAD
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
=======
    D = diag(A); 
    R = A - diag(D);
    
    if any(D == 0)
        error("Zero on diagonal. Reaarange terms.")
    end

    for iter = 1:max_iter
       x_new = (b - R*x) ./ D;
       
       err = norm(x_new - x, inf);
        
       x = x_new;

       if (max(abs(x_new - x) ./ abs(x_new))) < tol
           return;
       end
       
    end
end 

%================== Part III =======================================
gauss_sed(A, b, x, 500)

function [iter, x, err, table_data] = gauss_sed(A, b, x0, max_iter)
    n = length(b);
    tol = 10e-5;
    x = x0;

    table_data = zeros(max_iter + 1, n + 2);
    table_data(1,:) = [0, x', 0];

    for iter = 1:max_iter
        x_old = x;

        for i = 1:n
            
            d = b(i);
            
            for j = 1:n
                if i ~= j
                    d = d - A(i,j) * x(j);
                end
            end

            x(i) = d / A(i,i);
        end
        
        err = max(abs(x - x_old));

        table_data(iter+1,:) = [iter, x', err];

        if err < tol
            break;
        end
        
    end
    table_data = table_data(1:iter+1,:);
end

%============================== Part IV %==================================
x = [0; 0; 0; 0; 0;];

[x, iter, err, table_data] = sor_(A, b, x, 1.2, 700);

T = array2table(table_data, 'VariableNames', {'iteration','x1','x2','x3','x4','x5', 'error'});
disp(T);
disp("The solution ")
disp(x)


function [x, iter, err, table_data] = sor_(A, b, x0, w, max_iter)
    n = length(b);
    tol = 1e-5;
    x = x0;

    table_data = zeros(max_iter + 1, n + 2);
    table_data(1,:) = [0, x', 0]; 

    for iter = 1:max_iter
        x_old = x;
        for i = 1:n
            d = b(i);
            x_old = x;

            for j = 1:n
                if i ~= j
                    d = d - A(i,j)*x(j);
                end
            end

            x_gs = d/A(i,i);
            x(i) = (1-w) * x_old(i) + w*x_gs;

        end

        err = max(abs(x-x_old));
        table_data(iter+1,:) = [iter,x',err];

        if err < tol
            break;
        end

    end
    table_data = table_data(1:iter+1,:);
>>>>>>> f3c9d3c8d02da75f1a2bded44b87d29adb2a484b
end