clear
load('ps8_data.mat')
plot(Xsim(:,1),Xsim(:,2),'.')
cv = cov(Xsim-[(ones(1,8)*mean(Xsim(:,1)))' (ones(1,8)*mean(Xsim(:,2)))']);
x_nor=Xsim-[(ones(1,8)*mean(Xsim(:,1)))' (ones(1,8)*mean(Xsim(:,2)))'] ;
[u,v,w]=svd(cv);
hold on;
len = 12; 
plot([len*u(1,1)+mean(Xsim(:,1)) -len*u(1,1)+mean(Xsim(:,1))],[len*u(2,1)+mean(Xsim(:,2)) -len*u(2,1)+mean(Xsim(:,2))],'k')
plot(mean(Xsim(:,1)),mean(Xsim(:,2)),'+g','linewidth',10)
proj=(Xsim-[(ones(1,8)*mean(Xsim(:,1)))' (ones(1,8)*mean(Xsim(:,2)))'])*u(:,1) ;
the=atand(u(1,2)/u(1,1));
p1= -[proj*cosd(the) proj*sind(the)] + [(ones(1,8)*mean(Xsim(:,1)))' (ones(1,8)*mean(Xsim(:,2)))'] ;
plot(p1(:,1),p1(:,2),'+r','linewidth',1)
axis equal
for i=1:8
    plot([p1(i,1) Xsim(i,1)], [p1(i,2) Xsim(i,2)],'r')
end
axis equal
hold off


% PPCA
mu = mean(Xsim) ;
sig2 = 1 ;
ww=ones(2,1) ;

% Loop starts
for i=1:100
zmu = ww'*inv(ww*ww'+sig2*eye(2))*x_nor' ;
cov1 = 1- ww'*inv(ww*ww'+sig2*eye(2))*ww;

ww=(sum(x_nor.*[zmu' zmu'])*inv(cov1*8 + sum(zmu.*zmu)))' ;
sig2 = 1/(8*2)*trace(x_nor'*x_nor - ww*sum(x_nor.*[zmu' zmu'])) ;
lli(i)=sum(log(mvnpdf(Xsim,mu,(ww*ww'+sig2*eye(2))))) ;
end
% ww=ww/norm(ww);
 plot(lli)
 xlabel('Iterations')
 ylabel('Log Likelihood')
cv1=ww*ww'+sig2*eye(2) 
cv 


plot(Xsim(:,1),Xsim(:,2),'.')
x_nor=Xsim-[(ones(1,8)*mean(Xsim(:,1)))' (ones(1,8)*mean(Xsim(:,2)))'] ;
hold on;
len = 3; 
plot([len*ww(1,1)+mean(Xsim(:,1)) -len*ww(1,1)+mean(Xsim(:,1))],[len*ww(2,1)+mean(Xsim(:,2)) -len*ww(2,1)+mean(Xsim(:,2))],'k')
plot(mean(Xsim(:,1)),mean(Xsim(:,2)),'+g','linewidth',10)
proj=ww*zmu + repmat(mean(Xsim)',1,8) ;
plot(proj(1,:),proj(2,:),'+r','linewidth',1)
axis equal
for i=1:8
    plot([proj(1,i) Xsim(i,1)], [proj(2,i) Xsim(i,2)],'r')
end
axis equal
hold off

