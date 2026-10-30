clc;
close all;
clear all;

% Define the position function y(t)
y = @(t) 8 - 4*(t.^3).*exp(-0.4*t) + 2*t.^2;

% Analytical First Derivative (Velocity): y'(t)
% Derived using product rule on -4*t^3*exp(-0.4*t)
y1 = @(t) 1.6*(t.^3).*exp(-0.4*t) - 12*(t.^2).*exp(-0.4*t) + 4*t;

% Analytical Second Derivative (Acceleration): y''(t)
% Derived using product rule on y'(t)
y2 = @(t) -0.64*(t.^3).*exp(-0.4*t) + 9.6*(t.^2).*exp(-0.4*t) - 24*t.*exp(-0.4*t) + 4;

% Plotting Position y(t)
subplot(3, 1, 1);
fplot(y, [0, 8], 'LineWidth', 1.5);
title('Position y(t)');
xlabel('t'); ylabel('y(t)');
grid on;

% Plotting Velocity y1(t)
subplot(3, 1, 2);
fplot(y1, [0, 8], 'LineWidth', 1.5);
title('Velocity y1(t)');
xlabel('t'); ylabel('y1(t)');
grid on;

% Plotting Acceleration y2(t)
subplot(3, 1, 3);
fplot(y2, [0, 8], 'LineWidth', 1.5);
title('Acceleration y2(t)');
xlabel('t'); ylabel('y2(t)');
grid on;