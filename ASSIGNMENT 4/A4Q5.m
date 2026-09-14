clc
close all
clear
format long

n_values = [5, 10, 40, 45, 55];

print_prog(n_values)


v = [1 2 3 6 9]
disp(v(0))

function p = print_prog(n_values)
    disp("First func")
    for k = 1:length(n_values)
        n = n_values(k);
        PI = estimate_pi_cubic(n);
        fprintf("The estimation of pi for n = %d: %.6f; error(rel) = %.6f\n", n, PI, abs(PI - pi)/pi);
    end
end

function PI = estimate_pi_cubic(n)
    sum_val = 0;

    for i = 0:(n-1)
        sum_val = sum_val + ( (-1)^i / (2*i + 1)^3 );
    end

    PI = (32 * sum_val)^(1/3);
end
 