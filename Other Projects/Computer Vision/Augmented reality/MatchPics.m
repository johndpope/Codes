% Q3.1.4
function [I1_matched_pts,I2_matched_pts] = MatchPics(I1, I2)

% img1=imread('../data/cv_cover.jpg') ;
% img2=imread('../data/cv_desk.png') ;

img1=I1;
img2=I2;
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
[feat_1, val_p1] = extractFeatures(i1_gr, p1); 
p2 = detectFASTFeatures(i2_gr) ;
[feat_2, val_p2] = extractFeatures(i2_gr, p2);

% p1 = detectHarrisFeatures(i1_gr) ;
% [feat_1, val_p1] = extractFeatures(i1_gr, p1); 
% p2 = detectHarrisFeatures(i2_gr) ;
% [feat_2, val_p2] = extractFeatures(i2_gr, p2);



 idx = matchFeatures(feat_1,feat_2,'MaxRatio',0.85,'MatchThreshold',70);
% idx = matchFeatures(feat_1,feat_2,'MaxRatio',0.78,'MatchThreshold',90,'Metric','SAD');
mat_p1=val_p1(idx(:,1),:) ;
mat_p2=val_p2(idx(:,2),:) ;

% showMatchedFeatures(i1_gr, i2_gr, mat_p1.Location, mat_p2.Location, 'montage')

I1_matched_pts = mat_p1.Location ;
I2_matched_pts = mat_p2.Location ;