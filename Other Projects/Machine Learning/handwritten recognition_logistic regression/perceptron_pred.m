function pred = perceptron_pred(w, x)
%PERCEPTRON_PRED: Make prediction using weight vector w and feature vector
%x
%   w is weight vector (d * 1)
%   x is feature vector (d * 1)
%   pred is binary prediction result based on w and x

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pred_t=w'*x;
pred(pred_t<=0)=-1;
pred(pred_t>0)=1 ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%