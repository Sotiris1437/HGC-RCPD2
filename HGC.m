function [Cl] = HGC(Wt,I,no_optimal)
[rows columns] = size(Wt);
W = max(max(abs(Wt)));
w = floor(W/I);
for i = 1:columns
    Vt = Wt(:,i);
    signatures{i} = abs(Vt);
end
Logk = [];
I = 0;
Logk = [];
for i = 0:w: W - w
    I = I + 1;
    for l = 1:columns
        Logk(I,l) = dtw(randi([i,i+w],2000,1)', signatures{l});
        %Logk(I,l) = DTWKMatlab(randi([i,i + w],2000,1), signatures{l},100);        
    end
end
for j = 1:I
%eva = evalclusters(Logk(j,1:columns)','kmeans','CalinskiHarabasz','KList',1:no_optimal);
[idx] = kmedoids(Logk(j,1:columns)',no_optimal);
no_idx(:,j) = idx;
end
distM = [];
distM=squareform(pdist(Wt'));
for i = 1 : I
dunn_ksi(i) = dunns(no_optimal,distM,no_idx(:,i));
s = silhouette(Wt',no_idx(:,i));
sil_ksi(i) = mean(s);
end
[dunn_ksim index_dunn] = max(dunn_ksi);
[sil_ksim index_sil]= max(sil_ksi);
idx = no_idx(:,index_dunn);    
clusters = [];
for I = 1:no_optimal
    plithos = 0;
    for J = 1:columns
        if idx(J) == I
            plithos = plithos + 1;
            clusters(I,plithos) = J;
        end
    end
end
Cl = clusters;
end