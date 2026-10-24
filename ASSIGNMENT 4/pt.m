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