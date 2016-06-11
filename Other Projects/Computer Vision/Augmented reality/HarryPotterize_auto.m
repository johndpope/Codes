% Q3.2.4
i1 = imread('../data/cv_desk.png') ;
% i1 = rgb2gray(i1) ;
i2 = imread('../data/cv_cover.jpg') ;
i33 = imread('../data/hp_cover.jpg') ;
% i33 = rgb2gray(i33) ;
i3 = imresize(i33,size(i2)) ;

[p1,p2]=MatchPics(i1,i2) ;
 [h,in]=computeH_ransac(p1,p2) ;
 
 showMatchedFeatures(i1, i2, p1(find(in==1),:), p2(find(in==1),:), 'montage')

% h=computeH(p2,p1) ;
im_out=warpH(i3, double(h), [700 700]) ;
imshow(im_out)


% h =    [ 0.2116   -0.0888  110.3804 ; -0.0139   -0.0260  297.0922 ; -0.0000   -0.0005    1.0256 ] ;
% 
% H = [0.56 0.26 183 ; -0.1 0.17 149.57 ; -4.5*10^-6 -7.05*10^-4 0.7];
% im_out=warpH(i3, double(H), size(i3)) ;
% imshow(im_out)
% % I3 = im2double(imread('../data/cv_cover.jpg'));
% % H = [-1.0810 -0.5494 454.0512;
% %      -0.6054 -1.4143 511.2218;
% %      -0.0023 -0.0031 1.2831];
% % 
% % warped = warpH(I3, H, [100 100], 0);
% % imshow(warped);
