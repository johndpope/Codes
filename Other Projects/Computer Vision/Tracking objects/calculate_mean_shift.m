function [ dx, dy ] = calculate_mean_shift( width, height, w, gx, gy )

[x, y] = meshgrid(1:height, 1:width);

dx =  sum(sum(x.*gx.*w))/sum(sum(gx.*w))/100 ;
dy =  sum(sum(y.*gy.*w))/sum(sum(gy.*w))/100 ;

