clear
load ps3_realdata.mat

k1 = zeros(97,91,8);

for i=1:8
    for j=1:91
        temp1=train_trial(j,i).spikes ;
        k1(1:97,j,i)=(sum(temp1(:,351:550),2));
    end
end

n = 91 ;

% Poisson
gau1_p = n/(8*n) ;
lambda = zeros(97,8) ;
for i=1:8
        lambda(:,i) = mean(k1(1:97,1:91,i),2) ;
end

% Problem 4d added part
 lambda(lambda==0)=0.01 ;

% testing
k2 = zeros(97,91,8);
ind = zeros(91,8) ;
for i=1:8
    for j=1:91
        temp2=test_trial(j,i).spikes ;
        k2(1:97,j,i)=(sum(temp2(:,351:550),2));
        for m=1:8
            t(m) = (k2(1:97,j,i))'*log(lambda(:,m)) - sum(lambda(:,m)) + log(1/8) ;
        end
        ind(j,i)=find(t==max(t)) ;
    end
end

for i=1:8
    ori_ind(:,i)=ones(91,1)*i ;
end
cnt_errors = sum(sum(bsxfun(@ne,ori_ind,ind))) ;
cnt_crt_perc = (8*91 - cnt_errors)/(8*91)*100 ;
