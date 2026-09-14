clc
close all
clear all

disp("===========part a====================")
P1 = 8;
ans_a = halley(P1);
fprintf("The cubic root of 800 is: %f\n", ans_a);

disp("===========part b====================")
P2 = 59071;
ans_b = halley(P2);
fprintf("The cubic root of 59071 is: %f\n", ans_b);

function x = halley(P)
    x = 10; %initial guess of cubic root of P
    E = 1; %error term
    
    while E > 0.00001
        x_next = x * (x^3 + 2*P) / (2*x^3 + P);
        E = abs((x_next - x) / x);
        x = x_next;
    end
end
