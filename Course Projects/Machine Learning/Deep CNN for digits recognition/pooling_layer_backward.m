function [input_od] = pooling_layer_backward(output1, input, layer)

%% function input:
% input: input of pooling_layer_forward
% output: output of pooling_layer_forward

% layer.k: kernel size of pooling operation
% layer.stride: stride of pooling operation
% layer.pad: pad of pooling operation


%% function output
% input_od: gradient w.r.t input.data

% initialize
input_od = zeros(size(input.data)) ;
diff1 = zeros(size(input.data)) ;

h = input.height ;
h_out = output1.height ;
w = input.width ;
w_out = output1.width ;
c = input.channel ;
stride = layer.stride ;
k = layer.k ;
batch_size = input.batch_size ;
out_df = output1.diff ;
indt = input.data ;
switch layer.act_type
    case 'AVE'
        % work out the max pooling and compute output.data
        for i1=1:batch_size
            dti=reshape(diff1(:,i1),h,w,c) ;
            dti2 = reshape(out_df(:,i1),h_out,w_out,c) ;
            diff2 = reshape(input_od(:,i1),h,w,c) ;
            for j1=1:c
                for k1=1:stride:h
                    for l1=1:stride:w
                        dti(k1:k1+k-1,l1:l1+k-1,j1) = dti(k1:k1+k-1,l1:l1+k-1,j1) + ones(k,k)/(k*k);
                        diff2(k1:k1+k-1,l1:l1+k-1,j1) = diff2(k1:k1+k-1,l1:l1+k-1,j1) + dti2(round(k1/stride),round(l1/stride),j1)*ones(k,k) ;
                    end
                end
            end
            diff1(:,i1)= reshape(dti,h*w*c,1) ;
            input_od(:,i1) = reshape(diff2,h*w*c,1) ;
        end
        input_od = input_od.*diff1 ;
      
    case 'MAX'
        % work out the average pooling and compute output.data
        for i1=1:batch_size
            dti=reshape(diff1(:,i1),h,w,c) ;
            dti2 = reshape(out_df(:,i1),h_out,w_out,c) ;
            diff2 = reshape(input_od(:,i1),h,w,c) ;
            diff3 = reshape(indt(:,i1),h,w,c) ;
            for j1=1:c
                for k1=1:stride:h
                    for l1=1:stride:w
                        temp=(diff3(k1:k1+k-1,l1:l1+k-1,j1)>= max(max(diff3(k1:k1+k-1,l1:l1+k-1,j1)))) ;
                        dti(k1:k1+k-1,l1:l1+k-1,j1) = dti(k1:k1+k-1,l1:l1+k-1,j1) + temp;
                        diff2(k1:k1+k-1,l1:l1+k-1,j1) = diff2(k1:k1+k-1,l1:l1+k-1,j1) + dti2(round(k1/stride),round(l1/stride),j1)*temp ;
                    end
                end
            end
            diff1(:,i1)= reshape(dti,h*w*c,1) ;
            input_od(:,i1) = reshape(diff2,h*w*c,1) ;
        end
        input_od = input_od.*diff1 ;
        
end

end