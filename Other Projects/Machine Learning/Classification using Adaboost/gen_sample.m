function [ X, y ] = gen_sample( n )
% Generate synthetic dataset for AdaBoost homework
% n is number of samples generated

X = zeros(n, 2);
y = zeros(n, 1);
r = rand(n, 1) * 2;
theta = (rand(n, 1) * 2 - 1) * pi;
X(:,1) = r .* cos(theta);
X(:,2) = r .* sin(theta);
p = 1 ./ (1 + exp( -20 * (r - 1)));
epsilon = (rand(n, 1) * 2 - 1) * 0.1;
y = (p+epsilon > 0.5) * 2 - 1;

end

