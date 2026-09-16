clc 
close all
clear all

A = readmatrix("a.txt")
b = readmatrix("b.txt")

%======================Part I=================================
Aug = [A, b]
R = rref(Aug)
x_exact = R(:, end)

%Diagonally Dominant
[~,max_cols] = max(abs(A), [] , 2);
A_dom (max_cols,:) = A
b_dom (max_cols) = b;

function [x, iter] = jacobi(A, b, x0, tol, max_iter)
    tol = 10^-5;
    n = length(b);
    x = x0;
    D = diag(A); 
    R = A - diag(A);
    
    for iter = 1:max_iter
       x_new = D \ (b - LU * x);
       
       if (max(abs(x_new - x) ./ abs(x_new)) < tol
           x = x_new;
           
       end
    end
end 