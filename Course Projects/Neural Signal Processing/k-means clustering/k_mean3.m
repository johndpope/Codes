function [mu,assign] = k_mean3(dat,init)

dist=pdist2(dat',init');
[~,assign]=min(dist') ;
mu = init ;
i=1 ;
diff = 1 ;
j(1)= sum((pdist2(dat(:,find(assign==1))',mu(:,1)')).^2) + sum((pdist2(dat(:,find(assign==2))',mu(:,2)')).^2);
j(1)= j(1) + sum((pdist2(dat(:,find(assign==3))',mu(:,3)')).^2) ;
while diff > 10^-10
    mu(:,1) = mean(dat(:,find(assign==1))')' ;
    mu(:,2) = mean(dat(:,find(assign==2))')' ;
    mu(:,3) = mean(dat(:,find(assign==3))')' ;
    j(2*i)= sum((pdist2(dat(:,find(assign==1))',mu(:,1)')).^2) + sum((pdist2(dat(:,find(assign==2))',mu(:,2)')).^2);
    j(2*i)= j(2*i) + sum((pdist2(dat(:,find(assign==3))',mu(:,3)')).^2) ;
    dist=pdist2(dat',mu');
    [~,assign]=min(dist') ;
    j(2*i+1)  = sum((pdist2(dat(:,find(assign==1))',mu(:,1)')).^2) + sum((pdist2(dat(:,find(assign==2))',mu(:,2)')).^2); 
    j(2*i+1)  = j(2*i+1) + sum((pdist2(dat(:,find(assign==3))',mu(:,3)')).^2) ;
    diff = j(2*i) - j(2*i+1) ;
    i = i+1 ;
end
plot([1/2:2/2:(2*round(size(j,2)/2)-1)/2],j(1:2:end),'bo') ; hold on;
plot([2/2:2/2:(2*round(size(j,2)/2))/2-1],j(2:2:end),'ro')
plot([1/2:1/2:size(j,2)/2],j)
ylabel('J')
end