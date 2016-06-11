function [yHat] = NB_Classify(D, p, XTest)
 [m,n]=size(XTest) ;
  yHat=zeros(m,1) ;

  for i=1:m
    prob=zeros(2,1); 
        prob(1)=sum(log(D(1,find(XTest(i,:)==1)))) + sum(log(1-D(1,find(XTest(i,:)==0))));
        prob(2)=sum(log(D(2,find(XTest(i,:)==1)))) + sum(log(1-D(2,find(XTest(i,:)==0))));
      yHat(i)=2-ge((prob(1)+log(p)),(prob(2)+log(1-p)));
  end
end
