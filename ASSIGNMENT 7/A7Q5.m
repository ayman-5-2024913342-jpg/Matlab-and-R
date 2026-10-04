clc; close all; clear all;
% Define time vector from 0 to 20 s with high resolution
t = linspace(0, 20, 1000);

% Calculate position coordinates as a function of time
x = 0.01 .* (30 - t).^2 .* sin(2 * t);
y = 0.01 .* (30 - t).^2 .* cos(2 * t);
z = 0.5 .* t.^1.5;

% Create 3D figure
figure('Name', 'Particle Trajectory', 'Position', [100, 100, 800, 600]);
plot3(x, y, z, 'LineWidth', 1.8, 'Color', 'b');
hold on;

% Mark the start (t = 0 s) and end (t = 20 s) positions
scatter3(x(1), y(1), z(1), 80, 'green', 'filled', 'DisplayName', 'Start (t = 0 s)');
scatter3(x(end), y(end), z(end), 80, 'red', 'filled', 'DisplayName', 'End (t = 20 s)');

% Format axes and labels
grid on;
xlabel('X Position');
ylabel('Y Position');
zlabel('Z Position');
title('3D Trajectory of the Moving Particle (0 \le t \le 20 s)');
legend('Trajectory', 'Start', 'End', 'Location', 'best');
view(3); % Set standard 3D view angle
hold off;