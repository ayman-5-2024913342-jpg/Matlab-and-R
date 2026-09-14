clc
close all
clear all
format short
n = 19;
true_value = factorial(n)
app_value = (sqrt((2*n + 1/3)*pi))*(n^n)*(exp(-n))

%error
error = abs((true_value - app_value)/(true_value))