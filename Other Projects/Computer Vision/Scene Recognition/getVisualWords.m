function [wordMap] = getVisualWords(I,dictionary,filterBank)
wordMap=zeros(size(I,1),size(I,2));
% filterBank = createFilterBank ;
flt_rspns=extractFilterResponses(I,filterBank);
for i=1:size(flt_rspns,1)
    temp=flt_rspns(i,1:size(flt_rspns,2),1:size(flt_rspns,3));
    temp1=(reshape(temp,size(temp,2),size(temp,3)));
    temp2= pdist2(temp1,dictionary,'euclidean') ;
    [~,ind] = min(temp2');
    wordMap(i,:)=ind;
end
end