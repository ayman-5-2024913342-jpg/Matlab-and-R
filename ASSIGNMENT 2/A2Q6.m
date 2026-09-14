clc
clear
close all

T = [80 82 84 86 88 90 92 94];
R = [50 55 60 65 70 75]';

[t,r] = meshgrid(T,R);

HI = round(-42.379 + 2.04901523*T + 10.14333127*R - 0.22475541*(T.*R) - 6.83783e-3*(T.^2) - 5.481717e-2*(R.^2) + 1.22874e-3*(T.^2).*R + 8.5282e-4*T.*(R.^2) - 1.99e-6*(T.^2).*(R.^2));



disp("                            Temperature (F)   ")
%disp(T)
fprintf("%12i %5i %5i %5i %5i %5i %5i %5i %5i %5i \n", T)
fprintf("\n")
disp("Relative")
disp("Humidity")
disp("     (%)")
hi(:,2:9)=HI;
hi(:,1)=R;
disp(hi)

