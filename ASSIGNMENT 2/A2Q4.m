clc
close all
close all

format short

r = 14;
h_vals = [0:2:14];

%V = round(pi*r^2.*h_vals);
V = round(pi*r^2.*h_vals);
%round(V);

mat(1,:) = h_vals;
mat(2,:) = V;

MAT = mat';
disp("  HEIGHT   VOLUME")
disp(table(MAT))