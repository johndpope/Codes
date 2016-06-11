% Parameters 
% (Feel free to change the parameters for fun, 
% but use trainsize = 400; testsize = 100; for report)
clear
trainsize = 400;
testsize = 100;
num_iter = 100;
[train.X, train.y] = gen_sample(trainsize);
[test.X, test.y] = gen_sample(testsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Your experiments goes here:
%
[pred,model] = adaboost(train.X,train.y,test.X,num_iter) ;
for i=1:num_iter
aph(i) = model(i).alpha ;
thrs(i) = model(i).threshold ;
dir = model(i).direction ;
dim = model(i).dimension ;

% train data
if dir==1
    vl(:,i) = (train.X(:,dim)>thrs(i)) - (train.X(:,dim)<thrs(i)) ;
else
    vl(:,i) = (train.X(:,dim)<thrs(i)) - (train.X(:,dim)>thrs(i)) ;
end

if i==1
    fin_h_tr(:,i) = aph(i)*vl(:,i) ;
else
    fin_h_tr(:,i) = fin_h_tr(:,i-1) + aph(i)*vl(:,i) ;
end
fin_htr_bin(:,i) = sign(fin_h_tr(:,i)) ;
err_tr(i)=sum(fin_htr_bin(:,i)~=train.y)/size(train.X,1)  ;

% test data
if dir==1
    v2(:,i) = (test.X(:,dim)>thrs(i)) - (test.X(:,dim)<thrs(i)) ;
else
    v2(:,i) = (test.X(:,dim)<thrs(i)) - (test.X(:,dim)>thrs(i)) ;
end

if i==1
    fin_h(:,i) = aph(i)*v2(:,i) ;
else
    fin_h(:,i) = fin_h(:,i-1) + aph(i)*v2(:,i) ;
end
fin_h_bin(:,i) = sign(fin_h(:,i)) ;
err_test(i)=sum(fin_h_bin(:,i)~=test.y)/size(test.X,1)  ;

end
% plot([1:num_iter],err_tr,'b--',[1:num_iter],err_test,'r-')
err_tr(num_iter) ;
err_test(num_iter) ;


% Margin
for i=1:num_iter
    mar(i)=sum((fin_htr_bin(:,i)==train.y).*aph(i) - (fin_htr_bin(:,i)~=train.y).*aph(i)) ;
    error(i) = model(i).error ;
end
min(mar)
max(error)