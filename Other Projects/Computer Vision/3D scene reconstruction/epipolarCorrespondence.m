function [x22, y22] = epipolarCorrespondence(im1,im2,f,x1)

box=10;
lines=epipolarLine(f,x1) ;
% x=[box+1:size(im2,1)-(box+1)] ;
 for i=1:size(x1,1)
    x=[round(x1(i,1))-20:round(x1(i,1))+20] ;
    y= (-lines(i,1)*x  - lines(i,3))/lines(i,2) ;
    t1=double(im1(x1(i,1)-box:x1(i,1)+box,x1(i,2)-box:x1(i,2)+box)) ;
    for j=1:size(x,2)
        t2=double(im2(x(j)-box:x(j)+box,round(y(j))-box:round(y(j))+box)) ;
        rm(j)=norm(t1-t2) ;
    end
    temp=find(rm==min(rm),1) ;    
    x22(i)=x(temp) ;
    y22(i)=y(temp) ;
 end
x22 = x22' ;
y22 = y22' ;
%     imshow(I2); hold on
%     plot(x,y)
%     plot(x(find(rm==min(rm))),y(find(rm==min(rm))),'+')
%     plot(rm) ;
%     j=find(rm==min(rm)) ;
%     t2=double(im2(x(j)-box:x(j)+box,round(y(j))-box:round(y(j))+box)) ;
%     norm(t1-t2)





% y= (-lines(i,1)*x  - lines(i,3))/lines(i,2) ;
% imshow(im2); hold on
% plot(x,y)
% plot(x1(i,1),x1(i,2),'+')
% 
% y= (-lines(i,1)*x  - lines(i,3))/lines(i,2) ;
% imshow(im1); hold on
% plot(x1(i,1),x1(i,2),'bo')