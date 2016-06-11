clear
trainsize = 400;
testsize = 100;
num_iter = 20;
[train.X, train.y] = gen_sample(trainsize);
[test.X, test.y] = gen_sample(testsize);


% function pred = adaboost(trainX, trainY, testX, T)

trainX=train.X ;
trainY=train.y ;
d = ones(size(trainX,1),1)/size(trainX,1) ;
T= num_iter ;
coor = [-2:0.01:2] ;
alpha = zeros(T,1) ;
err = zeros(T,1);
for i=1:T
    temp1=0 ;
    temp2=0 ;
    errx = zeros(401,1) ;
    erry = zeros(401,1) ;
    for j=1:size(coor,2)
%        for k=1:size(trainX,1)
            errx(j) = sum((trainY==1).*(trainX(:,1)<coor(j)).*d + (trainY==-1).*(trainX(:,1)>coor(j)).*d) ;
            erry(j) = sum((trainY==1).*(trainX(:,2)<coor(j)).*d + (trainY==-1).*(trainX(:,2)>coor(j)).*d) ;
%             if ((trainY(k)==1 && trainX(k,1) > coor(j)) || (trainY(k)==-1 && trainX(k,1) < coor(j)) )
%                 errx(j) = errx(temp1) + d(k) ;
%             end
%             if ((trainY(k)==1 && trainX(k,2) < coor(j)) || (trainY(k)==-1 && trainX(k,2) < coor(j)) )
%                 erry(j) = erry(temp1) + d(k) ;
%             end
%        end
    end
    if(min(errx) < min(erry))
        h(i,1)=coor(find(errx==min(errx),1));
        err(i) = min(errx);
        h(i,2)=1;
    else
        h(i,1)=coor(find(erry==min(erry),1));
        err(i) = min(erry);
        h(i,2)=2;
    end
    alpha(i) = 1/2*log((1-err(i))/err(i)) ;
    for k=1:size(trainX,1)
        if ((trainY(k)==1 && trainX(k,h(i,2)) > h(i,1)) || (trainY(k)==-1 && trainX(k,h(i,2)) < h(i,1)))
            d(k)=d(k)*exp(-alpha(i))/(2*sqrt(err(i)*(1-err(i)))) ;
        else
            d(k)=d(k)*exp(alpha(i))/(2*sqrt(err(i)*(1-err(i))))  ;
        end
    end
    
    
end   
% end