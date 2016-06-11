function [p] = NB_YPrior(yTrain)
  p = 1-mean(yTrain-1) ;
end
