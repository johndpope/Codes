% Same code as the evaluate RecognitionSystem_NN.m
% Except that the mycreateFilterBank.m is added separately 
load '../data/traintest.mat' ;
load 'visionRandom.mat' ;

C=zeros(8) ;
dictionary = dictionaryRandom ;
method = 'euclidean';
for i=1:size(test_labels,2)
    I=imread(fullfile(path,char(test_imagenames(i)))) ;
    wrdmap = getVisualWords(I,dictionary,filterBank) ;
    dictionarySize=size(dictionary,1);
    h = getImageFeatures(wrdmap,dictionarySize);
    dist = getImageDistance(h, trainFeatures, method);
    t1=find(dist==min(dist)) ;
    C(test_labels(1,i),train_labels(1,t1)) = C(test_labels(1,i),train_labels(1,t1)) +1 ; 
end
accu = trace(C)/(sum(sum(C))) ;
disp('For Random dictionary and euclidean metric')
disp(C)
disp(accu)

C=zeros(8) ;
dictionary = dictionaryRandom ;
method = 'chi_sq';
for i=1:size(test_labels,2)
   I=imread(fullfile(path,char(test_imagenames(i)))) ;
    wrdmap = getVisualWords(I,dictionary,filterBank) ;
    dictionarySize=size(dictionary,1);
    h = getImageFeatures(wrdmap,dictionarySize);
    dist = getImageDistance(h, trainFeatures, method);
    t1=find(dist==min(dist)) ;
    C(test_labels(1,i),train_labels(1,t1)) = C(test_labels(1,i),train_labels(1,t1)) +1 ; 
end
accu = trace(C)/(sum(sum(C))) ;
disp('For Random dictionary and chi sq metric')
disp(C)
disp(accu)



load '../data/traintest.mat'
load 'visionHarris.mat' ;
C=zeros(8) ;
dictionary = dictionaryHarris ;
method = 'euclidean';
for i=1:size(test_labels,2)
   I=imread(fullfile(path,char(test_imagenames(i)))) ;
    wrdmap = getVisualWords(I,dictionary,filterBank) ;
    dictionarySize=size(dictionary,1);
    h = getImageFeatures(wrdmap,dictionarySize);
    dist = getImageDistance(h, trainFeatures, method);
    t1=find(dist==min(dist)) ;
    C(test_labels(1,i),train_labels(1,t1)) = C(test_labels(1,i),train_labels(1,t1)) +1 ; 
end
accu = trace(C)/(sum(sum(C))) ;
disp('For Harris dictionary and euclidean metric')
disp(C)
disp(accu)


C=zeros(8) ;
dictionary = dictionaryHarris ;
method = 'chi_sq';
for i=1:size(test_labels,2)
   I=imread(fullfile(path,char(test_imagenames(i)))) ;
    wrdmap = getVisualWords(I,dictionary,filterBank) ;
    dictionarySize=size(dictionary,1);
    h = getImageFeatures(wrdmap,dictionarySize);
    dist = getImageDistance(h, trainFeatures, method);
    t1=find(dist==min(dist)) ;
    C(test_labels(1,i),train_labels(1,t1)) = C(test_labels(1,i),train_labels(1,t1)) +1 ; 
end
accu = trace(C)/(sum(sum(C))) ;
disp('For Harris dictionary and chi sq metric')
disp(C)
disp(accu)