% Q3.1.4
function [I1_matched_pts,I2_matched_pts] = MatchP(I1, I2)

img1=I1;
img2=I2;

% img2=imread('../data/cv_cover.jpg') ;
% img1=imread('../data/cv_desk.png') ;


if size(img1,3) == 3
    i1_gr = rgb2gray(img1);
else
    i1_gr = img1 ;
end
if size(img2,3) == 3
    i2_gr = rgb2gray(img2);
else
    i2_gr = img2;
end


p1 = detectFASTFeatures(i1_gr) ;
[pts11,desc1]=computeBrief(i1_gr,p1.Location) ;

p2 = detectFASTFeatures(i2_gr) ;
[pts22,desc2]=computeBrief(i2_gr,p2.Location) ;

idx = matchFeatures(desc1,desc2,'MaxRatio',0.8,'MatchThreshold',80);
I1_matched_pts=pts11(idx(:,1),:) ;
I2_matched_pts=pts22(idx(:,2),:) ;
showMatchedFeatures(i1_gr, i2_gr, I1_matched_pts, I2_matched_pts, 'montage')
% showMatchedFeatures(i1_gr, i2_gr, mat_p1.Location, mat_p2.Location, 'montage')

% I1_matched_pts = mat_p1.Location ;
% I2_matched_pts = mat_p2.Location ;



