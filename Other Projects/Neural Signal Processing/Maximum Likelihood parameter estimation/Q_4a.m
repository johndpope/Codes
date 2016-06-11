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

% Gaussian - shared Covariance
gau1_p = n/(8*n) ;
gau1_mu = zeros(97,8) ;
gau1_sig = zeros(97,97,8) ;
for i=1:8
    gau1_mu(:,i)=mean(k1(:,:,i),2);
    gau1_sig(1:97,1:97,i) = (k1(:,:,i)' - ones(91,1)*(gau1_mu(:,i))')'*(k1(:,:,i)' - ones(91,1)*(gau1_mu(:,i))')/n ;
end

sig = sum(gau1_sig,3)*n/(8*n);



% testing
k2 = zeros(97,91,8);
ind = zeros(91,8) ;
for i=1:8
    for j=1:91
        temp2=test_trial(j,i).spikes ;
        k2(1:97,j,i)=(sum(temp2(:,351:550),2));
        for m=1:8
            t(m) = gau1_mu(:,m)'*inv(sig)*k2(1:97,j,i) - gau1_mu(:,m)'*inv(sig)*gau1_mu(:,m)/2 + log(1/8) ;
%            cl_pr(j,i,m)=gau1_mu(:,m)'*inv(sig)*k2(1:97,j,i) - gau1_mu(:,m)'*inv(sig)*gau1_mu(:,m)/2 + log(1/8) ; 
        end
        ind(j,i)=find(t==max(t)) ;
    end
end

for i=1:8
    ori_ind(:,i)=ones(91,1)*i ;
end
cnt_errors = sum(sum(bsxfun(@ne,ori_ind,ind))) ;
cnt_crt_perc = (8*91 - cnt_errors)/(8*91) ;