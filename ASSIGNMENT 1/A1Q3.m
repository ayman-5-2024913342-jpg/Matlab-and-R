clc
close all
clear all

a = [5,8,-1,0,2];
b = [4,1,9,-2,3];
c = [-3,5,0,6,1];

disp("========")
disp("[Part a]")
disp("========")
vector_a = [a(:,1:3) b(:,1:3) c(:,1:3)]

disp("========")
disp("[Part b]")
disp("========")
%vector_b = [a(3:5) b(3:5) c(3:5)]'
vector_b = vector_a'

disp("========")
disp("[Part c]")
disp("========")
MAT_c = [a; b; c;]

disp("========")
disp("[Part d]")
disp("========")
MAT_d = [c(1:5); b(1:5); a(1:5);]'

disp("========")
disp("[Part e]")
disp("========")
MAT_e = [a(2:4); b(3:5); c(1:3);]