clear
trainsize = 400;
testsize = 100;
num_iter = 1;
[train.X, train.y] = gen_sample(trainsize);
[test.X, test.y] = gen_sample(testsize);

% function pred = adaboost(trainX, trainY, testX, T)

trainX=train.X ;
trainY=train.y ;
T=num_iter ;
d = ones(size(trainX,1),1)/size(trainX,1) ;
h = zeros(T,2);
dir = zeros(T,1) ;
err = zeros(T,1) ;
for i=1:T
   [h(i,1), h(i,2), dir(i), err(i)]= dec_stp(trainX,trainY,d) ;
   alpha(i) = 1/2*log((1-err(i))/err(i)) ;
   d = upd_dist(trainX,trainY,d,alpha(i),h(i,1),h(i,2),dir(i),err(i));
end

% end