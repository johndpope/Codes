function [Im] = myEdgeFilter(img, sigma)

sim = size(img) ;
hsize = 2*ceil(sigma)+1 ;
h1 = fspecial('gaussian', hsize, sigma) ;

img_gau=myImageFilter(img,h1);

h2_x = fspecial('sobel') ;
h2_y = h2_x' ;

img_sob_x = myImageFilter(img_gau,h2_x) ;
img_sob_y = myImageFilter(img_gau,h2_y) ;
img_sob = sqrt(img_sob_x.^2 + img_sob_y.^2) ;
dir_sob = atand(img_sob_y./img_sob_x) ;

dir_quad = floor(mod(45/2+dir_sob+90,180)/45)+1;
img_nms = img_sob;

for i=2:sim(1)-1
    for j=2:sim(2)-1
        switch dir_quad(i,j)
            case 1
                if(img_sob(i,j) < img_sob(i,j+1) || img_sob(i,j) < img_sob(i,j-1))
                    img_nms(i,j) = 0 ;
                end
            case 2
                if(img_sob(i,j) < img_sob(i-1,j+1) || img_sob(i,j) < img_sob(i+1,j-1))
                    img_nms(i,j) = 0 ;
                end    
            case 3
                if(img_sob(i,j) < img_sob(i-1,j) || img_sob(i,j) < img_sob(i+1,j))
                    img_nms(i,j) = 0 ;
                end    
            case 4
                if(img_sob(i,j) < img_sob(i-1,j-1) || img_sob(i,j) < img_sob(i+1,j+1))
                    img_nms(i,j) = 0 ;
                end
        end
    end
end

Im = img_nms ;
Im(1,:)=0;
Im(sim(1),:)=0;
Im(:,1)=0;
Im(:,sim(2))=0;

end