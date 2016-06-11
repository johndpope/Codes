function params = init_convnet(layers)

% initialize the parameters of all layers
h = layers{1}.height;
w = layers{1}.width;
c = layers{1}.channel;
for i = 2:length(layers)
    switch layers{i}.type
        case 'CONV'
            % initialize the parameter of conv layers
            scale = sqrt(3/(h*w*c));
            % shape: (kxkc/group, num)
            params{i-1}.w = 2*scale*rand(layers{i}.k*layers{i}.k*c/layers{i}.group, layers{i}.num) - scale;
            params{i-1}.b = zeros(1, layers{i}.num);
            h = (h + 2*layers{i}.pad - layers{i}.k) / layers{i}.stride + 1;
            w = (w + 2*layers{i}.pad - layers{i}.k) / layers{i}.stride + 1;
            c = layers{i}.num;
        case 'POOLING'
            % there is no parameter for pooling operation
            h = (h - layers{i}.k) / layers{i}.stride + 1;
            w = (w - layers{i}.k) / layers{i}.stride + 1;
            params{i-1}.w = [];
            params{i-1}.b = [];
        case 'IP'
            % initialize the parameter of inner product layer 
            switch layers{i}.init_type
                % gaussian initialization
                case 'gaussian'
                    scale = sqrt(3/(h*w*c));
                    % shape: (h*w*c, num)
                    params{i-1}.w = scale*randn(h*w*c, layers{i}.num);
                    params{i-1}.b = zeros(1, layers{i}.num);
                case 'uniform'
                    % uniform initialization
                    scale = sqrt(3/(h*w*c));
                    params{i-1}.w = 2*scale*rand(h*w*c, layers{i}.num) - scale;
                    params{i-1}.b = zeros(1, layers{i}.num);
            end
            h = 1;
            w = 1;
            c = layers{i}.num;
        case 'RELU'
            % no parameter for relu layer
            params{i-1}.w = [];
            params{i-1}.b = [];
        case 'LOSS'
            % initialize the parameter of inner product layer
            % shape: (h*w*c, num)
            scale = sqrt(3/(h*w*c));
            % last layer is K-1
            params{i-1}.w = 2*scale*rand(h*w*c, layers{i}.num - 1) - scale;
            params{i-1}.w = params{i-1}.w';
            params{i-1}.b = zeros(1, layers{i}.num - 1);
            params{i-1}.b = params{i-1}.b';
            h = 1;
            w = 1;
            c = layers{i}.num;
    end
end
end