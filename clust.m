clear all
close all
clc
ani1 = 'delay_wl.xlsx';
X = xlsread(ani1);
[rows1 columns1] = size(X);
no_optimal = 2; 
I = 50;
%% cluster - sim
Xt = [];
for j = 1:columns1
Xt = X(:,j);
dela(:,j) = Xt(3:9000);
end
Wt = [];
Vt = [];
Xt = [];
Wt = ([dela(1:2000,:)]);
Wt(isnan(Wt)) = max(max(abs(Wt)));
[Cl] = HGC(Wt,I,no_optimal);
clusters = Cl;
%% Visualitation
Y = [];
for i = 1:2
    for j = 1:length(nonzeros(clusters(i,:)))
    Y(:,j,i) = Wt(:,clusters(i,j));
    end
end
Y(:,all(Y == 0))=[];
lenc = [];
for  i = 1:no_optimal
    lenc(i) = length(nonzeros(clusters(i,:)));
end
lenc = [0 lenc];


% PCA on each cluster
yt = [];
Et = [];
for i = 1:2
    j = i + 1;
    sum(lenc(1:j-1));
    sum(lenc(1:j));
    yt = Y(:,1+sum(lenc(1:j-1)):sum(lenc(1:j)));
    [coeff,score,latent,tsquared,explained,mu] = pca(yt);
    Et(:,i) = score*coeff(:,1) + repmat(mean(mu),length(yt),1);
end

[rows columns] = size(clusters);
for i = 1:rows
    figure(i)
for ii = 1 : nonzeros(length(nonzeros(clusters(i,:))))
    hold on
    plot(Wt(:,clusters(i,ii)))
    hold on
end
%plot(Et(:,i),'Linewidth',1,'color','r')
ylabel('RSSI (dBm)','fontsize',14)
xlabel('Time (min)','fontsize',14)
box on
grid on
end
