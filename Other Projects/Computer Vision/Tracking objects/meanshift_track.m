function [ newrect ] = meanshift_track( q, newframe, rect, k, gx, gy)
dx = 1 ;
dy = 1 ;
nm = norm([dx dy]) ;
eps = 10^(-2) ;
newrect = rect ;
while (nm > eps)
    [ p, hue  ] = get_hue_histogram(newframe, newrect, k);
    w=get_weights( p, q, hue ) ;
    [ dx, dy ] = calculate_mean_shift( newrect(3), newrect(4), w, gx, gy ) ;
    newrect(1)=newrect(1)+dx ;
    newrect(2)=newrect(2)+dy ;
    nm = norm([dx dy]) ;
end


