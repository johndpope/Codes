load lr_train.mat ;
X=train.X ;
temp1 = find(train_pred~=train.y) ;
t=temp1(1:16) ;
display_network(X(:,t));