% 3.2.1
function [H2to1] = computeH(p1, p2)

% img1 = imread('../data/cv_cover.jpg');
% img2 = imread('../data/cv_desk.png');
% [p1,p2]=MatchPics(img1,img2) ;

for i=1:size(p1,1)
    A(2*i-1,:)=[-p1(i,1) -p1(i,2) -1 0 0 0 p1(i,1)*p2(i,1) p1(i,2)*p2(i,1) p2(i,1)] ;
    A(2*i,:)=[0 0 0 -p1(i,1) -p1(i,2) -1 p1(i,1)*p2(i,2) p1(i,2)*p2(i,2) p2(i,2)];
end

[~,~,v]=svd(A);
H2to1=(reshape(v(:,9),3,3))';