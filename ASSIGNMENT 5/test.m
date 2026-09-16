clc
close all
clear all

global a;
a = 5;

disp_prog();

function disp_prog()
    global a
    disp(a)
end