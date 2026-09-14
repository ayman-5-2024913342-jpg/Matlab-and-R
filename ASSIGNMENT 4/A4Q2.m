clc
close all
clear all

%disp("Original Vector")
Z = input("Enter the vectos: \n");
X=disp_prog(Z);
disp("Modified Vectors")
disp(X)

function [A] = disp_prog(Z) 
    
    n = length(Z);

    %disp("OG Vector")
    %disp(A)
    %fprintf("\n")
    for i = 1:n
        if Z(i) > 0
            A(i) = 2 * Z(i);
        else
            A(i) = 3 * Z(i);
        end
    end
end

