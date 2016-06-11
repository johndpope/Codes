function [rhos, thetas] = myHoughLines(H, nLines)

img3 = H ;
sim = size(H) ;
for i=2:sim(1)-1
    for j=2:sim(2)-1
                if(H(i,j) < H(i,j+1) || H(i,j) < H(i,j-1) || H(i,j) < H(i-1,j+1 | H(i,j) < H(i+1,j-1) | ...
                      H(i,j) < H(i-1,j) | H(i,j) < H(i+1,j) | H(i,j) < H(i-1,j-1) | H(i,j) < H(i+1,j+1) ))
                    img3(i,j) = 0 ;
                end
    end
end

[B,I] = sort(img3(:),'descend') ;

[rhos,thetas]=ind2sub(size(H),I(1:nLines));

end