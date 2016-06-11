% Q3.1.5

img1=imread('../data/cv_cover.jpg') ;
i_rot = imrotate(img1,360);
MatchP(i_rot,img1);
saveas(gcf,'360.jpg')
