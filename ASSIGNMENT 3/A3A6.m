clc
close all
clear all

figure(1)

fimplicit(@(x,y) x.^(2).^(1/3) + y.^(2).^(1/3) - 1)
title("Cartesian Equation")


figure(2)

x = @(t) (cos(t)).^3
y = @(t) (sin(t)).^3

%fplot(x,y, [-pi pi])

fplot(x, y, [-pi pi], 'r');
title("Parametric Equation")
%legend("Implicit curve", "Parametric curve");
%xlabel('x');
%ylabel('y');

