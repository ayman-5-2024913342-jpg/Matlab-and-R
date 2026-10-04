clc; close all; clear all;

% Data setup: Rows = Years (2020-2023), Columns = Cities (Dhaka, Sylhet, Chattogram, Rajshahi, Khulna)
years = [2020; 2021; 2022; 2023];
rainfall_matrix = [
    850, 920, 780, 690, 860;
    900, 890, 820, 720, 880;
    870, 940, 790, 700, 890;
    910, 930, 810, 740, 870
];
city_names = {'Dhaka', 'Sylhet', 'Chattogram', 'Rajshahi', 'Khulna'};

%% a) Grouped Bar Chart
figure('Name', 'Grouped Bar Chart - Annual Rainfall', 'Position', [100, 100, 850, 500]);
bar(years, rainfall_matrix, 'grouped');
title('Annual Rainfall of Cities in Bangladesh (2020-2023)', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Year', 'FontSize', 12);
ylabel('Rainfall (mm)', 'FontSize', 12);
legend(city_names, 'Location', 'northeastoutside');
grid on;

%% b) 3D Pie Chart of Total Rainfall Contribution
% Calculate total rainfall across all 4 years for each city
total_rainfall = sum(rainfall_matrix, 1);

figure('Name', '3D Pie Chart - Rainfall Contribution', 'Position', [150, 150, 750, 650]);
pie3(total_rainfall);
title('City Contribution to Total Rainfall (2020-2023)', 'FontSize', 14, 'FontWeight', 'bold');
legend(city_names, 'Location', 'northeastoutside');