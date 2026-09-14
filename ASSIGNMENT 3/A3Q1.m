clc 
close all
clear all

x = [0:0.01:10];
y = (x.^2).*exp(-x);
y1 = 2*x.*exp(-x) - (x.^2).*exp(-x);
y2 = 2*exp(-x) + (x.^2).*exp(-x) - 4.*x.*exp(-x);

idx = find(x==3)

plot(x,y, '-','linewidth',2,'markersize',13)
hold on;
plot(x(idx), y(idx), 'o', 'MarkerFaceColor','green', 'markersize', 10);
plot(x(idx), y1(idx), 'o', 'MarkerFaceColor','red', 'markersize', 11);
plot(x(idx), y2(idx), 'o', 'MarkerFaceColor','black', 'markersize', 13);
%p1 = plot(3,0.0003921,'o','MarkerFaceColor','red');


plot(x,y1,'--','linewidth',3,'markersize',14)
plot(x,y2,':','linewidth',4,'markersize',15)
legend("y","y1","y2")