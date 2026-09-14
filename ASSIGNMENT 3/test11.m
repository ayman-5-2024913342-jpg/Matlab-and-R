clc;
close all;
clear all;x = [1200, 3500, 3200, 1500, 1700];
explode = [0 1 0 0 0];
p = pie(x, explode); % Create pie chart and get handles% Find text objects in the pie chart
pText = findobj(p, 'Type', 'text');% The pie chart returns handles in reverse order, so sort them by position
[~, idx] = sort(cellfun(@(h) h.Position(2), num2cell(pText)), 'descend');
pText = pText(idx);percentValues = get(pText, 'String');
txt = {'Dhaka : '; 'Sylhet : '; 'Chattogang : '; 'Rajshahi :'; 'Khulna :'};
combinedtxt = strcat(txt, percentValues);for k = 1:length(pText)
pText(k).String = combinedtxt{k};
endtitle('Rainfall Across Divisions');