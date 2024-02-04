function [OCP] = FremptFunctional_Monroe(Thres,m,g,significance_level)
global Xt
global M_value
T=length(Xt);
Xt=Xt(Thres:T)';
T=length(Xt);
k=T-m;
Q1=sum(Xt(1:m));
q2=0;
for i=1:k
  q2=q2+Xt(m+i);
  Q2(i)=q2;
end
%Diaspora mexri m
Var=var(Xt(1:m));
if Var == 0
    Var = 1;
end
%Var=covnw(Xt,floor(log10(m)),1);
%Var = covnw
% h metrisi toy k
%Times gia to g
if significance_level==0.9
if g==0
    ca=1.9608;
else if g==0.15
        ca=2.0265;
    else if g==0.25
            ca=2.1157;
        else if g==0.35
                ca=2.2540;
            else if g==0.45
                    ca=2.5434;
                else if g==0.49
                        ca=3.8522;
                    end
                end
            end
        end
    end
end

elseif significance_level==0.95
if g==0
    ca=2.2365;
else if g==0.15
        ca=2.299;
    else if g==0.25
            ca=2.3898;
        else if g==0.3
                ca=2.45;
        else if g==0.35
                ca=2.5118;
            else if g==0.45
                    ca=2.7907;
                else if g==0.49
                        ca=3.1049;
                    end
                end
            end
        end
    end
end
end
elseif significance_level==0.99
if g==0
    ca=2.82;
else if g==0.15
        ca=2.8878;
    else if g==0.25
            ca=2.9293;
        else if g==0.35
                ca=3.058;
            else if g==0.45
                    ca=3.305;
                else if g==0.49
                        ca=3.6027;
                    end
                end
            end
        end
    end
end
end
% Detector
for i=1:k
    if abs(Var) > 1e-10
    DT(i,:)=abs(Q2(i)-((i)/m)*Q1)/((sqrt(m*Var))*((1+(i)/m)*((i)/((i)+m))^g));
    M_value=DT(i,:);
    else
        DT(i,:) = 0;
    M_value=DT(i,:);
    end    
    if DT(i,:)>=ca
    CPA=Thres+m+i;
    else
    CPA=0;
    end
end
OCP=CPA;
end