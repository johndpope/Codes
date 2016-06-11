function [u,v] = LucasKanade(It, Itt1, rect)
del_p = 1 ;
eps = 10^-2 ;
p = [0 0 0 0 0 0] ;
Itt = It(rect(1):rect(1)+rect(3) , rect(2):rect(2)+rect(4)) ;
It1 = Itt1 ;
hes = zeros(6,6) ;
tt = zeros(6,1) ;
[x,y]=meshgrid(rect(1):rect(1)+rect(3),rect(2):rect(2)+rect(4)) ;
h = [1 0 0 ; 0 1 0 ; 0 0 1 ] ;
while del_p > eps
    h = h + [ p(1) p(3) p(5) ; p(2) p(4) p(6) ; 0 0 0] ;
    It1=warpH(It1, h, size(It1)) ;
    im=It1(rect(1):rect(1)+rect(3) , rect(2):rect(2)+rect(4)) ;    
    [gx,gy]=imgradientxy(im) ;
    temp=([ gx(:).*x(:) gy(:).*x(:) gx(:).*y(:) gy(:).*y(:) gx(:) gy(:)]) ;
    hes = temp'*temp ;
    p = inv(hes)*(sum(temp.*repmat((im2double(Itt(:)-im(:))),1,6)))' ;
    del_p=norm(p) ;
end

uu = h*[rect(1) ; rect(2) ; 1] ;
u = p(5) ;
v = p(6) ;
    