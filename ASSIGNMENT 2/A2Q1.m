clc 
clear all 
close all

format rational

v = [5 4 3 2]

disp("==================")
disp("    PART A        ")
disp("==================")

V = v + v;
a = 1 ./ V

disp("==================")
disp("    PART B        ")
disp("==================")

b = v.^v

disp("==================")
disp("    PART C        ")
disp("==================")

c = v./sqrt(v)

disp("==================")
disp("    PART D        ")
disp("==================")

d = (v.^2)./(v.^v)
