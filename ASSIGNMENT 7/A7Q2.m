clc; close all; clear all;

x_data = [0.9, 1.5, 3, 4, 6, 8, 9.5];
y_data = [0.9, 1.5, 2.5, 5.1, 4.5, 4.9, 6.3];

% 1. Create a smooth x array that spans your ENTIRE dataset (from 0.9 to 9.5)
x_fit = linspace(min(x_data), max(x_data), 200);

% 2. Plot the raw data exactly ONCE
figure;
plot(x_data, y_data, 'ko', 'MarkerSize', 8, 'LineWidth', 2, 'MarkerFaceColor', 'k'); 
hold on; % Keep the window open so everything layers together

% 3. Create a cell array to dynamically build the legend entries
legend_labels = {'Original Data'};

% 4. Loop through degrees 1 to 6 to fit, evaluate, and plot each curve
for i = 1:6
    p = polyfit(x_data, y_data, i);
    y_fit = polyval(p, x_fit);
    
    plot(x_fit, y_fit, 'LineWidth', 2); 
    
    % Append the degree label to our legend list
    legend_labels{end+1} = ['Degree ' num2str(i)];
end

% 5. Apply graph styles AFTER all data has been plotted
grid on;
xlabel('X Data');
ylabel('Y Data');
title('Polynomial Curve Fitting (Degrees 1-6)');
legend(legend_labels, 'Location', 'best');

hold off; % Release the plot
