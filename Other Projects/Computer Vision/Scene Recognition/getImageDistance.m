function [dist] = getImageDistance(hist1, hist2, method)
if strcmp(method,'euclidean')
    dist = pdist2(hist1,hist2);
else
    m = size(hist1,1);  n = size(hist2,1);
    mOnes = ones(1,m); dist = zeros(m,n);
    for i=1:n
      yi = hist2(i,:);  yiRep = yi( mOnes, : );
      s = yiRep + hist1;    d = yiRep - hist1;
      dist(:,i) = sum( d.^2 ./ (s+eps), 2 );
    end
    dist = dist/2;
end


end