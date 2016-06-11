function [d] = upd_dist(X,Y,d,alpha,h1,h2,dir,err)
for k=1:size(X,1)
    if dir==1
        if ((Y(k)==1 && X(k,h2) >= h1) || (Y(k)==-1 && X(k,h2) <= h1))
            d(k)=d(k)*exp(-alpha)/(2*sqrt(err*(1-err))) ;
        else
            d(k)=d(k)*exp(alpha)/(2*sqrt(err*(1-err)))  ;
        end
    else
        if ((Y(k)==1 && X(k,h2) <= h1) || (Y(k)==-1 && X(k,h2) >= h1))
            d(k)=d(k)*exp(-alpha)/(2*sqrt(err*(1-err))) ;
        else
            d(k)=d(k)*exp(alpha)/(2*sqrt(err*(1-err)))  ;
        end
    end
end
end