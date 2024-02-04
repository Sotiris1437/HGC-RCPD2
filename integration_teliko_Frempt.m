% Significance_level=0.99
% g=0.25
% D_star_tp=1.8 κρίσιμη τιμή των cp προ monitoring time.
%monitoring_start αρχική περίοδος.
%monitoring_time παράθυρο επιτήρησης.
function [Dec,OCP] = integration_teliko_Frempt(monitoring_start,monitoring_time,g,D_star_tp,significance_level);
global T_S
global Thres
OCP = 0;
T_S = T_S';
if length(T_S)<monitoring_start
    Dec =100;
end

if length(T_S)==monitoring_start
    Dec=50; % random τιμή   global Yt
    global Yt
    global cp
    global num_of_cp
    global M_V
    num_of_cp=0; cp=[]; M_V=[]; Cp=[];
    Yt=T_S(1:monitoring_start);
    Cp=aL_bs_genMean_Monroe(D_star_tp);
    if Cp>1
        Thres=max(Cp); % απο εδώ ξεκινάμε το training period του on-line.
        else
        Thres=1;
    end
end

if length(T_S)>monitoring_start && length(T_S)<=monitoring_start+monitoring_time
global Xt 
Xt=T_S;
m=monitoring_start-Thres;
Thres1=Thres;
OCP = FremptFunctional_Monroe(Thres,m,g,significance_level);
if OCP > 0
    Dec = 1;
else
    Dec = 0;
end
end

if length(T_S)>=monitoring_start+monitoring_time
        Dec=-100;
end
end
