function [ histogram, hue ] = get_hue_histogram( img, rect, k )
% img = imread('../data/desk/frame001.png') ;
h = rgb2hsv(img(rect(1):rect(1)+rect(3)-1,rect(2):rect(2)+rect(4)-1,:)) ;
hist = h(:,:,1) + k;
hue =fix(hist*360) ;
hue(find(hue==0))=1 ;
for i=1:360
    histogram(i) = sum(sum(hue==i)) ;
end

histogram = histogram/sum(histogram) ;