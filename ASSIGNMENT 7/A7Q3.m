% Given data
x = [-5, -4, -1, 1, 4, 6, 9, 10];
y = [12, 10, 6, 2, -3, -6, -11, -12];

% a) Determine coefficients m and b using polyfit (degree 1)
p = polyfit(x, y, 1);
m = p(1);
b = p(2);

fprintf('Slope (m) = %.4f\n', m);
fprintf('Y-Intercept (b) = %.4f\n', b);
fprintf('Best-fit equation: y = %.4fx + %.4f\n', m, b);

% b) Make a plot showing the function and the data points
figure;
scatter(x, y, 60, 'blue', 'filled', 'DisplayName', 'Data Points');
hold on;

% Generate smooth x-values for plotting the line
x_line = linspace(min(x) - 1, max(x) + 1, 100);
y_line = m * x_line + b;

plot(x_line, y_line, 'r-', 'LineWidth', 1.5, ...
    'DisplayName', sprintf('Best Fit Line: y = %.2fx + %.2f', m, b));

% Formatting the plot
grid on;
xlabel('x');
ylabel('y');
title('Linear Least-Squares Regression');
legend('Location', 'northeast');
hold off;