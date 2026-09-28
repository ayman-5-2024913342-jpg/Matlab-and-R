clc; close all; clear all;

A = [4 1 2;
     3 5 1;
     1 1 3];

b = [4 7 3]';

aug = [A, b];

x0 = [0; 0; 0;];

[x, iter, err, table_data] = gauss_sed(A, b, x0, 600);

% Display iteration table
T = array2table(table_data, ...
    'VariableNames', {'Iteration','x1','x2','x3','Error'});

disp(T);


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