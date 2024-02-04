clear all
close all
clc
warning ('off')
CP_t = [0 0 0 0];
r_val = [1 1.5 1.75 2 2.25 2.5 2.75 3 3.25 3.5 3.75 4 4.25 4.5 4.75 5 5.25 5.5];
lengt = [100,150,200,250,300,350,400,450,500,550,600,650,700];
w1 = 0;
w2 = 0;
true = 1;
lengt = [100,200,300,400,500,600];
M = 100;
for p = 1:length(r_val)
    w1 = w1 + 1;
    w2 = 0;
    B0 = 0;
    B1 = 0;
    C0 = 0;
    C1 = 0;
    R0 = 0;
    R1 = 0;
    R_20 = 0;
    R_21 = 0;
    RH0 = 0;
    RH1 = 0;
    B1 = 0;
    B0 = 0;
    m = r_val(p)
for l = 1:length(lengt)
    B0 = 0;
    B1 = 0;
    C0 = 0;
    C1 = 0;
    R0 = 0;
    R1 = 0;
    R_20 = 0;
    R_21 = 0;
    RH0 = 0;
    RH1 = 0;
    B1 = 0;
    B0 = 0;
    len = lengt(l);
    w2 =w2 + 1;
for jj = 1:M
v1 = unifrnd(0.25,1.25);
r1 = lognrnd(0,v1,[1 len]);
r2 = lognrnd(m,v1,[1 len]);
Xt = [r1 r2]';
%% RCPD2
[CP_total2,pos2] = RCPD3(Xt,80,50,0.95,0,40,10,50);
CP_tR2(1:length(CP_total2),jj) = CP_total2;
if pos2 == true
    R_21 = R_21 + 1;
end
if pos2 > true
    R_20 = R_20 + 1;
end
%% HOGA
% [CP_total3,pos3] = window_hoga(Xt,70,50,0.95,0,60);
% CP_tRH1(1:length(CP_total3),jj) = CP_total3;
% if pos3 == true
%     RH1 = RH1 + 1;
% end
% if pos3 > true
%     RH0 = RH0 + 1;
% end
%% R - BOCPD
% NbrRuns= 50; % Nbr Runs
% 
% [CP_Mod]= Restarted_BOCPD(Xt, NbrRuns); 
% 
% CP_Mod = mean(CP_Mod,1);
% 
% CP = 0;
% for i = 101:length(Xt) 
%     if CP_Mod(i) - CP_Mod(i-30) > 50  
%         CP = CP + 1;
%         CP_est(CP) = i;
%     end
% end
% CP_tel = unique(CP_est);
% for j = 2:length(CP_tel) 
%     if CP_tel(j) - CP_tel(j-1) < 60
%         CP_tel (j) = 0;
%         CP_tel = sort(CP_tel);
%     end
% end
% CP_tel = nonzeros(CP_tel)
% if length(CP_tel) == true
%     B1 = B1 + 1;
% end
% if length(CP_tel) > true 
%     B0 = B0 + 1;
% end 
end
RCP(w1,w2) = R1/M
RCP2(w1,w2) = R_21/M
end
end

