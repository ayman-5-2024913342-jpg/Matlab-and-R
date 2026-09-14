clc;
close all;
clear all;

t = [10:10:70];
h = [9 22 44 63 80 94 97];

H = @(t) (100.8) ./ (1 + 23 .* exp(-0.093 .* t));

fplot(H)
hold on;
plot(t, h, 'o', 'LineWidth', 2, 'MarkerSize', 8)
%flpot(
%hold on;
%plot(t, H, '-', 'LineWidth', 2);

legend("Measured h", "Model H");
xlabel('t');
ylabel('h, H');
title('Comparison of Measured and Model Values');
grid on;
