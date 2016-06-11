clear
load('ps9_data.mat')
cnt1n = zeros(4,4) ;
cnt2n = zeros(4,4) ;
cnt3n = zeros(4,4) ;
for i=1:91
    for j=1:8
        clear spk ;
        clear hndpos 
        hndpos = train_trial(i,j).handPos ;
        for l=1:fix(size(hndpos,2)/20)-1
            hnd(1,l,i,j) = hndpos(1,l*20)/1000 ;
            hnd(2,l,i,j) = hndpos(2,l*20)/1000 ;
            hnd(3,l,i,j) = (-hndpos(1,l*20)+hndpos(1,(l+1)*20))/20 ;
            hnd(4,l,i,j) = (-hndpos(2,l*20)+hndpos(2,(l+1)*20))/20 ;
        end
        hnd_st(1,((i-1)*8)+j) = hndpos(1,1*20)/1000 ;
        hnd_st(2,((i-1)*8)+j) = hndpos(2,1*20)/1000 ;
        hnd_st(3,((i-1)*8)+j) = (-hndpos(1,1*20)+hndpos(1,(1+1)*20))/20 ;
        hnd_st(4,((i-1)*8)+j) = (-hndpos(2,1*20)+hndpos(2,(1+1)*20))/20 ;

        spk=train_trial(i,j).spikes(1,:) ;
        bin_cnt(i,j) = fix(size(spk,2)/20) - 1  ;

        for k=1:97
            spk=train_trial(i,j).spikes(k,:) ;
            for l=0:bin_cnt(i,j)-1
                sp_bn(k,l+1,i,j) = sum(spk(l*20+1:(l+1)*20)) ;
            end
        end        
    end
end
%% 
cnt1n = zeros(4,4) ;
cnt2n = zeros(4,4) ;
amat = zeros(4,4) ;
for i=1:91
    for j=1:8
        for l=1:bin_cnt(i,j)-1
            cnt1n = cnt1n +  hnd(:,l+1,i,j)*hnd(:,l,i,j)' ;
            cnt2n = cnt2n +  hnd(:,l,i,j)*hnd(:,l,i,j)' ;
        end
    end
end
amat = amat + cnt1n*inv(cnt2n) ;


cnt3n = zeros(4,4) ;
for i=1:91
    for j=1:8
        for l=1:bin_cnt(i,j)-1
            cnt3n = cnt3n +  (hnd(:,l+1,i,j)-amat*hnd(:,l,i,j))*(hnd(:,l+1,i,j)-amat*hnd(:,l,i,j))' ;
        end
    end
end
qmat = cnt3n/(sum(sum(bin_cnt)) - 91*8) ;


cnt1n = zeros(97,4) ;
cnt2n = zeros(4,4) ;
for i=1:91
    for j=1:8
        for l=1:bin_cnt(i,j)
            cnt1n = cnt1n +  sp_bn(:,l,i,j)*hnd(:,l,i,j)' ;
            cnt2n = cnt2n +  hnd(:,l,i,j)*hnd(:,l,i,j)' ;
        end
    end
end
cmat = cnt1n*inv(cnt2n) ;


cnt3n = zeros(97,97) ;
for i=1:91
    for j=1:8
        for l=1:bin_cnt(i,j)
            cnt3n = cnt3n +  (sp_bn(:,l,i,j)-cmat*hnd(:,l,i,j))*(sp_bn(:,l,i,j)-cmat*hnd(:,l,i,j))';
        end
    end
end
rmat = cnt3n/(sum(sum(bin_cnt)) - 91*8) ;

pii = (mean(hnd_st'))' ;
vv = cov(hnd_st') ;

%% Test phase

cnt1n = zeros(4,4) ;
cnt2n = zeros(4,4) ;
cnt3n = zeros(4,4) ;
for i=1:91
    for j=1:8
        clear spk ;
        clear hndpos 
        hndpos1 = test_trial(i,j).handPos ;
        for l=1:fix(size(hndpos1,2)/20)-1
            hnd1(1,l,i,j) = hndpos1(1,l*20)/1000 ;
            hnd1(2,l,i,j) = hndpos1(2,l*20)/1000 ;
            hnd1(3,l,i,j) = (-hndpos1(1,l*20)+hndpos1(1,(l+1)*20))/20 ;
            hnd1(4,l,i,j) = (-hndpos1(2,l*20)+hndpos1(2,(l+1)*20))/20 ;
        end
        spk=test_trial(i,j).spikes(1,:) ;
        bin_cnt1(i,j) = fix(size(spk,2)/20) - 1  ;

        for k=1:97
            spk=test_trial(i,j).spikes(k,:) ;
            for l=0:bin_cnt1(i,j)-1
                sp_bn1(k,l+1,i,j) = sum(spk(l*20+1:(l+1)*20)) ;
            end
        end        
    end
end



err_cnt = 0;
mu1 = pii ;
cvv1 = vv ;
for i=1:91
    for j=1:8
        l=1 ;
        mu1 = pii ;
        cvv1 = vv ;
        kt = cvv1*cmat'*inv(cmat*cvv1*cmat'+rmat) ;
        mu2 = mu1 + kt*(sp_bn1(:,l,i,j) -cmat*mu1) ; 
        cvv2 = cvv1 - kt*cmat*cvv1 ;
        hnd1_f(1:4,l,i,j) = mu2 ;        
        err_cnt = err_cnt + norm((hnd1_f(1:2,l,i,j)-hnd(1:2,l,i,j))*1000) ;

        for l=2:bin_cnt1(i,j)
            mu1 = amat*mu2 ;
            cvv1 = amat*cvv2*amat' + qmat ;      
            
            kt = cvv1*cmat'*inv(cmat*cvv1*cmat'+rmat) ;
            mu2 = mu1 + kt*(sp_bn1(:,l,i,j) -cmat*mu1) ; 
            cvv2 = cvv1 - kt*cmat*cvv1 ;
            hnd1_f(1:4,l,i,j) = mu2 ; 
            err_cnt = err_cnt + norm((hnd1_f(1:2,l,i,j)-hnd(1:2,l,i,j))*1000) ;
        end
    end
end
err_cnt = err_cnt/(sum(sum(bin_cnt1))) ;


plot(hnd1(1,1:bin_cnt1(1,1),1,1) , hnd1(2,1:bin_cnt1(1,1),1,1),'k'); hold on;
plot(hnd1_f(1,1:bin_cnt1(1,1),1,1) , hnd1_f(2,1:bin_cnt1(1,1),1,1),'r')
xlabel('Horizontal Position')
ylabel('Vertical Position')
i=1; j=1 ;
l=1 ;
        mu1 = pii ;
        cvv1 = vv ;
        kt = cvv1*cmat'*inv(cmat*cvv1*cmat'+rmat) ;
        mu2 = mu1 + kt*(sp_bn1(:,l,i,j) -cmat*mu1) ; 
        cvv2 = cvv1 - kt*cmat*cvv1 ;
        hnd1_f(1:4,l,i,j) = mu2 ;     
        func_plotEllipse(mu2(1:2),cvv2(1:2,1:2)) ;
        xcv(l)=cvv2(1,1)^0.5 ;
        ycv(l)=cvv2(2,2)^0.5 ;

        for l=2:bin_cnt1(i,j)
            mu1 = amat*mu2 ;
            cvv1 = amat*cvv2*(amat)' + qmat ;      
            
            kt = cvv1*cmat'*inv(cmat*cvv1*cmat'+rmat) ;
            mu2 = mu1 + kt*(sp_bn1(:,l,i,j) -cmat*mu1) ; 
            cvv2 = cvv1 - kt*cmat*cvv1 ;
            hnd1_f(1:4,l,i,j) = mu2 ;               
            func_plotEllipse(mu2(1:2),cvv2(1:2,1:2)) ;
            xcv(l)=cvv2(2,2)^0.5 ;
            ycv(l)=cvv2(2,2)^0.5 ;
        end

plot([1:bin_cnt1(1,1)]*20, hnd1(1,1:bin_cnt1(1,1),1,1) , 'k'); hold on;
plot([1:bin_cnt1(1,1)]*20, hnd1_f(1,1:bin_cnt1(1,1),1,1) , 'r');
plot([1:bin_cnt1(1,1)]*20, hnd1_f(1,1:bin_cnt1(1,1),1,1)-xcv , '--r'); hold on;
plot([1:bin_cnt1(1,1)]*20, hnd1_f(1,1:bin_cnt1(1,1),1,1)+xcv , '--r'); hold on;
xlabel('Time (ms)')
ylabel('Horizontal Position')


plot([1:bin_cnt1(1,1)]*20, hnd1(2,1:bin_cnt1(1,1),1,1) , 'k'); hold on;
plot([1:bin_cnt1(1,1)]*20, hnd1_f(2,1:bin_cnt1(1,1),1,1) , 'r');
plot([1:bin_cnt1(1,1)]*20, hnd1_f(2,1:bin_cnt1(1,1),1,1)-xcv , '--r'); hold on;
plot([1:bin_cnt1(1,1)]*20, hnd1_f(2,1:bin_cnt1(1,1),1,1)+xcv , '--r'); hold on;
xlabel('Time (ms)')
ylabel('Vertical Position')

hold off
pause






plot(hnd1(1,1:bin_cnt1(1,4),1,4) , hnd1(2,1:bin_cnt1(1,4),1,4),'k') ; hold on ;
plot(hnd1_f(1,1:bin_cnt1(1,4),1,4) , hnd1_f(2,1:bin_cnt1(1,4),1,4),'r')
xlabel('Horizontal Position')
ylabel('Vertical Position')
clear xcv
clear ycv
i=1; j=4 ;
l=1 ;
        mu1 = pii ;
        cvv1 = vv ;
        kt = cvv1*cmat'*inv(cmat*cvv1*cmat'+rmat) ;
        mu2 = mu1 + kt*(sp_bn1(:,l,i,j) -cmat*mu1) ; 
        cvv2 = cvv1 - kt*cmat*cvv1 ;
        hnd1_f(1:4,l,i,j) = mu2 ;     
        func_plotEllipse(mu2(1:2),cvv2(1:2,1:2)) ;
        xcv(l)=cvv2(1,1)^0.5 ;
        ycv(l)=cvv2(2,2)^0.5 ;


        for l=2:bin_cnt1(i,j)
            mu1 = amat*mu2 ;
            cvv1 = amat*cvv2*(amat)' + qmat ;      
            
            kt = cvv1*cmat'*inv(cmat*cvv1*cmat'+rmat) ;
            mu2 = mu1 + kt*(sp_bn1(:,l,i,j) -cmat*mu1) ; 
            cvv2 = cvv1 - kt*cmat*cvv1 ;
            hnd1_f(1:4,l,i,j) = mu2 ;               
            func_plotEllipse(mu2(1:2),cvv2(1:2,1:2)) ;
            xcv(l)=cvv2(1,1)^0.5 ;
            ycv(l)=cvv2(2,2)^0.5 ;
        end

plot([1:bin_cnt1(1,4)]*20, hnd1(1,1:bin_cnt1(1,4),1,4) , 'k'); hold on;
plot([1:bin_cnt1(1,4)]*20, hnd1_f(1,1:bin_cnt1(1,4),1,4) , 'r');
plot([1:bin_cnt1(1,4)]*20, hnd1_f(1,1:bin_cnt1(1,4),1,4)-xcv , '--r'); hold on;
plot([1:bin_cnt1(1,4)]*20, hnd1_f(1,1:bin_cnt1(1,4),1,4)+xcv , '--r'); hold on;
xlabel('Time (ms)')
ylabel('Horizontal Position')
        
plot([1:bin_cnt1(1,4)]*20, hnd1(2,1:bin_cnt1(1,4),1,4) , 'k'); hold on;
plot([1:bin_cnt1(1,4)]*20, hnd1_f(2,1:bin_cnt1(1,4),1,4) , 'r');
plot([1:bin_cnt1(1,4)]*20, hnd1_f(2,1:bin_cnt1(1,4),1,4)-xcv , '--r'); hold on;
plot([1:bin_cnt1(1,4)]*20, hnd1_f(2,1:bin_cnt1(1,4),1,4)+xcv , '--r'); hold on;
xlabel('Time (ms)')
ylabel('Vertical Position')
