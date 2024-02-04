function [] = aL_bs_Mean_Monroe( st,en,D_star)
global num_of_cp;
global cp;
first=st;
last=en; %the first point and the last point of the series being operated on
if abs(last-first)<20
    return;
else
    [ M_value,loc ] = aL_Cal_max_Mean_Monroe( first,last);
    if M_value>=D_star
        aL_bs_Mean_Monroe(st,loc,D_star);
        aL_bs_Mean_Monroe(loc+1,en,D_star);
        num_of_cp=num_of_cp+1;
        cp(num_of_cp)=loc;
        M_V(num_of_cp)=M_value;
    else
        return;
    end
end
end