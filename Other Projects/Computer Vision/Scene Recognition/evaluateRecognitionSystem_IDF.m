load 'visionHarris.mat' ;
load '../data/traintest.mat'
dictionary = dictionaryHarris ;
method = 'chi sq';
    C=zeros(8) ;
%    idf = computeIDF(size(train_imagenames,2)) ;
for i=1:size(test_labels,2)
   I=imread(fullfile(path,char(test_imagenames(i)))) ;
    wrdmap = getVisualWords(I,dictionary,filterBank) ;
    dictionarySize=size(dictionary,1);
    h = getImageFeatures(wrdmap,dictionarySize);
    h = h.*idf ;
    dist = getImageDistance(h, trainFeatures, method);
    t1=find(dist==min(dist)) ;
    C(test_labels(1,i),train_labels(1,t1)) = C(test_labels(1,i),train_labels(1,t1)) +1 ; 
end
accu = trace(C)/(sum(sum(C))) ;
disp('For Random dictionary and euclidean metric')
disp(C)
disp(accu)