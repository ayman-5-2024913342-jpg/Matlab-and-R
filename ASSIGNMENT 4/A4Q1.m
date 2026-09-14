clc 
close all
clear all

m = 4;
n = 6;
Z = disp_prog(m,n)

function A = disp_prog(m,n)
    A = zeros(m,n);    
    
    for i = 1:m
       for j = 1:n
            A(i,j) = 2*i - 3*j;
       end
    end
end

