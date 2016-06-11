function [lines] = myHoughLineSegments(lineRho, lineTheta, Im)

lineRho = rhos ;
lineTheta = thetas ;

sim = size(Im) ;
x=0:max(sim(1),sim(2)) ;
k=1 ;
for i=1:size(lineRho)
y= (lineRho(i) - x*cosd(lineTheta(i)))/sind(lineTheta(i)) ;

y1 = y(y>0 & y<sim(2) & x>0 & x<sim(1) ) ;
x1 = x(x>0 & x<sim(1) & y>0 & y<sim(2)) ;

temp1=0;
temp2=1 ;
for j = 1:size(x1,2)
    
    if (Im(round(x1(j)),round(y1(j)))~=0)
        if (temp1 == 0)
            lines2(k).start = [round(x1(j)),round(y1(j))] ;
            temp1 = 1 ;
            temp2 = 0 ;
        end
    else
        if (temp2 == 0)
            lines2(k).stop = [round(x1(j)),round(y1(j))] ;
            temp2 = 1 ;
            temp1 = 0 ;
            k = k+1 ;
        end
    end
end

end

end