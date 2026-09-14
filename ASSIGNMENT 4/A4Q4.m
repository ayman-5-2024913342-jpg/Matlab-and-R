clc 
close all
clear all

n = 4;
fprintf("Pascals trig for n = %d\n",n)
P4 = Pascals_trig(n);

%disp(P4);

n = 9;
fprintf("Pascals trig for n = %d\n",n)
P7 = Pascals_trig(n);

%disp(P7);

function p = Pascals_trig(n)
    p = zeros(n, n);
    
    for i = 1:n
        for j = 1:i
            p(i, j) = factorial(i - 1) / (factorial(j - 1) * factorial(i - j));
            fprintf('%5d',p(i,j))
        end
        fprintf("\n")
    end
    fprintf("\n")
end