generate_rao_bell_nozzle()

function generate_rao_bell_nozzle()
    % --- 1. Nozzle Input Parameters ---
    R_t = 15.0;            % Throat radius (mm)
    expansion_ratio = 8.0; % Area expansion ratio (A_e / A*)
    percent_length = 85;   % % length of equivalent 15-deg conical nozzle
    theta_i = 28;          % Initial divergent parabola wall angle (degrees)
    theta_e = 9;           % Exit wall angle (degrees)
    num_points = 100;      % Resolution for divergent bell section

    % --- 2. Geometric Calculations ---
    R_e = R_t * sqrt(expansion_ratio);
    
    % Reference 15-degree conical length
    L_15 = (R_e - R_t) / tand(15);
    L_n = (percent_length / 100.0) * L_15;
    
    % Radians for trigonometric evaluations
    t_i = deg2rad(theta_i);
    t_e = deg2rad(theta_e);
    
    % --- 3. Convergent Region ---
    R_chamber = R_t * 2.5;
    theta_conv = deg2rad(30); % Standard 30-deg contraction angle
    
    x_conv_start = - ((R_chamber - R_t) / tan(theta_conv));
    x_conv = linspace(x_conv_start, -0.382 * R_t, round(num_points / 2));
    y_conv = R_chamber - (x_conv - x_conv_start) * tan(theta_conv);
    
    % --- 4. Throat Region (Circular Arc Downstream) ---
    r_dn = 0.382 * R_t;
    x_i = r_dn * sin(t_i);
    y_i = R_t + r_dn * (1 - cos(t_i));
    
    theta_arc = linspace(0, t_i, 20);
    x_throat_arc = r_dn * sin(theta_arc);
    y_throat_arc = R_t + r_dn * (1 - cos(theta_arc));
    
    % --- 5. Divergent Parabolic Bell Section ---
    x_e = L_n;
    y_e = R_e;
    
    m1 = tan(t_i);
    m2 = tan(t_e);
    
    % Quadratic Bezier Control Point Intersection
    x_c = (y_e - y_i + m1 * x_i - m2 * x_e) / (m1 - m2);
    y_c = y_i + m1 * (x_c - x_i);
    
    % Parabolic parameter t from 0 to 1
    t = linspace(0, 1, num_points);
    x_div = (1 - t).^2 * x_i + 2 * (1 - t) .* t * x_c + t.^2 * x_e;
    y_div = (1 - t).^2 * y_i + 2 * (1 - t) .* t * y_c + t.^2 * y_e;
    
    % Combine full profile coordinates
    x_full = [x_conv, x_throat_arc, x_div];
    y_full = [y_conv, y_throat_arc, y_div];
    
    % --- 6. Visualization in MATLAB ---
    fig = figure('Color', [0.12 0.12 0.18], 'Position', [100 100 1000 500]);
    ax = axes('Parent', fig, 'Color', [0.12 0.12 0.18], 'XColor', 'w', 'YColor', 'w');
    hold(ax, 'on');
    grid(ax, 'on');
    set(ax, 'GridColor', [0.3 0.3 0.4], 'GridAlpha', 0.6, 'GridLineStyle', '--');
    
    % Upper & Lower Nozzle Walls
    plot(ax, x_full, y_full, 'Color', '#00d2ff', 'LineWidth', 2.5, 'DisplayName', 'Nozzle Wall Contour');
    plot(ax, x_full, -y_full, 'Color', '#00d2ff', 'LineWidth', 2.5, 'HandleVisibility', 'off');
    
    % Centerline Axis
    yline(ax, 0, '--w', 'Centerline Axis', 'Alpha', 0.5, 'LineWidth', 1, 'Color', 'w', 'DisplayName', 'Centerline Axis');
    
    % Gas Flow Domain Fill
    patch(ax, [x_full, fliplr(x_full)], [y_full, -fliplr(y_full)], [0 0.82 1], ...
          'FaceAlpha', 0.08, 'EdgeColor', 'none', 'HandleVisibility', 'off');
      
    % Key Stations
    xline(ax, x_conv_start, ':r', 'Chamber Inlet', 'Color', '#ff4757', 'Alpha', 0.7, 'LineWidth', 1.2);
    xline(ax, 0, ':y', 'Throat (M = 1.0)', 'Color', '#ffa502', 'Alpha', 0.7, 'LineWidth', 1.2);
    xline(ax, L_n, ':g', 'Exit Geometry', 'Color', '#2ed573', 'Alpha', 0.7, 'LineWidth', 1.2);
    
    % Formatting
    title(ax, '2D Rao Parabolic Bell Nozzle Profile', 'Color', 'w', 'FontSize', 13, 'FontWeight', 'bold');
    xlabel(ax, 'Axial Distance X (mm)', 'Color', 'w', 'FontSize', 11);
    ylabel(ax, 'Radial Distance Y (mm)', 'Color', 'w', 'FontSize', 11);
    axis(ax, 'equal');
    legend(ax, 'Location', 'southwest', 'TextColor', 'w', 'Color', [0.1 0.1 0.15], 'EdgeColor', [0.3 0.3 0.4]);
    
    % --- 7. Export CSV for SolidWorks (X, Y, Z) ---
    z_full = zeros(size(x_full));
    data_out = [x_full', y_full', z_full'];
    
    writematrix(data_out, 'solidworks_nozzle_curve.csv');
    fprintf('Exported %d points to "solidworks_nozzle_curve.csv"\n', length(x_full));
end