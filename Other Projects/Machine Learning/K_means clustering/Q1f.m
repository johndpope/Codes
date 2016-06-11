clear
load('kmeans_data.mat')
for i=2:20
    [~,~,obj(i)]=kmeans_cluster(X,i,'random',20) ;
end

[~,~,obj(1)]=kmeans(X,1) ;
plot(obj,'ro'); hold on
plot(obj,'-b') ; xlabel('Number of Clusters') ; ylabel('Objective function')


for i=1:1000
    [~,~,obj2(i)]=kmeans_cluster(X,9,'random',1) ;
end
oj = mean(obj2) ;

for i=1:1000
    [~,~,obj2(i)]=kmeans_cluster(X,9,'kmeans++',1) ;
end
oj = mean(obj2) ;