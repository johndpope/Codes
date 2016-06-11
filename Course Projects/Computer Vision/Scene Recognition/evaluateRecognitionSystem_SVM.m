load
load 'visionHarris.mat' ;

C=zeros(8) ;
dictionary = dictionaryRandom ;
method = 'euclidean';
kernel1 = 'linear' ;
kernel2 = 'quadratic' ;
options = optimset('maxiter',1000000);
for j=1:8
    SVMStruct(j) = svmtrain(trainFeatures,train_labels==j,'options',options,'kernel_function',kernel1) ;
end
for i=1:size(test_labels,2)
        I=imread(fullfile(path,char(test_imagenames(i)))) ;
        wrdmap = getVisualWords(I,dictionary,filterBank) ;
        dictionarySize=size(dictionary,1);
        h = getImageFeatures(wrdmap,dictionarySize);
    for j=1:8
        if(svmclassify(SVMStruct(j),h))
            C(test_labels(1,i),j) = C(test_labels(1,i),j) +1 ; 
            break ;
        end
    end
end
accu = trace(C)/(sum(sum(C))) ;
disp(C)
disp(accu)


for j=1:8
    SVMStruct(j) = svmtrain(trainFeatures,train_labels==j,'options',options,'kernel_function',kernel2) ;
end
for i=1:size(test_labels,2)
        I=imread(fullfile(path,char(test_imagenames(i)))) ;
        wrdmap = getVisualWords(I,dictionary,filterBank) ;
        dictionarySize=size(dictionary,1);
        h = getImageFeatures(wrdmap,dictionarySize);
    for j=1:8
        if(svmclassify(SVMStruct(j),h))
            C(test_labels(1,i),j) = C(test_labels(1,i),j) +1 ; 
            break ;
        end
    end
end
accu = trace(C)/(sum(sum(C))) ;
disp(C)
disp(accu)