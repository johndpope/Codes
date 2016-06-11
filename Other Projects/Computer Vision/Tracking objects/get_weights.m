function [ w ] = get_weights( p, q, hue )

w = zeros(size(hue)) ;
tt=zeros(1,360) ;
tt(find(p~=0))=q(find(p~=0))./p(find(p~=0)) ;
for i=1:size(hue,1)
    for j=1:size(hue,2)
        w(i,j) = tt(hue(i,j)) ;
    end
end



