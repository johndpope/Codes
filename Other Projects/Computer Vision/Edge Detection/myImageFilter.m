function [img1] = myImageFilter(img0, h)
sim = size(img0) ;
sh = size(h) ;
img2 = padarray(img0,[(sh(1)-1)/2,(sh(2)-1)/2],'replicate') ;
img3 = img2(:) ;

h1 = [h zeros(sh(1), sim(2)-1)] ;
h2 = [h1 ; zeros(sim(1)-1, size(h1,2))] ;

h3 = h2(:) ;
first = (sh(2)-1)/2*(sim(1)+sh(1)-1) + (sh(1)-1)/2 + 1 ;
for i=1:sim(1)*sim(2)
    [m,n] = ind2sub(size(img0),i) ;
    img1(i) = sum(sum(h.*img2(m:m+sh(1)-1,n:n+sh(2)-1))) ;
end

img1 = reshape(img1,sim(1),sim(2)) ;
end