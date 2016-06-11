clear
clc
r0 = 35 ;
rmax=60 ;
smax=90 ;
lambda_max = r0 + (rmax-r0)*1;
field = 'spikes';
sptr = struct ;

% 
p = [6 3 2 1 4 7 8 9];
% 

% Spike trains

for i=1:1
    for j=1:100 ;
        lambda = lambda_max;
        temp = 1;
        t=zeros(1,1000);
        while temp<=1000
            t1=round(exprnd(1/lambda)*1000) ;
            temp = temp + t1 ;
            if(temp<=1000)
                t(temp)=1;
            end
        end
        
        temp1 = find(t==1);
        for k=1:size(temp1,2)
            if(rand()>((r0 + (rmax-r0)*cosd((temp1(k)/1000*180)-smax))/lambda_max))
                t(temp1(k))=0;
            end
        end
            
        sptr=setfield(sptr,{j,i},field,t) ;
    end
end

for i=1:1
    for j=1:5
        t = sptr(j,i).spikes ;
        for spikeCount = 1:length(t)
            if(t(spikeCount)==1)
                p1=plot([spikeCount spikeCount], [j-0.4 j+0.4], 'k');
                hold on;
            end
        end
    end
    xlim([0 1000]);
    xlabel('T(ms)');
    hold off;
end


% Spike Histogram

t1=zeros(8,50);
for i=1:1
    for j=1:100
        t = sptr(j,i).spikes;
        for k=1:20:size(t,2)
            t1(i,round(k/20+1))= t1(i,round(k/20+1)) + sum(t(k:k+19))/100/20*1000 ;
        end
    end
    bar(t1(i,:)); xlim([0 50]); set(gca,'XTickLabel',[0:100:1000]);
    hold on;
end
 plot([0:50],r0+(rmax-r0)*cosd(([0:50]/50*180)-smax))
 xlabel('T(ms)');
 ylabel('Firing Rate');

% Count Distribution
t2= zeros(100,1) ;
for i=1:1
    for j=1:100
        t2(j,i)=sum(sptr(j,i).spikes);
    end
    t3(i)=mean(t2(:,i)) ;
end 

for i=1:1
    histogram(t2(:,i),'Normalization','pdf')
    hold on;
    lambdahat = poissfit(t2(:,i)) ;
    y = poisspdf([0:max(t2(:,i))],lambdahat) ;
    plot([0:max(t2(:,i))],y,'-r');
    xlabel('Spike count');
end
hold off;

% ISI Distibution

cnt = zeros(1456,8);
for i=1:1
    temp=1;
    for j=1:100
        t = sptr(j,i).spikes ;
        z=find(t==1);
        for k=1:size(z,2)
            if(k==1)
                cnt(temp,i) = z(k)-0 ;
                temp = temp + 1;
            else
                cnt(temp,i) = z(k) - z(k-1) ;
                temp =temp + 1 ;        
            end
        end
    end
    histogram(cnt(:,i),'Normalization','pdf') ; 
    xlim([0 200]);
    hold on ;
    pd1 = exppdf([1:50],expfit(cnt(:,i))) ;
    plot([1:50],pd1,'r')
    xlabel('t(ms)');
    ylabel('f_T (t)');
end
