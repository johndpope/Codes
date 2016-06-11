function [ f, g ] = fv_grad( w_curr, X, y )
%FV_GRAD: returns the objective function value f and the gradient g w.r.t w
%at point w_curr
%   w_curr is current weight vector (d * 1)
%   X is feature values (d * n)
%   y is label (1 * n)

% Set parameters
f = 0;
g = zeros(length(w_curr), 1);
lambda_val = 25;
lambda = ones(length(w_curr), 1) * lambda_val;
lambda(1) = 0;  % do not penalize weight associated with the intercept term
f= -(sum([log(sigmoid(X'*w_curr)) log(1-sigmoid(X'*w_curr))].*[y' 1-y']))/size(y,2) ;
f = f(1)+f(2) + sum(lambda.*w_curr.*w_curr);
g = -(((y-sigmoid(w_curr'*X))*X')') + lambda.*w_curr;
 % - 2*lambda.*w_curr/size(y,2); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here...
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

