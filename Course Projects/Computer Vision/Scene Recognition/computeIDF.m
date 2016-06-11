function idf = computeIDF(p)
load 'visionHarris.mat' ;
dictionary = dictionaryRandom ;
idf = zeros(1,size(dictionary,1));
    for i=1:p
        I=imread(fullfile(path,char(train_imagenames(i)))) ;
        if size(I,3)==1
            I(:,:,2)=I(:,:,1);
            I(:,:,3)=I(:,:,1);
        end
        wrdmap = getVisualWords(I,dictionary,filterBank) ;
        for j=1:size(dictionary,1)
            if sum(sum(wrdmap==j)) >=1
                idf(j) = idf(j)+1 ;
            end
        end
    end
idf = log(p./idf) ;
end