clear all
close all
clc
ani1 = 'delay_wl.xlsx';
node = xlsread(ani1);
[rows columns] = size(node);
%%
CP2 = [];
for j = 1
figure(j)    
Xt = node(1:9500,j);
hold on
plot(Xt)
%
plot(Xt)
hold on
CP2 = RCPD3(Xt,2000,50,0.95,0,100,30,150);
hold on
for i = 1:length(CP2)
    hold on
    plot([CP2(i) CP2(i)],[min(Xt) max(Xt)],'linewidth',2,'color','r');
end
hold on
box on
grid on
end
