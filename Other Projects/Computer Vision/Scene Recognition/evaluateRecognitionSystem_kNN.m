load 'visionHarris.mat' ;
load '../data/traintest.mat'
dictionary = dictionaryHarris ;
method = 'chi sq';
for knn=1:40
    C=zeros(8) ;
for i=1:size(test_labels,2)
    I=imread(fullfile(path,char(test_imagenames(i)))) ;
    wrdmap = getVisualWords(I,dictionary,filterBank) ;
    dictionarySize=size(dictionary,1);
    h = getImageFeatures(wrdmap,dictionarySize);
    t1 = knnsearch(trainFeatures,h,'K',knn) ;
    C(test_labels(1,i),train_labels(1,t1)) = C(test_labels(1,i),train_labels(1,t1)) +1 ; 
end
accu(knn) = trace(C)/(sum(sum(C))) ;
end
plot(accu(find(accu~=0)),[1:5:40]) ; xlabel('K') ; ylabel('accuracy');

knn=1 ;
C=zeros(8) ;
for i=1:size(test_labels,2)
    I=imread(fullfile(path,char(test_imagenames(i)))) ;
    wrdmap = getVisualWords(I,dictionary,filterBank) ;
    dictionarySize=size(dictionary,1);
    h = getImageFeatures(wrdmap,dictionarySize);
    t1 = knnsearch(trainFeatures,h,'K',knn) ;
    C(test_labels(1,i),train_labels(1,t1)) = C(test_labels(1,i),train_labels(1,t1)) +1 ; 
end
accur = trace(C)/(sum(sum(C))) ;
disp('For Harris dictionary and euclidean metric')
disp(C)
disp(accur)