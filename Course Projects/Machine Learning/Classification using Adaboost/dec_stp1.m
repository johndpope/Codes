function [h1, h2, h3, err] = dec_stp(X,Y,d)

coor = [-2:0.01:2] ;
for j=1:size(coor,2)
    errx1(j) = sum((Y==1).*(X(:,1)<coor(j)).*d + (Y==-1).*(X(:,1)>coor(j)).*d) ;
    errx2(j) = sum((Y==1).*(X(:,1)>coor(j)).*d + (Y==-1).*(X(:,1)<coor(j)).*d) ;
    erry1(j) = sum((Y==1).*(X(:,2)<coor(j)).*d + (Y==-1).*(X(:,2)>coor(j)).*d) ;
    erry2(j) = sum((Y==1).*(X(:,2)>coor(j)).*d + (Y==-1).*(X(:,2)<coor(j)).*d);
end
if((min(errx1) <= min(erry1)) && (min(errx1) <= min(erry2)) && (min(errx1) <= min(errx2)))
        h1=coor(find(errx1==min(errx1),1));
        err = min(errx1);
        h2=1;
        h3=1 ;
elseif ((min(erry1) <= min(errx1)) && (min(erry1) <= min(erry2)) && (min(erry1) <= min(errx2)))
        h1=coor(find(erry1==min(erry1),1));
        err = min(erry1);
        h2=2;
        h3=1 ;
elseif ((min(errx2) <= min(erry1)) && (min(errx2) <= min(erry2)) && (min(errx2) <= min(errx1)))
        h1=coor(find(errx2==min(errx2),1));
        err = min(errx2);
        h2=1;
        h3=-1;
elseif ((min(erry2) <= min(erry1)) && (min(erry2) <= min(errx2)) && (min(erry2) <= min(errx1)))
        h1=coor(find(erry2==min(erry2),1));
        err = min(erry2);
        h2=2;
        h3=-1;
end
end