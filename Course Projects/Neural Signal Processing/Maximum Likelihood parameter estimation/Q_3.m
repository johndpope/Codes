clear
load ps3_simdata.mat

k1 = zeros(20,2);
k2 = zeros(20,2);
k3 = zeros(20,2);

for i=1:20
    k1(i,:)=trial(i,1).x ;
    k2(i,:)=trial(i,2).x ;
    k3(i,:)=trial(i,3).x ;
end
n1 = size(k1,1);
n2 = size(k2,1);
n3 = size(k3,1);
plot(k1(:,1),k1(:,2),'rx',k2(:,1),k2(:,2),'g+',k3(:,1),k3(:,2),'bo') ;
xlim([0 20])
ylim([0 20])

%% Gaussian - shared Covariance
gau1_p1 = n1/(n1+n2+n3) ;
gau1_p2 = n2/(n1+n2+n3) ;
gau1_p3 = 1 - gau1_p1 - gau1_p2 ;
gau1_mu1 = mean(k1);
gau1_mu2 = mean(k2);
gau1_mu3 = mean(k3);
gau1_sig1 = (k1 - ones(20,1)*mean(k1))'*(k1 - ones(20,1)*mean(k1))/n1 ;
gau1_sig2 = (k2 - ones(20,1)*mean(k2))'*(k2 - ones(20,1)*mean(k2))/n2 ;
gau1_sig3 = (k3 - ones(20,1)*mean(k3))'*(k3 - ones(20,1)*mean(k3))/n3 ;
gau1 = (n1*gau1_sig1 + n2*gau1_sig2 + n3*gau1_sig3)/(n1+n2+n3) ;

plot(k1(:,1),k1(:,2),'rx',k2(:,1),k2(:,2),'g+',k3(:,1),k3(:,2),'bo') ;
xlim([0 20])
ylim([0 20])
hold on ;
scatter(gau1_mu1(1),gau1_mu1(2),'filled','r')
scatter(gau1_mu2(1),gau1_mu2(2),'filled','g')
scatter(gau1_mu3(1),gau1_mu3(2),'filled','b')
hold on ;

r_ellipse = elpse(k1(:,1),k1(:,2),gau1) ;
plot(r_ellipse(:,1) + gau1_mu1(1),r_ellipse(:,2) + gau1_mu1(2),'r-')
hold on;

r_ellipse = elpse(k2(:,1),k2(:,2),gau1) ;
plot(r_ellipse(:,1) + gau1_mu2(1),r_ellipse(:,2) + gau1_mu2(2),'g-')
hold on;

r_ellipse = elpse(k3(:,1),k3(:,2),gau1) ;
plot(r_ellipse(:,1) + gau1_mu3(1),r_ellipse(:,2) + gau1_mu3(2),'b-')
hold on;

% Class
w1 = inv(gau1)*gau1_mu1';
w2 = inv(gau1)*gau1_mu2';
w3 = inv(gau1)*gau1_mu3';
                                                                                             
w10 = -gau1_mu1*inv(gau1)*gau1_mu1'/2 + log(1/3);
w20 = -gau1_mu2*inv(gau1)*gau1_mu2'/2 + log(1/3);
w30 = -gau1_mu3*inv(gau1)*gau1_mu3'/2 + log(1/3);

x = [0:20];
y1 =  -(w1(1)-w2(1))/(w1(2)-w2(2))*x - (w10-w20)/(w1(2)-w2(2)) ;
y2 =  -(w1(1)-w3(1))/(w1(2)-w3(2))*x - (w10-w30)/(w1(2)-w3(2)) ;
[a,b]=polyxpoly(x,y1,x,y2) ;

x = [a:0.01:20];
y1 =  -(w1(1)-w2(1))/(w1(2)-w2(2))*x - (w10-w20)/(w1(2)-w2(2)) ;
% plot (x,y1)
hold on

x = [0:0.01:a];
y2 =  -(w1(1)-w3(1))/(w1(2)-w3(2))*x - (w10-w30)/(w1(2)-w3(2)) ;
%plot (x,y2)
hold on

x = [0:0.01:a];
y3 =  -(w3(1)-w2(1))/(w3(2)-w2(2))*x - (w30-w20)/(w3(2)-w2(2)) ;
%plot (x,y3)
hold on

str1 = 'Class 1';
text(gau1_mu1(1),gau1_mu1(2),str1) ;
str1 = 'Class 2';
text(gau1_mu2(1),gau1_mu2(2),str1) ;
str1 = 'Class 3';
text(gau1_mu3(1),gau1_mu3(2),str1) ;

%% Gaussian - class specific Covariance
gau2_p1 = n1/(n1+n2+n3) ;
gau2_p2 = n2/(n1+n2+n3) ;
gau2_p3 = 1 - gau2_p1 - gau2_p2 ;
gau2_mu1 = mean(k1);
gau2_mu2 = mean(k2);
gau2_mu3 = mean(k3);
gau2_sig1 = (k1 - ones(20,1)*mean(k1))'*(k1 - ones(20,1)*mean(k1))/n1 ;
gau2_sig2 = (k2 - ones(20,1)*mean(k2))'*(k2 - ones(20,1)*mean(k2))/n2 ;
gau2_sig3 = (k3 - ones(20,1)*mean(k3))'*(k3 - ones(20,1)*mean(k3))/n3 ;

plot(k1(:,1),k1(:,2),'rx',k2(:,1),k2(:,2),'g+',k3(:,1),k3(:,2),'bo') ;
xlim([0 20])
ylim([0 20])
hold on ;
scatter(gau2_mu1(1),gau2_mu1(2),'filled','r')
scatter(gau2_mu2(1),gau2_mu2(2),'filled','g')
scatter(gau2_mu3(1),gau2_mu3(2),'filled','b')
hold on ;

r_ellipse = elpse(k1(:,1),k1(:,2),gau2_sig1) ;
% plot(r_ellipse(:,1) + gau2_mu1(1),r_ellipse(:,2) + gau2_mu1(2),'r-')
hold on;

r_ellipse = elpse(k2(:,1),k2(:,2),gau2_sig2) ;
% plot(r_ellipse(:,1) + gau2_mu2(1),r_ellipse(:,2) + gau2_mu2(2),'g-')
hold on;

r_ellipse = elpse(k3(:,1),k3(:,2),gau2_sig3) ;
% plot(r_ellipse(:,1) + gau2_mu3(1),r_ellipse(:,2) + gau2_mu3(2),'b-')
hold on;

w1 = inv(gau2_sig1)*gau2_mu1';
w2 = inv(gau2_sig2)*gau2_mu2';
w3 = inv(gau2_sig3)*gau2_mu3';
                                                                                             
w10 = -gau2_mu1*inv(gau2_sig1)*gau2_mu1'/2 + log(1/3);
w20 = -gau2_mu2*inv(gau2_sig2)*gau2_mu2'/2 + log(1/3);
w30 = -gau2_mu3*inv(gau2_sig3)*gau2_mu3'/2 + log(1/3);

s1 = inv(gau2_sig1); s1 = s1(:);
s2 = inv(gau2_sig2); s2 = s2(:);
s3 = inv(gau2_sig3); s3 = s3(:);

[x,y] = meshgrid(0:0.1:20);
f1 = -(x.^2*(s1(1)-s2(1))+y.^2*(s1(4)-s2(4))+x.*y*(s1(3)+s1(2)-s2(3)-s2(2)))/2 -1/2*(log(det(gau2_sig1))-log(det(gau2_sig2))) + (w1(1)-w2(1))*x + (w1(2)-w2(2))*y + w10-w20;
a1=contour(x,y,f1,[0 0],'w');
plot(a1(1,find(a1(1,:)>7.2)),a1(2,find(a1(1,:)>7.2)),'.r')
hold on;


f1 = -(x.^2*(s1(1)-s3(1))+y.^2*(s1(4)-s3(4))+x.*y*(s1(3)+s1(2)-s3(3)-s3(2)))/2 -1/2*(log(det(gau2_sig1))-log(det(gau2_sig3))) + (w1(1)-w3(1))*x + (w1(2)-w3(2))*y + w10-w30;
a2 = contour(x,y,f1,[0 0],'w');
plot(a2(1,find(a2(1,:)<7.3)),a2(2,find(a2(1,:)<7.3)),'.b')
hold on;


f1 = -(x.^2*(s2(1)-s3(1))+y.^2*(s2(4)-s3(4))+x.*y*(s2(3)+s2(2)-s3(3)-s3(2)))/2 -1/2*(log(det(gau2_sig2))-log(det(gau2_sig3))) + (w2(1)-w3(1))*x + (w2(2)-w3(2))*y + w20-w30;
a3 = contour(x,y,f1,[0 0],'w');
plot(a3(1,find(a3(1,:)<7.25)),a3(2,find(a3(1,:)<7.25)),'.g')
hold on;

str1 = 'Class 1';
text(gau2_mu1(1),gau2_mu1(2),str1) ;
str1 = 'Class 2';
text(gau2_mu2(1),gau2_mu2(2),str1) ;
str1 = 'Class 3';
text(gau2_mu3(1),gau2_mu3(2),str1) ;

%% Poisson

poi_p1 = n1/(n1+n2+n3);
poi_p2 = n2/(n1+n2+n3);
poi_p3 = 1- poi_p1 - poi_p2;
poi_lmd11 = sum(k1(:,1))/n1;
poi_lmd12 = sum(k1(:,2))/n1;
poi_lmd21 = sum(k2(:,1))/n2;
poi_lmd22 = sum(k2(:,2))/n2;
poi_lmd31 = sum(k3(:,1))/n3;
poi_lmd32 = sum(k3(:,2))/n3;

plot(k1(:,1),k1(:,2),'rx',k2(:,1),k2(:,2),'g+',k3(:,1),k3(:,2),'bo') ;
xlim([0 20])
ylim([0 20])
hold on ;
scatter(poi_lmd11,poi_lmd12,'filled','r')
scatter(poi_lmd21,poi_lmd22,'filled','g')
scatter(poi_lmd31,poi_lmd32,'filled','b')
hold on ;

w1 = [log(poi_lmd11) log(poi_lmd12)]' ;
w2 = [log(poi_lmd21) log(poi_lmd22)]' ;
w3 = [log(poi_lmd31) log(poi_lmd32)]' ;

w10 = -poi_lmd11 - poi_lmd12 ;
w20 = -poi_lmd21 - poi_lmd22 ;
w30 = -poi_lmd31 - poi_lmd32 ;

x = [0:20];
y1 =  -(w1(1)-w2(1))/(w1(2)-w2(2))*x - (w10-w20)/(w1(2)-w2(2)) ;
y2 =  -(w1(1)-w3(1))/(w1(2)-w3(2))*x - (w10-w30)/(w1(2)-w3(2)) ;
[a,b]=polyxpoly(x,y1,x,y2) ;

x = [a:0.01:20];
y1 =  -(w1(1)-w2(1))/(w1(2)-w2(2))*x - (w10-w20)/(w1(2)-w2(2)) ;
plot (x,y1)
hold on

x = [0:0.01:a];
y2 =  -(w1(1)-w3(1))/(w1(2)-w3(2))*x - (w10-w30)/(w1(2)-w3(2)) ;
plot (x,y2)
hold on

x = [0:0.01:a];
y3 =  -(w3(1)-w2(1))/(w3(2)-w2(2))*x - (w30-w20)/(w3(2)-w2(2)) ;
plot (x,y3)
hold on

str1 = 'Class 1';
text(poi_lmd11,poi_lmd12,str1) ;
str1 = 'Class 2';
text(poi_lmd21,poi_lmd22,str1) ;
6str1 = 'Class 3';
text(poi_lmd31,poi_lmd32,str1) ;