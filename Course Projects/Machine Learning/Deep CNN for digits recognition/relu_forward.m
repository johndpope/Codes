function [output] = relu_forward(input, layer)

%% function input
% input.data: actual input data of relu layer

%% function output
% output: the output of relu_forward function

%% here begins the relu forward computation

% set the shape of output
dt = input.data ;

output.height = input.height;
output.width = input.width;
output.channel = input.channel;
output.batch_size = input.batch_size;

h_in = input.height ;
w_in = input.width ;
c = input.channel ;
outdt = zeros(h_in,w_in,c) ;

% start to work here to compute output.data

        for i1=1:input.batch_size
            dti=reshape(dt(:,i1),h_in,w_in,c) ;
            for j1=1:c
                for k1=1:h_in
                    for l1=1:w_in
                        outdt(k1,l1,j1)=max(0,dti(k1,l1,j1));
                    end
                end
            end
            output.data(:,i1)= reshape(outdt,h_in*w_in*c,1) ;
        end


end
