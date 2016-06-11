clear
rand('seed', 100000)
randn('seed', 100000)

% lenet configuration

% first layer is data layer
layers{1}.type = 'DATA';
% define the input shape
layers{1}.height = 28;
layers{1}.width = 28;
layers{1}.channel = 1;
layers{1}.batch_size = 64;

layers{2}.type = 'CONV'; % second layer is conv layer
layers{2}.num = 20; % number of output channel
layers{2}.k = 5; % kernel size
layers{2}.stride = 1; % stride size
layers{2}.pad = 0; % padding size
layers{2}.group = 1; % group of input feature maps
                     % you can ignore this 

                     
layers{3}.type = 'POOLING'; % third layer is pooling layer
layers{3}.act_type = 'MAX'; % use max pooling
layers{3}.k = 2; % kernel size
layers{3}.stride = 2; % stride size
layers{3}.pad = 0; % padding size

layers{4}.type = 'CONV';
layers{4}.k = 5;
layers{4}.stride = 1;
layers{4}.pad = 0;
layers{4}.group = 1;
layers{4}.num = 50;


layers{5}.type = 'POOLING';
layers{5}.act_type = 'MAX';
layers{5}.k = 2;
layers{5}.stride = 2;
layers{5}.pad = 0;

layers{6}.type = 'IP'; % inner product layer
layers{6}.num = 500; % number of output dimension
layers{6}.init_type = 'uniform'; % initialization method 

layers{7}.type = 'RELU'; % relu layer

layers{8}.type = 'LOSS'; % loss layer
layers{8}.num = 10; % number of classes (10 digits)


% load data
load_mnist_all

xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;

% learning rate parameters
mu = 0.9; % momentum
epsilon = 0.01; % initial learning rate
gamma = 0.0001; 
power = 0.75;
weight_decay = 0.0005; % weight decay on w


% display information
test_interval = 500;
display_interval = 10;
snapshot = 5000;
max_iter = 1000;

% initialize all parameters in each layers
params = init_convnet(layers);

% buffer for sgd momentum
param_winc = params;
for l_idx = 1:length(layers)-1
    param_winc{l_idx}.w = zeros(size(param_winc{l_idx}.w));
    param_winc{l_idx}.b = zeros(size(param_winc{l_idx}.b));
end

for iter = 1 : max_iter
    % randomly fetch a batch
    id = randi([1 m_train], batch_size, 1);

    % forward and backward
    [cp, param_grad] = conv_net(params, layers, xtrain(:, id), ytrain(id));

    % get learning rate
    rate = get_lr(iter, epsilon, gamma, power);
    % update param with sgd momentum
    [params, param_winc] = sgd_momentum(rate, mu, weight_decay, params, param_winc, param_grad);

    if mod(iter, display_interval) == 0
        fprintf('iteration %d training cost = %f accuracy = %f\n', iter, cp.cost, cp.percent);
    end
    
    % validate on the test partition
    if mod(iter, test_interval) == 0
        layers{1}.batch_size = 10000;
        [cptest] = conv_net(params, layers, xtest, ytest);
        layers{1}.batch_size = 64;
        fprintf('test accuracy: %f \n\n', cptest.percent);

    end
    % save model
    if mod(iter, snapshot) == 0
        filename = 'lenet.mat';
        save(filename, 'params');
    end
end
