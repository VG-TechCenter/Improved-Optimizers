clc;
clear;
close all
data1=rand(200,2);
figure
scatter(data1(:,1),data1(:,2),'.');
box on 
grid on
title('Ëæ»úĞòÁĞ')

p = sobolset(2);
data2=p(1:200,:);
figure
scatter(data2(:,1),data2(:,2),'.');
box on 
grid on
title('SobelĞòÁĞ')