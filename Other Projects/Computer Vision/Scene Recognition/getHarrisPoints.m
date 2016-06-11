function [points] = getHarrisPoints(I,alpha,k)
% clear
% I = imread('../data/airport/sun_afacqjwmeipxtsdu.jpg') ;
% I1 = I;
% alpha = 500 ;
% k = 0.06 ;
if size(I,3)==3
    I_gray = rgb2gray(I) ;
else
    I_gray = I ;
end

fx = fspecial('sobel');
gx = filter2(fx,I_gray);
fy = fx' ;
gy = filter2(fy,I_gray); 

h=fspecial('gaussian',[7 7],2);  
m11 = filter2(h,gx.*gx) ;
m12 = filter2(h,gx.*gy) ;
m13 = filter2(h,gx.*gy) ;
m14 = filter2(h,gy.*gy) ;
R = (m11.*m14 - m12.*m13) - k*(m11 + m14).*(m11 + m14) ;

cnt = 1;
Rmax=max(max(R));

% Working code starts
R2 = zeros(size(R)) ;
for i = 2:size(I,1)-1
for j = 2:size(I,2)-1
if R(i,j) > R(i-1,j-1) && R(i,j) > R(i-1,j) && R(i,j) > R(i-1,j+1) && R(i,j) > R(i,j-1) && R(i,j) > R(i,j+1) && R(i,j) > R(i+1,j-1) && R(i,j) > R(i+1,j) && R(i,j) > R(i+1,j+1)
result(i,j) = 1;
R2(i,j) = R(i,j) ;
cnt = cnt+1;
end;
end;
end;
cnt ;

% Working code ends

% [posc, posr] = find(result == 1);
%  imshow(I);
%  hold on;
%  plot(posr,posc,'r.');


 [ind1, ind]=sort(R2(:),'descend') ;
 [points(:,1),points(:,2)] = ind2sub(size(R2),ind(1:alpha)); 
%   imshow(I); hold on ; 
%   plot(points(:,2),points(:,1),'r.')