load '../data/traintest.mat'
load 'dictionaryRandom.mat'

sze = size(dictionary,1) ;

dictionary=dictionaryRandom;
trainFeatures=zeros(size(train_labels,2),size(dictionary,1)) ;
for i=1:size(train_labels,2)
    I=imread(fullfile(path,char(train_imagenames(i)))) ;
    m=size(I,1);
    n=size(I,2);
    if size(I,3)==1
        I(:,:,2)=I(:,:,1);
        I(:,:,3)=I(:,:,1);
    end
    wordMap = getVisualWords(I,dictionary,filterBank) ;
    trainFeatures(i,:) = getImageFeatures(wordMap,sze) ;
end
save('visionRandom.mat','dictionaryRandom','filterBank','trainFeatures','train_labels');

load 'dictionaryHarris.mat'
dictionary=dictionaryHarris;
trainFeatures=zeros(size(train_labels,2),sze) ;
for i=1:size(train_labels,2)
    I=imread(fullfile(path,char(train_imagenames(i)))) ;
    m=size(I,1);
    n=size(I,2);
    if size(I,3)==1
        I(:,:,2)=I(:,:,1);
        I(:,:,3)=I(:,:,1);
    end
    wordMap = getVisualWords(I,dictionary,filterBank) ;
    trainFeatures(i,:) = getImageFeatures(wordMap,sze) ;
end
save('visionHarris.mat','dictionaryHarris','filterBank','trainFeatures','train_labels');