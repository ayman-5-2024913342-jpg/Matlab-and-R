clc; 
close all;
clear all;

A = readmatrix("a.txt")
b = readmatrix("b.txt")

%======================Part I=================================
Aug = [A, b];
R = rref(Aug);
x_exact = R(:, end)

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
    n = length(b);
    x = x0;
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