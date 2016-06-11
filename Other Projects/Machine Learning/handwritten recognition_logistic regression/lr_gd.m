function [ w ] = lr_gd( w0, X, y )
%SGD: Stochastic Gradient Descent for logistic regression
%   w0 is the initial weight vector (d * 1)
%   X is feature values of training examples (d * n)
%   Y is labels of training examples (1 * n)
%   w is the final weight vector (d * 1)

%   This program terminates either when it reaches maximum iteration, or
%   the difference in objective function value is small enough.

step = 1e-5;
max_iter = 1000;
stop_criteria = 4e-4;

w = w0;
f_prev = 1;
fprintf('%16s iter %16s f %16s eps %16s ||w||^2\n', '', '', '', '');
for k = 1:max_iter
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code goes here
    [f, g] = fv_grad(w,X,y) ;
    w = w - step*g ;    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    eps = abs((f - f_prev) / f_prev);
    fprintf('%21d %18g %20g %24g\n', k, f, eps, dot(w,w));
    if eps <= stop_criteria
        break;
    end
    f_prev = f;
end

end

