clc
close all
clear all

A = [25 40 60 70 32 0; 1 1 1 1 1 1; 0 -1 1 0 0 0; 0 1 0 1 -10 0; -1 1 1 0 0 0; 1 0 1 0 -4 -4]
%x = ['STUDENT'; 'ALUMNI'; 'FACULTY'; 'PUBLIC'; 'VETERANS'; 'G';]
b = [4897000; 100000; -11000; 0; 0; 0;]

x = round((A^-1)*b)


student = x(1)
alumni = x(2)
faculty = x(3)
public = x(4)
veterans = x(5)
guests = x(6)