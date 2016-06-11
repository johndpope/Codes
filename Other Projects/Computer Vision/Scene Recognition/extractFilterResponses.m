function [filterResponses] = extractFilterResponses(I,filterBank)
% clear
% I = imread('../data/airport/sun_aerinlrdodkqnypz.jpg') ;
% filterBank = createFilterBank ;
I_lab=RGB2Lab(I) ;
for i=1:size(filterBank,1)
    h = filterBank{i,1};
    filterResponses(:,:,3*i-2)=imfilter(I_lab(:,:,1),h);
    filterResponses(:,:,3*i-1)=imfilter(I_lab(:,:,2),h);
    filterResponses(:,:,3*i)=imfilter(I_lab(:,:,3),h);
end
end