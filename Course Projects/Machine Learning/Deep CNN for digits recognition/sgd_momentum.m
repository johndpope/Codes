function [params, param_winc] = sgd_momentum(rate, mu, weight_decay, params, param_winc, param_grad)
% update the parameter with sgd with momentum

%% function input
% rate: learning rate at current step
% mu: momentum
% weight_decay: weigth decay of w
% params: original weight parameter
% param_winc: buffer to store history gradient accumulation
% param_grad: gradient of parameter

%% function output
% params: updated parameters
% param_winc: updated buffer

for l_idx =1:length(params)
    param_winc{l_idx}.w=mu*param_winc{l_idx}.w + rate*(param_grad{l_idx}.w + weight_decay*params{l_idx}.w) ;
    param_winc{l_idx}.b=mu*param_winc{l_idx}.b + rate*(param_grad{l_idx}.b) ;    
    
    params{l_idx}.w = params{l_idx}.w - param_winc{l_idx}.w ;
    params{l_idx}.b = params{l_idx}.b - param_winc{l_idx}.b ;    
end

end
