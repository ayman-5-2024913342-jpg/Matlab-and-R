clc 
close all 
clear all

A = eye(2,2)
B = ones(1,2)
C = zeros(3,3)

D(1:3, 1:3) = C;
D(3, 4:5) = B;
D(1:2, 4:5) = A

