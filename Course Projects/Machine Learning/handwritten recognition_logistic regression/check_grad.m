load lr_train.mat;

% initialize
epsilon = 1e-6;
num_iter = 2;

w = rand(size(train.X, 1), 1) * 1e-4;
d = length(w);
err = zeros(d, 1);
y = train.y ;

[f, g] = fv_grad(w, train.X, train.y);

for i = 1 : num_iter
    grad_approx = zeros(d, 1);
    for j = 1 : d
        w1 = w;
        w2 = w ;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Your code here:
        w1(j) = w1(j) + epsilon ;
        w2(j) = w2(j) - epsilon ;
        grad_approx(j) = sum([y 1-y].*[log(sigmoid(w1'*train.X)) log(1-sigmoid(w1'*train.X))]) - sum([y 1-y].*[log(sigmoid(w2'*train.X)) log(1-sigmoid(w2'*train.X))]);
        grad_approx(j) = -grad_approx(j)/(2*epsilon) ;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    err(i) = 1 / d * sum(abs(grad_approx - g));
end

if mean(err) < 1e-6
    fprintf('pass!')
else
    fprintf('fail.')
end