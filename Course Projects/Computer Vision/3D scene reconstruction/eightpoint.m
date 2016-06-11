function f = eightpoint(x1,x2,M)

addpath('../data')
% load('some_Corresp.mat')
% x1=pts1 ;
% x2=pts2 ;
% M(1,1)=size(a1,1);
% M(1,2)=size(a1,2);
% M(2,1)=size(a2,1);
% M(2,2)=size(a2,2);
m1=M(1,:);
m2=M(2,:);
t1=[1/m1(1) 0 -mean(x1(:,1))/m1(1); 0 1/m1(2) -mean(x1(:,2))/m1(2) ; 0 0 1] ;
t2=[1/m2(1) 0 -mean(x2(:,1))/m2(1); 0 1/m2(2) -mean(x2(:,2))/m2(2) ; 0 0 1] ;
n_x1=(t1*[x1 ones(size(x1,1),1)]')' ;
n_x2=(t2*[x2 ones(size(x2,1),1)]')' ;

% t1=[1/m1(2) 0 0; 0 1/m1(1) 0 ; 0 0 1] ;
% t2=[1/m2(2) 0 0; 0 1/m2(1) 0 ; 0 0 1] ;
% n_x1=(t1*[x1 ones(size(x1,1),1)]')' ;
% n_x2=(t2*[x2 ones(size(x2,1),1)]')' ;

for i=1:size(x1,1)
    A(i,:)= [n_x1(i,1)*n_x2(i,1) n_x1(i,1)*n_x2(i,2) n_x1(i,1) n_x1(i,2)*n_x2(i,1) n_x1(i,2)*n_x2(i,2) n_x1(i,2) n_x2(i,1) n_x2(i,2) 1 ] ;
end
[u,v,w]=svd(A'*A) ;
temp = w(:,end) ;
f=(reshape(temp,3,3))' ;
f=refineF(f,x1,x2) ;
[u1,v1,w1]=svd(f) ;
v1(3,3)=0 ;
f = u1*v1*w1' ;
f=t1'*f*t2 ;




% a1=imread('im1.png');
% a2=imread('im2.png');
% displayEpipolarF(a1,a2,f)
