clc 
clear all
close all

format long
%format rational

disp("==================")
disp("    PART A        ")
disp("==================")

n = [1:5];
s = (n.^2)./(2.^n);
sum(s)

disp("==================")
disp("    PART B        ")
disp("==================")

n = [1:15];
s = (n.^2)./(2.^n);
sum(s)

disp("==================")
disp("    PART C        ")
disp("==================")

n = [1:30];
s = (n.^2)./(2.^n);
sum(s)