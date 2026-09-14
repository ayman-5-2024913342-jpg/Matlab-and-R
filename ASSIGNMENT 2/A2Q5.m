clc
close all
clear all

%size = input("Enter thy size of grade array ");
%size = 3
%grades = (1:size);

%for k = 1:1:size
%    %disp(k)
%    g = input("Enter value ");
%    grades(k) = g;
%end [93 77 51 62 99 41 82 77 71 68 100 46 78 80 83]
grades = input("Enter thy grades ")

len_values = (length(grades));
avg_values = (mean(grades));
std_values = (std(grades));

fprintf("\n")
fprintf('The are %5.2f grades; \n', len_values);
fprintf('The avg grade is %5.2f; \n', avg_values);
fprintf('Standard Deviation is %5.2f; \n', std_values);

