function [ pred ] = lr_pred( w, X )
%LR_PRED: Make prediction using weight vector w and feature matrix X
%   w is weight vector (d * 1)
%   x is feature matrix (d * n)
%   pred is binary prediction result based on w and X

pred = zeros(size(X,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here
pred = round(sigmoid(w'*X));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

