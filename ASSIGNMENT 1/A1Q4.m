clc 
clear all
close all

format short

k = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75; 2, 4, 6, 8, 10, 12, 14; 25, 30, 35, 40, 45, 50, 55;]

disp("========")
disp("[Part A]")
disp("========")
row_1 = [k(1,1:2) k(1,6:7)];
row_2 = [k(3,1:2), k(3,6:7)];
MAT_a = [row_1; row_2;];
ka = MAT_a

disp("========")
disp("[Part B]")
disp("========")
row_a = [k(:,2)' k(:,5)'];
row_b = k(2, 1:6);
row_c = k(3, 2:7);

kb = [row_a; row_b; row_c;]

