function [CP_total,pos] = RCPD3(Xt,mon_start,mon_time,significance_level,gamma,k,w,f)
tic
CP_ONN = 0; MAG_MEAN = 0; MAG_MIN = 0; 
D_star_tp = 2; 
CP_ON=0; THET_CP=0; ARN_CP=0; n1=0; n2=0; OCP=0; Dec=0; Dec1=0; n=0; n1=0; n2=0; Cp_Up=0;
Cp_Down=0; CPT=0; OCP1=0; j=0; CP_ONN=0;  CP_ONN1 = 0; CP1 = 0;
thres = 15;
alarm = 0;
j = 0;
for i=1:length(Xt)
if i == 1
    j = j + 1;
    CP_ONN1(j) = 1; 
end
    global T_S
    global CP
    global CP1
    T_S=[Xt(1:i)];
    g = gamma;
    B = 1111;
    [Dec,OCP] = integration_teliko_Frempt(mon_start,mon_time,g,D_star_tp,significance_level);
    %[Dec,OCP,] = monroe_teliko_meanARMA(mon_start,mon_time,gamma,D_star_tp,significance_level);
    %[Dec,OCP,] = monroe_teliko_meanARMAadj(monitoring_start,monitoring_time,gamma,D_star_tp,B,significance_level,k);    
    
    if (Dec == 1)
        mon_start=OCP+k;
        CP1 = OCP;
    else if length(T_S)>=mon_start+mon_time-1  
        mon_start=mon_start+mon_time;
    end
    end
    if length(T_S)== 20
        if median(T_S(1:20)) >thres
            alarm = -1;
        else
            alarm = 1;
        end
    end          

    if CP1 > 1
        st = CP1-f;
        if length(T_S) == CP1 + w + 1
            [ loc, LL ] = aL_crossval_Monroe(st,T_S(CP1-f:CP1));
            %figure()
            %plot(LL)
            p1 = Xt(loc-w:loc);
            p1_rand = p1(randperm(length(p1)));
            p2 = Xt(loc+1:loc+w+1);
            p2_rand = p2(randperm(length(p2)));
            p = [p1';p2']';
%             out = 0;
%             Pidx = isoutlier(p,"grubbs");
%             for j = 1:length(Pidx)
%                 if sum(Pidx(j,:)) == 0
%                     out = out + 1;
%                     P_fin(out,:) = p(j,:);
%                 end
%             end
%             ptel = kruskalwallis(P_fin,[],'off');
            
            ptel = kruskalwallis(p,[],'off');
            %ptel = ranksum(p1,p2)
            if ptel < 0.05
                j = j + 1;
                if CP1 >= loc + w + 1
                CP_ONN1(j) = CP1;
                CP1 = 0;
                else
                CP_ONN1(j) = loc + w + 1;
                CP1=0;
                end
%             else 
%                 global Yt
%                 global cp
%                 global num_of_cp
%                 num_of_cp=0; cp=[]; Cp=[]; D_star_tp = 2.4; 
%                 CP_ONN1 = nonzeros(CP_ONN1);
%                 Yt=T_S(CP_ONN1(length(CP_ONN1)):length(T_S));
%                 Cp=aL_bs_genMean_Monroe(D_star_tp);
%                 if max(Cp)>0  
%                     j = j + 1;
%                     CP_ONN1(j) = CP_ONN1(length(CP_ONN1)) + max(Cp);
%                 end
            end
            CP1 = 0;
            CC = 0;
        end
    end
    end
alarm;
CP_total2 = unique(CP_ONN1);
CP_total2 = nonzeros(CP_ONN1);
CP_total2 = CP_total2(CP_total2>1);
CP_total = unique(CP_total2);
if length(CP_total) > 1
    for J = 1: length(CP_total) - 1
        if CP_total(J+1) < CP_total(J) + 50
            CP_total(J+1) = 0;
        end
    end
end
CP_total = nonzeros(CP_total);
CP_total = unique(CP_total);
pos = length(CP_total);
end