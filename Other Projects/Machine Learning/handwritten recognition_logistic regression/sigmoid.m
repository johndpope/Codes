function [ s ] = sigmoid( a )
%SIGMOID computes the sigmoid of input a

% a is 1 * n vector
% s is 1 * n vector

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here:
%%%%%%%%%%%%%%%%%%%%%%%%%%%

s = 1./(1+exp(-a));

end

