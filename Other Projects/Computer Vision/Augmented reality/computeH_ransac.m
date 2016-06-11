% Q3.2.3
function [bestH2to1, inliers] = computeH_ransac(locs1, locs2)

 p1=locs2;
 p2=locs1;
 thr = 50 ;
%  img1 = imread('../data/cv_desk.png');
%  img2 = imread('../data/cv_cover.jpg');
%  [p1,p2]=MatchPics(img1,img2) ;


% mu=mean(p1);
% p1_n(:,1) = p1(:,1) - mu(1);
% p1_n(:,2) = p1(:,2) - mu(2);
% p1_nor = p1_n/((max(p1_n(:,1).^2+p1_n(:,2).^2))^0.5)*(2^0.5) ;
% 
% mu=mean(p2);
% p2_n(:,1) = p2(:,1) - mu(1);
% p2_n(:,2) = p2(:,2) - mu(2);
% p2_nor = p2_n/((max(p2_n(:,1).^2+p2_n(:,2).^2))^0.5)*(2^0.5) ;

temp1=[p2' ; ones(size(p2,1),1)'] ;

mu=mean(p1);
T1 = [1/max(p1(1)) 0 -mu(1)/max(p1(1)) ; 0 1/max(p1(2)) -mu(2)/max(p1(2)) ; 0 0 1] ;

mu=mean(p2);
T2 = [1/max(p2(1)) 0 -mu(1)/max(p2(1)) ; 0 1/max(p2(2)) -mu(2)/max(p2(2)) ; 0 0 1] ;

for i=1:100
    n=size(p1,1); m=4; r=randperm(n); rs(i,:)=r(1:m) ;
%    h = computeH_norm(p1_nor(rs(i,:),:),p2_nor(rs(i,:),:)) ;
    h=computeH_norm(p1(rs(i,:),:),p2(rs(i,:),:));
    temp=[p1' ; ones(size(p1,1),1)'] ;
    tempp2=h*temp;
    temp2(1,:) = tempp2(1,:)./tempp2(3,:);
    temp2(2,:) = tempp2(2,:)./tempp2(3,:);
    temp2(3,:) = tempp2(3,:)./tempp2(3,:);
    dist=((temp1(1,:)-temp2(1,:)).^2+(temp1(2,:)-temp2(2,:)).^2+(temp1(3,:)-temp2(3,:)).^2).^0.5 ;
    cnt(i)=sum(dist<thr) ;
%     t1(1,:) = temp(1,:)./temp(3,:);
%     t1(2,:) = temp(2,:)./temp(3,:);
%     t11=t1' ;
 end
[val,idx]=max(cnt) ;
h = computeH_norm(p1(rs(idx,:),:),p2(rs(idx,:),:)) ;
tempp2=h*temp;
    temp2(1,:) = tempp2(1,:)./tempp2(3,:);
    temp2(2,:) = tempp2(2,:)./tempp2(3,:);
    temp2(3,:) = tempp2(3,:)./tempp2(3,:);
dist=((temp1(1,:)-temp2(1,:)).^2+(temp1(2,:)-temp2(2,:)).^2+(temp1(3,:)-temp2(3,:)).^2).^0.5 ;
inliers=dist<thr ;

 idx2=find(inliers==1) ;
 h = computeH_norm(p1(idx2,:),p2(idx2,:)) ;
 temp2=h*temp;
 dist=((temp1(1,:)-temp2(1,:)).^2+(temp1(2,:)-temp2(2,:)).^2+(temp1(3,:)-temp2(3,:)).^2).^0.5 ;
 sum(dist<thr) ;

bestH2to1=h ;
