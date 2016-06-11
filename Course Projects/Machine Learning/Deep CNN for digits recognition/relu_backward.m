function [input_od] = relu_backward(output1, input, layer)

%% function input
% output.data: output data of relu_forward
% output.diff: gradient w.r.t output.data

%% function output
% input_od: gradient w.r.t input.data

%% here begins the relu forward computation

% initialize
input_od = zeros(size(input.data));

temp=input.data>0 ;
input_od = (output1.diff).*(temp) ;
% start to work here to compute input_od


end
