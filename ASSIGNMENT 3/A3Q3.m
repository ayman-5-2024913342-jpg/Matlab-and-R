%y = @(x) (x.^2 - 6.*x + 7)/(x.^3 - 8)

%fplot(y, [0 1.9], 'b');
%hold on;
%fplot(y, [2.1 4], 'b');

clc;
close all;
clear all;

x1 = [0:0.01:1.9];
x2 = [2.1:0.01:4];

y1 = (x1.^2 - 6.*x1 + 7) ./ (x1.^3 - 8);
y2 = (x2.^2 - 6.*x2 + 7) ./ (x2.^3 - 8);

plot(x1, y1, '-', 'LineWidth', 2, 'MarkerSize', 13);
hold on;
plot(2, 0);
plot(x2, y2, '--', 'LineWidth', 4, 'MarkerSize', 14);

legend("y on [0,1.9]", "y on [2.1,4]");
%title('Plot of y = (x^2 - 6x + 7)/(x^3 - 8)');
%grid on;
