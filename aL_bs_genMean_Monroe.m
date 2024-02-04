function [CP]=aL_bs_genMean_Monroe(D_star);
global Yt; 
global cp;
global num_of_cp;
global LL;
aL_bs_Mean_Monroe(1,length(Yt),D_star);
if num_of_cp==0
    CP=0;
    %disp('There is no evidence of mean changes in the series');
else
    aL_ElimiMean_Monroe(D_star);
    cp=sort(cp);
% svisimo kanonika
for i=1:length(cp)
    if cp(i)<15
    cp(i)=0;
    end
end

% svisimo kanonina
for i = 1:length(cp)
    if cp(i) >length(Yt) - 15
    cp(i) = 0;
    end
end

% kanonika 20
    if length(cp)>2
        for i=2:length(cp)
            if cp(i)-cp(i-1)<15
                cp(i-1)=0;
            end
        end
        cp=sort(cp);
        cp=nonzeros(cp);
    end
          CP=nonzeros(cp);                      
    end
end
