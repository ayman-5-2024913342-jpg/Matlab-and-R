clc
close all
clear all

format short

a = 27;
b = 43;
c = 57;

disp("part a")
%ANGLE Y
ALPHA = acosd((a^2 - b^2 - c^2)/(-2*b*c))
BETA = acosd((b^2 - c^2 - a^2)/(-2*a*c))
GAMMA = acosd((c^2 - a^2 - b^2)/(-2*a*b))

disp("part b")
LHT = ( b - c ) / ( b + c )
RHT = (tand(1/2*(BETA - GAMMA))) / (tand(1/2*(BETA + GAMMA))) 

