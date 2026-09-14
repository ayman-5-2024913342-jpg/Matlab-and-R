clc 
close all
clear all

syms x
%x = [0:0.01:10];
y = @(x) (x.^2).*exp(-x);
%y1 = @(x) 2*x.*exp(-x) - (x.^2).*exp(-x);
%y2 = @(x) 2*exp(-x) + (x.^2).*exp(-x) - 4.*x.*exp(-x);

y1 = diff(y, x)
y2 = diff(y, x, 2)

fplot(y, [0 10],'b');
hold on;
fplot(y1, [0 10],'g');
fplot(y2, [0 10],'r');
legend("y","y1","y2")