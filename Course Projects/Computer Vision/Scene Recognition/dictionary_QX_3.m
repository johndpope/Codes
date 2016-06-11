function [dictionary] = dictionary_QX_3(imgPaths,alpha,K,method)
train_imagenames = imgPaths ;
path='../data' ;
filterBank = g ;
 if strcmp(method,'harris')
    dict = zeros(size(train_imagenames,2)*alpha,size(filterBank,1)*3) ;
 else
    dict_ran = zeros(size(train_imagenames,2)*alpha,size(filterBank,1)*3) ;
 end
for i=1:size(train_imagenames,2)
I=imread(fullfile(path,char(train_imagenames(i)))) ;
m=size(I,1);
n=size(I,2);
if size(I,3)==1
    I(:,:,2)=I(:,:,1);
    I(:,:,3)=I(:,:,1);
end
flt_rspns=extractFilterResponses(I,filterBank);
    if strcmp(method,'harris')
        points = getHarrisPoints(I,alpha,0.04) ;
        for q=1:alpha
            dict((i-1)*alpha+q,:)=flt_rspns(points(q,1),points(q,2),:);
        end
    else
        points = getRandomPoints(I,alpha) ;
        for q=1:alpha
            dict_ran((i-1)*alpha+q,:)=flt_rspns(points(q,1),points(q,2),:);
        end
    end
end

if strcmp(method,'harris')
[val2,dictionaryHarris]=kmeans(dict,K,'MaxIter',200,'EmptyAction','drop') ;
save('dictionaryHarris.mat','dictionaryHarris','filterBank')
dictionary = dictionaryHarris ;
else
[val2,dictionaryRandom]=kmeans(dict_ran,K,'MaxIter',200,'EmptyAction','drop') ;
save('dictionaryRandom.mat','dictionaryRandom','filterBank')
dictionary = dictionaryRandom ;
end

end