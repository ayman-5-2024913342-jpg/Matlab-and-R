clc
close all
clear all

x = [1200, 3500, 3200, 1500, 1700];
di = {'Dhaka' 'Sylhet' 'Chattogang' 'Rajshahi' 'Khulna'}

explode = [0 1 0 0 0];

pie(x,explode)

legend(di)

title("Rainfall Across Divisions")
