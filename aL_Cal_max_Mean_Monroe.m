function [ M_value,loc ] = aL_Cal_max_Mean_Monroe(st,en);
global Yt;
global LL;

extr_a=Yt(:,st:en);

if abs(en-st)>5
l=length(extr_a);
H=floor(log(l));
% Sk
s1=0;
for i=1:l
    s1=s1+extr_a(:,i);
    sk(:,i)=s1;
end
sk;
for i=1:l
SK(:,i)=((1)/sqrt(l))*(sk(:,i)-((i)/(l))*(sk(:,l)));
end
SK;
%Long run covariance
SS=covnw(extr_a',H);

if SS == 0
    SS = 1;
end

% if SS == 0
%     SS = 1
% end

%To statistiko
for i=1:l
    L(i,:)=abs((SK(:,i)')*(SS^(-1))*(SK(:,i)));
    LL (i,:) = L(i,:);
end

[M_value,index]=max(abs(L));
loc=st+index-1;
else
    loc=0;
    M_value=0;
end