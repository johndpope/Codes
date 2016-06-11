function [Wout] = affineMBTracker(img, tmp, rect, Win, context)
del_p = 1;
eps = 10^-2 ;
p = [0 0 0; 0 0 0; 0 0 0] ;
j =  context.j ;
hes = context.h ;  
Itt = tmp(rect(1):rect(1)+rect(3) , rect(2):rect(2)+rect(4)) ;
Itt=warpH(Itt, Win, size(Itt)) ;
[gx,gy]=imgradientxy(Itt) ;
p = [1 0 0; 0 1 0; 0 0 1] ;
while del_p > eps
    It1=warpH(img, p, size(img)) ;
    im=It1(rect(1):rect(1)+rect(3) , rect(2):rect(2)+rect(4)) ;
    dp = inv(hes)*j'*((im2double(Itt(:)-im(:)))) ;
    p = p*inv([1+dp(1) dp(3) dp(5) ; dp(2) 1+dp(4) dp(6) ; 0 0 1]) ;
    del_p = norm(dp) ;
end

Wout = p ;