clc
close all
clear all

Day = [1 2 3 4 5 6 7 8 9 10];
Max_Temp = [31 32 34 33 35 36 34 33 32 31];


Moving_Avg = movmean(Max_Temp, 7);

figure;
plot(Day, Max_Temp, '-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
hold on;
plot(Day, Moving_Avg, '-s', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');
hold off;


title('Daily Maximum Temperature and 7-Day Moving Average in Dhaka (July 2023)');
xlabel('Day');
ylabel('Maximum Temperature (°C)');
legend('Daily Max Temperature', '7-Day Moving Average', 'Location', 'best');
grid on;