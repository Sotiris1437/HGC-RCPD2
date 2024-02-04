function aL_ElimiMean_Monroe( D_star);
global Yt;
global num_of_cp;
global cp;
global LL;
%Step 3.
%define the two extreme values
if num_of_cp==length(cp) 
tmp_cp(1,2:num_of_cp+1)=cp(1:num_of_cp);
tmp_cp(1,1)=0;
tmp_cp(1,num_of_cp+2)=length(Yt);
tmp_cp=sort(tmp_cp);
if tmp_cp(:,length(tmp_cp))<tmp_cp(:,length(tmp_cp)-1)
    tmp_cp(:,length(tmp_cp)-1)=0;
    tmp_cp=unique(sort(tmp_cp));
    num_of_cp=num_of_cp-1;
end
flag=1;
Cal_times=0; 
%the number of iterations
while flag==1
    %check each possible changepoint
    num_of_cp2=0;
    tmp_cp2=[];
    Cal_times=Cal_times+1;
    for i=2:num_of_cp+1
        [ M_value,loc ] = aL_Cal_max_Mean_Monroe(tmp_cp(i-1)+1,tmp_cp(i+1));
        if M_value>=D_star
            num_of_cp2=num_of_cp2+1;
            tmp_cp2(num_of_cp2)=loc;
            M_V2(num_of_cp2)=M_value;
        end
    end
    %sort cp
    tmp_cp2=unique(tmp_cp2);
    tmp_cp2=sort(tmp_cp2);
    num_of_cp2=length(tmp_cp2);
    if num_of_cp==num_of_cp2
        n=0;
        for i=1:num_of_cp
            if abs(tmp_cp(i+1)-tmp_cp2(i))<=30  %check whether each changepoint is within two observations
                n=n+1;
            end
        end
        if n==num_of_cp
            flag=0;
        end
    end
    if Cal_times>=7   %if exceeds the limit of 20 iterations
        flag=0;
    end
    if flag==1
        num_of_cp=num_of_cp2; %renew
        tmp_cp(num_of_cp+2)=length(Yt);
        tmp_cp(2:num_of_cp+1)=tmp_cp2;
    end
end
cp=tmp_cp2;
else
    cp=0;
end