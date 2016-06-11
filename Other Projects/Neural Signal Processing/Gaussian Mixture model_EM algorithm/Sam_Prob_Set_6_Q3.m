clear
load('ps6_data.mat')
mu = InitParams2.mu ;
sig(:,:,1) = InitParams2.Sigma ;
sig(:,:,2) = InitParams2.Sigma ;
sig(:,:,3) = InitParams2.Sigma ;
pi = InitParams2.pi ;

% iteration starts
for i=1:100
norm(:,1)=mvnpdf(Spikes',mu(:,1)',sig(:,:,1)) ;
norm(:,2)=mvnpdf(Spikes',mu(:,2)',sig(:,:,2)) ;
norm(:,3)=mvnpdf(Spikes',mu(:,3)',sig(:,:,3)) ;
temp = norm(:,1)*pi(1) + norm(:,2)*pi(2) + norm(:,3)*pi(3) ;
gamma(:,1)=(norm(:,1)*pi(1))./temp ;
gamma(:,2)=(norm(:,2)*pi(2))./temp ;
gamma(:,3)=(norm(:,3)*pi(3))./temp ;

N=sum(gamma) ;
mu = (gamma'*Spikes')' ;
mu(:,1)=mu(:,1)/N(1) ;
mu(:,2)=mu(:,2)/N(2) ;
mu(:,3)=mu(:,3)/N(3) ;

sig(:,:,1)=((repmat(gamma(:,1),1,31))'.*(Spikes-repmat(mu(:,1),1,552)))*(Spikes-repmat(mu(:,1),1,552))'/N(1);
sig(:,:,2)=((repmat(gamma(:,2),1,31))'.*(Spikes-repmat(mu(:,2),1,552)))*(Spikes-repmat(mu(:,2),1,552))'/N(2);
sig(:,:,3)=((repmat(gamma(:,3),1,31))'.*(Spikes-repmat(mu(:,3),1,552)))*(Spikes-repmat(mu(:,3),1,552))'/N(3);


pi=N/sum(N) ;
t1=norm(:,1)*pi(1)+norm(:,2)*pi(2)+norm(:,3)*pi(3) ;
likli(i)=sum(log(t1)) ;
end

plot(likli)