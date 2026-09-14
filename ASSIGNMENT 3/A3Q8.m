
clc
close all
clear all

MONTHS = categorical({'Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sep' 'Oct' 'Nov' 'Dec'})

TEMP = [18 21 26 29 30 31 30 30 29 27 24 20];

b = bar(TEMP)
xticklabels(MONTHS)

b.FaceColor = "flat";

b.CData(3:6, :) = repmat([1 0 0], 4,1);       
b.CData(11:12, :) = repmat([0 1 1], 2,1);
b.CData(1:2, :) = repmat([0 1 1], 2,1);  

hold on


summer = bar(NaN, 'FaceColor', [1 0 0]);
winter = bar(NaN, 'FaceColor', [0 1 1]);
title("Monthly avg temp")
legend('Winter', 'Summer')
%legend({'Line 1','Line 2'})
%legend({'cos(x)','cos(2x)','cos(3x)','cos(4x)'},'Location','northwest','NumColumns',2)
%legend([summer, winter], {'Summer', 'Winter'});