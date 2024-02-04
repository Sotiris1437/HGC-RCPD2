clear all
close all
clc
CP_t = [0 0 0 0];
R1 = 0;
R0 = 0;
R_21 = 0;
R_20 = 0;
R_31 = 0;
R_30 = 0;
Rep = 200;
for jj = 1:Rep
    jj
a = unifrnd(0,0.4);
b = unifrnd(0,0.2);
c = unifrnd(0.01,0.1);
d = unifrnd(0,0.2);
e = unifrnd(0,0.4);
N = 1000;
m = 1;
vmdl1 = garch('Constant',c,'GARCH',a,'ARCH',b);
Mdl1 = arima('Constant',0,'AR',d,'MA',e,...
    'Variance',vmdl1);
[Y1,E] = simulate(Mdl1,N);
vmdl2 = garch('Constant',c,'GARCH',a,'ARCH',b);
Mdl2 = arima('Constant',m,'AR',d,'MA',e,...
    'Variance',vmdl2);
[Y2,E] = simulate(Mdl2,N); 
Xt = [ Y1;Y2 ];
Xt = Xt;
true = 1;
%% RCPD2
[CP_total2,pos2] = RCPD3(Xt,80,50,0.95,0,40,5,50);
CP_tR2(1:length(CP_total2),jj) = CP_total2;
if pos2 == true
    R_21 = R_21 + 1;
    CP2(R_21) = abs(CP_total2-N);
end
if pos2 > true
    R_20 = R_20 + 1;
end
%% RCPD2
[CP_total3,pos3] = RCPD3(Xt,80,50,0.95,0,40,10,50);
CP_tR3(1:length(CP_total3),jj) = CP_total3;
if pos3 == true
    R_31 = R_31 + 1;
    CP3(R_31) = abs(CP_total3-N);
end
if pos3 > true
    R_30 = R_30 + 1;
end
end
RCP = R1/Rep
R0/Rep
%CUSU(window) = C1
RCP2 = R_21/Rep
R_20/Rep
RCP3 = R_31/Rep
R_30/Rep
C11 = median(CP1) 
C22 = median(CP2)
C33 = median(CP3)
%RCPH(window) = RH1
%Bayes(window) = B1



