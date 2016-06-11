% Q3.2.2
function [H2to1] = computeH_norm(p1, p2)
%  img1 = imread('../data/cv_desk.png');
%  img2 = imread('../data/cv_cover.jpg');
%  [p1,p2]=MatchPics(img1,img2) ;

mu=mean(p1);
T1 = [1/max(p1(1)) 0 -mu(1)/max(p1(1)) ; 0 1/max(p1(2)) -mu(2)/max(p1(2)) ; 0 0 1] ;


 p1_n(:,1) = (p1(:,1) - mu(1))/max(p1(1));
 p1_n(:,2) = (p1(:,2) - mu(2))/max(p1(2));

mu=mean(p2);
T2 = [1/max(p2(1)) 0 -mu(1)/max(p2(1)) ; 0 1/max(p2(2)) -mu(2)/max(p2(2)) ; 0 0 1] ;

 p2_n(:,1) = (p2(:,1) - mu(1))/max(p2(1));
 p2_n(:,2) = (p2(:,2) - mu(2))/max(p2(2));

h = computeH(p1_n, p2_n) ;

H2to1 = inv(T1)*h*T2 ;

