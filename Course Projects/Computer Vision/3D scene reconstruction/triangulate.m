 function X = triangulate(P1, x1, P2, x2)

% addpath('../data')
% load('some_Corresp.mat')
% i1 = imread('im1.png') ;
% i2 = imread('im2.png') ;
% f = eightpoint(pts1,pts2,[size(i1,1) size(i1,2) ; size(i2,1) size(i2,2)]) ;
% load('intrinsics.mat')
% ess = essentialMatrix(f,K1,K2) ;
% P1 = [1 0 0 0; 0 1 0 0; 0 0 1 0] ;
% temp = camera2(ess) ;

pts1=x1 ;
pts2=x2 ;
A=zeros(4*size(pts1,1),4) ;
% for j=1:4
%    P2 = temp(:,:,j) ;
%    cnt(j)=0;
    for i=1:size(pts1,1)
        A(4*i-3,:)=[P1(3,:)*pts1(i,2) - P1(2,:) ] ;
        A(4*i-2,:)=[-P1(1,:) + P1(3,:)*pts1(i,1) ] ;
        A(4*i-1,:)=[P2(3,:)*pts1(i,2) - P2(2,:) ] ;
        A(4*i,:)=  [-P2(1,:) + P2(3,:)*pts1(i,1) ] ;
        [u,v,w] = svd(A(4*i-3:4*i,:)'*A(4*i-3:4*i,:)) ;
        temp1(i,:)=w(:,end)' ;
%         if (temp1(i,3)/temp1(i,4)) >0
%             cnt(j)=cnt(j)+1;
%         end
    end
    
% end

% j=find(cnt==max(cnt)) ;
% P2 = temp(:,:,j) ;
%     cnt(j)=0;
%     for i=1:size(pts1,1)
%         A(4*i-3,:)=[P1(3,:)*pts1(i,2) - P1(2,:) ] ;
%         A(4*i-2,:)=[P1(1,:) - P1(3,:)*pts1(i,1) ] ;
%         A(4*i-1,:)=[P2(3,:)*pts1(i,2) - P2(2,:) ] ;
%         A(4*i,:)=[P2(1,:) - P2(3,:)*pts1(i,1) ] ;
%         [u,v,w] = svd(A(4*i-3:4*i,:)'*A(4*i-3:4*i,:)) ;
%         temp1(i,:)=w(:,end)' ;
%         if (temp1(i,3)/temp1(i,4)) >0
%             cnt(j)=cnt(j)+1;
%         end
%     end


% temp1(:,3)./temp1(:,4) ;
X(:,1)=temp1(:,1)./temp1(:,4) ;
X(:,2)=temp1(:,2)./temp1(:,4) ;
X(:,3)=temp1(:,3)./temp1(:,4) ;

temp2=(P1*[X ones(size(X,1),1)]')' ;
temp3=(P2*[X ones(size(X,1),1)]')' ;
t1(:,1) = temp2(:,1)./temp2(:,3) ;
t1(:,2) = temp2(:,2)./temp2(:,3) ;

t2(:,1) = temp3(:,1)./temp3(:,3) ;
t2(:,2) = temp3(:,2)./temp3(:,3) ;

err=sum(sum((t1-pts1).*(t1-pts1)+(t2-pts2).*(t2-pts2))) ;