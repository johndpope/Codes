% Parameters
clear
r0 = 35 ;
rmax=60 ;
smax=90 ;
s = [0 45*1 45*2 45*3 45*4 45*5 45*6 45*7] ;
field = 'spikes';
sptr = struct ;

% 
p = [6 3 2 1 4 7 8 9];
% 

% Spike Trains

for i=1:8
    for j=1:100 ;
lambda = r0 + (rmax-r0)*cosd(s(i)-smax);
temp = 1;
t=zeros(1,1000);
while temp<=1000
    t1=round(exprnd(1/lambda)*1000) ;
    temp = temp + t1 ;
    if(temp<=1000)
        t(temp)=1;
    end
end
sptr=setfield(sptr,{j,i},field,t) ;
    end
end

% Spike trains
for i=1:8
    subplot(3,3,p(i));
    for j=1:5
        t = sptr(j,i).spikes ;
        for spikeCount = 1:length(t)
            if(t(spikeCount)==1)
                p1=plot([spikeCount spikeCount], [j-0.4 j+0.4], 'k');
                hold on;
            end
        end
    end
    xlim([0 1000]); xlabel('time(ms)') ;
    ylim([0 6])
    hold off;
end

% Spike Histogram
t1=zeros(8,50);
for i=1:8
    for j=1:100
        t = sptr(j,i).spikes;
        for k=1:20:size(t,2)
            t1(i,round(k/20+1))= t1(i,round(k/20+1)) + sum(t(k:k+19))/20/100*1000 ;
        end
    end
    subplot(3,3,p(i));
    bar(t1(i,:)); xlim([0 50]) ; set(gca,'XTickLabel',[0:1000:1000]);
    xlabel('Time(ms)') ;
    ylabel('Firing rate') ;
    hold on;
end


% Tuning curve
t2= zeros(100,8) ;
for i=1:8
    for j=1:100
        t2(j,i)=sum(sptr(j,i).spikes);
    end
    plot(ones(100,1)*s(i),t2(:,i),'k');
    xlim([0 360]);
    hold on;
    t3(i)=mean(t2(:,i)) ;
    plot(s(i),t3(i),'-ro') 
    xlabel('s (Movement Direction in Degrees)')
    ylabel('f(Hz)');
    hold on;
end

A = [ones(8,1) cos(s') sin(s')] ;
par = inv(A'*A)*(A'*t3') ;

val(1) = par(1);
val(2) = atand(par(3)/par(2)) ;
val(3) = par(1) + par(2)/cosd(val(2)) ;
% plot(theta,val(1) + (val(3) - val(1))*cosd(theta - val(2))) ;
plot([0:315],r0 + (rmax-r0)*cosd([0:315]-smax),'Color',[0 1 0])
 
% Count Distribution
for i=1:8
    subplot(3,3,p(i));
    histogram(t2(:,i),'Normalization','pdf')
    hold on;
    lambdahat = poissfit(t2(:,i)) ;
    y = poisspdf([0:max(t2(:,i))],lambdahat) ;
    plot([0:max(t2(:,i))],y,'-r');
    xlabel('Spike Counts')
end
hold off;

% Fano Factor
for i=1:8
        mn(i) = mean(t2(:,i));
        vr(i) = var(t2(:,i)) ;
        scatter(mn,vr);
        hold on;
%        plot([1:8],mean(vr./mn)*[1:8]) ;
        plot([1:60],[1:60]) ;
        xlabel('mean (spikes)');
        ylabel('Variance (spikes^2)');
end
hold off;

% ISI Distibution

cnt = zeros(1456,8);
for i=1:8
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
    subplot(3,3,p(i));
    histogram(cnt(:,i),'Normalization','pdf') ; 
    xlim([0 120]);
    hold on ;
    pd1 = exppdf([1:50],expfit(cnt(:,i))) ;
    plot([1:50],pd1,'r')
    xlabel('t (ms)') ;
    ylabel('f_T (t)') ;
end

% Coefficient of Variation
cnt2 = zeros(1,1);

mn_in=zeros(100,8);
vr_in=zeros(100,8);
for i=1:8
    for j=1:100
        temp=1;
        t = sptr(j,i).spikes ;
        z=find(t==1);
        for k=1:size(z,2)
            if(k==1)
                cnt2(temp) = z(k)-0 ;
                temp = temp + 1;
            else
                cnt2(temp) = z(k) - z(k-1) ;
                temp =temp + 1 ;        
            end
        end
        mn_in(j,i)=mean(cnt2);
        vr_in(j,i)=var(cnt2)/1000;
    end
end
    
mn = mean(mn_in) ;
vr = mean(vr_in) ;
plot(mn,vr,'ro') ;
xlabel('average ISI (ms)');
ylabel('C_v');