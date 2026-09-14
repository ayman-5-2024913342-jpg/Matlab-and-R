clc;
close all;
clear;

N = 10000;
[z] = Mersp(N)

length(z)

function v = Mersp(N)
    cnt = 1;
    for i = 1:N
        p(i) = 2^i - 1;
        
        if isprime(p(i))
            
            %temp = p(i)
            %fprintf("%dth mersone prime is %d", i, p(i))
            v(cnt) = p(i);
            cnt = cnt + 1;
        end

        if p(i) > 10000
            break;
        end 
        
    end
    %length(v)   
end