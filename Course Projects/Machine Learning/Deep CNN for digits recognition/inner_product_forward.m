function [output] = inner_product_forward(input, layer, param)

%% function input:
% input.batch_size: batch_size of input
% input.height: height of input
% input.width : width of input
% input.data: the actual data of input
% input.data is of size (input.height*input.width*input.channel, input.batch_size)
% layer.num: output dimension of this layer

% param.w: weight parameter of this layer, is of size 
% (input.height*input.width*input.channel, layer.num)
% param.b: bias parameter of this layer, is of size
% (1, layer.num);

%% function output
% output: the output of inner_product_forward


%% here begins the inner product forward computation
% set the shape of output
output.height = 1;
output.width = 1;
output.channel = layer.num;
output.batch_size = input.batch_size;

% sanity check
d = size(input.data, 1);
assert(size(param.w, 1) == d, 'dimension mismatch in inner_product layer');

% initialize the outupt data
output.data = zeros(layer.num, input.batch_size);

% start to work here to compute output.data
dt = input.data ;
for i=1:input.batch_size
    dti=dt(:,i);
    output.data(:,i) = (dti'*param.w + param.b)' ;
    
end
end
