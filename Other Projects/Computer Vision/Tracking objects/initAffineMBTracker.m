function [affineMBContext] = initAffineMBTracker(img1, rect)
    img = img1(rect(1):rect(1)+rect(3) , rect(2):rect(2)+rect(4)) ;
    [gx,gy]=imgradientxy(img) ;
    [x,y]=meshgrid(1:size(img,1),1:size(img,2)) ;
    
    temp=([ gx(:).*x(:) gy(:).*x(:) gx(:).*y(:) gy(:).*y(:) gx(:) gy(:)]) ;
    hes = temp'*temp ;
    
    affineMBContext.j = temp ;
    affineMBContext.h = (hes) ;    

