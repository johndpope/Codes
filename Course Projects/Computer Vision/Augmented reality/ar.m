% Q3.3.1
clear
addpath('../ec')
bk_mov=loadVid('../data/book.mov') ;
ar_mov=loadVid('../data/ar_source.mov') ;
i2 = imread('../data/cv_cover.jpg') ;

aviob = VideoWriter('mov.avi') ;
open(aviob)
for i=1:size(ar_mov,2)
    i1 = ar_mov(i).cdata ;
    [p1,p2]=MatchPics(i1,i2) ;
    [h,in]=computeH_ransac(p1,p2) ;
    
    i33 = bk_mov(i).cdata ;
    i3 = imresize(i33,size(i2)) ;
    im_out=warpH(i3, double(h), size(i3)) ;
    m=im2frame(im_out) ;
    writeVideo(aviob,m) ;
end

close(aviob)
