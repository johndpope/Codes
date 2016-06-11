function [ k, gx, gy ] = get_kernel( type, radius, w, h )

switch type
    case 'Gaussian'
        k = fspecial('gaussian',[w h], radius) ;
        [gx, gy] = gradient(k) ;
    case 'Epanechnikov'
        for i=1:w
            for j=1:h
                d = (( 2*i/(w+1) - 1)^2 + (2*j/(h+1) - 1)^2)^0.5 ;
                if d<=1
                    k(i,j) = 1-d^2/radius ;
                else
                    k(i,j) = 0 ;
                end
            end
        end
        [gx, gy] = gradient(k) ;
end