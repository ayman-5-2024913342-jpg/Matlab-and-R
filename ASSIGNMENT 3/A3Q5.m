clc;
close all;
clear all;

% Symbolic work
syms t
y = 8 - 4*t^3*exp(-0.4*t) + 2*t^2;
y1 = diff(y,t);   % first derivative
y2 = diff(y,t,2); % second derivative

% Numeric evaluation
x = [0:0.1:8];
y1_num = double(subs(y1,t,x));
y2_num = double(subs(y2,t,x));


% Plotting
subplot(3,1,1);
%plot(x, double(subs(y,t,x)), 'LineWidth', 2);
fplot(y,[0,8])
title('Position x(t)');
xlabel('t'); ylabel('y(t)'); 

subplot(3,1,2);
%plot(x, y1_num, 'LineWidth', 2);
fplot(y1, [0,8])
title('Velocity y1(t)');
xlabel('t'); ylabel('y1(t)'); 

subplot(3,1,3);
%plot(x, y2_num, 'LineWidth', 2);
fplot(y2, [0,8])
title('Acceleration y2(t)');
xlabel('t'); ylabel('y2(t)'); 
