clc;
close all;
clear all;

% Define the function and its analytical derivatives using anonymous handles
y  = @(x) (x.^2) .* exp(-x);
y1 = @(x) 2*x .* exp(-x) - (x.^2) .* exp(-x);
y2 = @(x) 2*exp(-x) + (x.^2) .* exp(-x) - 4*x .* exp(-x);

% Plotting the functions over the interval [0, 10]
fplot(y, [0, 10], 'b');
hold on;
fplot(y1, [0, 10], 'g');
fplot(y2, [0, 10], 'r');
grid on;

legend("y", "y1", "y2");
hold off;