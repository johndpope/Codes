function [pred,model1] = adaboost(trainX,trainy,testX,T)
[~,model ] = adabst('train',trainX,trainy,T) ;
[pred,model1] = adabst('apply',testX, model) ;
for i=1:T
    error(i)=model1(i).error ;
end
end