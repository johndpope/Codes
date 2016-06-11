load('ps8_data.mat')
cv_mat=cov(Xplan);
[u,v,w]=svd(cv_mat) ;
plot(diag(v))
xlabel('Component Number')
ylabel('Sqrt(lambda)')
proj_1 = Xplan*u(:,1:3) ;

var = diag(v);
per_var = sum(var(1:3))/sum(var)*100 ;
% b
hold on
for i=0:7
    plot3(proj_1(i*91+1:(i+1)*91,1),proj_1(i*91+1:(i+1)*91,2),proj_1(i*91+1:(i+1)*91,3),'.')
end

%c
imagesc(u(:,1:3))
colorbar