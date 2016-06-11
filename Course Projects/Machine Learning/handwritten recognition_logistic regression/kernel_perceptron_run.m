clear variables;
load perceptron_train.mat; load perceptron_test.mat;

% Visualize the data
display_network(train.X(:,1:100));

% Normalize and center training data
train.X = standardize(train.X);
test.X = standardize(test.X);

% Add a row of 1's as x0 to introduce intercept
train.X = [ones(1, size(train.X, 2)); train.X];
test.X = [ones(1, size(test.X, 2)); test.X];

% Initialize
w0 = zeros(1, size(train.X, 2));

% Train
w = kernel_perceptron(w0, train.X, train.y);

% Print out training accuracy
K = polykernel(train.X,train.X);
for i=1:size(train.X,2); train_pred(i) = kernel_perceptron_pred(w,  train.y, K, i); end
trainnacc = train_pred == train.y;
trainacc = sum(trainnacc) / length(train.y);

fprintf('Your training accuracy is:%6.4f%%\n', 100 * trainacc);

% Print out cross-validation accuracy
K = polykernel(test.X,train.X);
for i=1:size(test.X,2); test_pred(i) = kernel_perceptron_pred(w,  train.y, K, i); end
testnacc = test_pred == test.y;
testacc = sum(testnacc) / length(test.y);

fprintf('Your test accuracy is:%6.4f%%\n', 100 * testacc);