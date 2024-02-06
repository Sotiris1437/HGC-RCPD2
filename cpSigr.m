clear all
close all
clc
ani1 = 'delay_wl.xlsx';
node = xlsread(ani1);
[rows columns] = size(node);
%%
A = 0;
CP2 = [];
Cp1 = [];
Cp11 = [];
CP1 = [];
H00 = 0;
H11 = 0;
H000 = 0;
H111 = 0;
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
