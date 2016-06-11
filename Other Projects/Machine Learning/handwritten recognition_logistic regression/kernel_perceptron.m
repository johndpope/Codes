function w = kernel_perceptron(a0, X, Y)
%Kernel perceptron algorithm
%   a0 is the initial count vector (1 * n)
%   X is feature values of training examples (d * n)
%   Y is labels of training examples (1 * n)

[d,n] = size(X);
maxiter = 100;
stop_criteria = 1;

% WEIGHTING vector "a" initialized to zeros. Use this in your algorithm!
a = a0;

% PREDICTION vector "y_hat" initialized to zeros. Use this in your algorithm!
y_hat = zeros(1,n);
y_hat_prev = y_hat;

% The Gram matrix is constructed here.
K = polykernel(X,X);
    
for k = 1:maxiter

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:n
        y_hat(i) = kernel_perceptron_pred(a,Y,K,i);
        if(y_hat(i)~=Y(i))
            a(i)=a(i)+1;
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
w=a;

end