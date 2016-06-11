function w = perceptron(w0, X, Y)
%Perceptron algorithm
%   w0 is the initial weight vector (d * 1)
%   X is feature values of training examples (d * n)
%   Y is labels of training examples (1 * n)

[d,n] = size(X);
maxiter = 100;
stop_criteria = 1;

% WEIGHTING vector "w" initialized to zeros. Use this in your algorithm!
w = w0;

% PREDICTION vector "y_hat" initialized to zeros. Use this in your algorithm!
y_hat = zeros(1,n);
y_hat_prev = y_hat;

for k = 1:maxiter
    
    for i=1:n
    y_hat(i) = perceptron_pred(w,X(:,i)) ;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if(y_hat(i)~=Y(i))
        w = w + Y(i)*X(:,i) ;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    eps = sum(y_hat == y_hat_prev) / length(y_hat);
    fprintf('%21d %20g\n', k, eps);
    if eps >= stop_criteria
        break;
    end
    y_hat_prev = y_hat;
    end
    
end


