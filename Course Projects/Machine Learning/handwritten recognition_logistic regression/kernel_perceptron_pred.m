function pred = kernel_perceptron_pred(a, Y, K, i)
%PERCEPTRON_PRED: Make prediction using Gram matrix of kernel,
%				past labels and counts, and index i.
%   a is counting vector (1 * n)
%   Y is labels of training examples (1 * n)
%	K is the Gram matrix such that K(i, j) = Kernel(X_i, X_j)
%   i is the index of current observation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pred_t=sum(a.*Y.*K(i,:));
pred(pred_t<=0) = -1 ;
pred(pred_t>0) = 1 ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%