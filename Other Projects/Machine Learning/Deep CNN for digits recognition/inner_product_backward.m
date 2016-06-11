function [param_grad, input_od] = inner_product_backward(output1, input, layer, param)

%% function input
% output.data: output data of inner_product_forward
% output.diff: the gradient w.r.t otuput.data

%% function output
% param_grad.w: gradient w.r.t param.w
% param_grad.b: gradient w.r.t param.b
% input_od: gradient w.r.t input.data

%% here begins inner product backward computation

% start to work here to compute param_grad.w, param_grad.b, input_od 
input_od = zeros(size(input.data));
param_grad.b = zeros(size(param.b));
param_grad.w = zeros(size(param.w));

param_grad.b = sum(output1.diff')  ;
param_grad.w = input.data*(output1.diff')  ;

input_od = param.w*output1.diff ;


end
