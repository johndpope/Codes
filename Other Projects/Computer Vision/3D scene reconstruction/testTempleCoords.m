i1=imread('../data/im1.png') ;
i2=imread('../data/im2.png') ;
load('../data/some_Corresp.mat')
f = eightpoint(pts1,pts2,[size(i1,1) size(i1,2) ; size(i2,1) size(i2,2)]) ;
% f=estimateFundamentalMatrix(pts1,pts2,'Method','Norm8Point') ;
% f=estimateFundamentalMatrix(pts1,pts2) ;
load('../data/templeCoords.mat')
[x22, y22] = epipolarCorrespondence(i1,i2,f,[x1 y1]) ;
load('../data/intrinsics.mat')
E = essentialMatrix(f,K1,K2) ;

P1 = [1 0 0 0; 0 1 0 0; 0 0 1 0] ;
temp = camera2(E) ;
for j=1:4
    cnt(j)=0;
    P2 =temp(:,:,j) ;
    X(:,:,j) = triangulate(P1, [x1 y1], P2, [x22 y22]) ;
    temp1 = X(:,:,j) ;
    cnt(j)=sum(temp1(:,3)>0) ;
end

corr=X(:,:,find(cnt==max(cnt))) ;
% corr=X(:,:,4) ;
scatter3(corr(:,1),corr(:,3),corr(:,3))

