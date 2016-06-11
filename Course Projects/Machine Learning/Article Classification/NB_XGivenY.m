function [D] = NB_XGivenY(XTrain, yTrain)  
  alpha = 1.001 ;
  beta = 1.9 ;
  y_1=find(yTrain==1);
  y_2=find(yTrain==2);
  
  t1=XTrain(y_1,:);
  t2=XTrain(y_2,:);
  
  D(1,:)=(sum(t1)+alpha-1)/(size(t1,1)+alpha+beta-2);
  D(2,:)=(sum(t2)+alpha-1)/(size(t2,1)+alpha+beta-2);
end
