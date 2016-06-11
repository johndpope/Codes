clear
clc
load ps2_data.mat ;

p = [6 3 2 1 4 7 8 9];
theta = [30,70,110,150,190,230,310,350];

% Spike trains
for i=1:8
    subplot(3,3,p(i));
    for j=1:5
        t = trial(j,i).spikes ;
        for spikeCount = 1:length(t)
            if(t(spikeCount)==1)
                p1=plot([spikeCount spikeCount], [j-0.4 j+0.4], 'k');
                hold on;
            end
        end
    end
    xlim([0 500]);
    ylim([0 6])
    xlabel('t (ms)');
    hold off;
end

% Spike Histogram
t1=zeros(8,25);
for i=1:8
    for j=1:182
        t = trial(j,i).spikes;
        for k=1:20:size(t,2)
            t1(i,round(k/20+1))= t1(i,round(k/20+1)) + sum(t(k:k+19))/182/20*1000 ;
        end
    end
    subplot(3,3,p(i));
    bar(t1(i,:)); xlim([0 25]); set(gca,'XTickLabel',[0:200:400]);
    xlabel('t (ms)');
    ylabel('Firing rate');
end

% Tuning curve
t2= zeros(182,8) ;
for i=1:8
    for j=1:182
        t2(j,i)=sum(trial(j,i).spikes);
    end
    plot(ones(182,1)*theta(i),t2(:,i),'k');
    xlim([0 360]);
    hold on;
    t3(i)=mean(t2(:,i)) ;
    plot(theta(i),t3(i),'-ro') ;
    hold on;
end

A = [ones(8,1) cosd(theta') sind(theta')] ;
par = inv(A'*A)*(A'*t3') ;

val(1) = par(1);
val(2) = atand(par(3)/par(2)) ;
val(3) = par(1) + par(2)/cosd(val(2)) ;
% plot(theta,val(1) + (val(3) - val(1))*cosd(theta - val(2))) ;
z=[30:350];
plot(z,[ones(size(z,2),1) cosd(z') sind(z')]*par,'Color',[0 1 0])
xlabel('s(movement direction in degrees)');
ylabel('f(Hz)');

% Count Distribution
for i=1:8
    subplot(3,3,p(i));
    histogram(t2(:,i),'Normalization','pdf')
    xlim([1 max(t2(:,i))+1])
    hold on;
    lambdahat = poissfit(t2(:,i)) ;
    y = poisspdf([0:max(t2(:,i))+1],lambdahat) ;
    plot([0:max(t2(:,i))+1],y,'-ro');
    xlabel('Spike Count');
end
hold off;

% Fano Factor
for i=1:8
        mn(i) = mean(t2(:,i));
        vr(i) = var(t2(:,i)) ;
        scatter(mn,vr);
        hold on;
%        plot([1:8],mean(vr./mn)*[1:8]) ;
        plot([1:7],[1:7]) ;
        xlabel('mean (spikes)');
        ylabel('variance (spikes^2)');
end
hold off;

% ISI Distibution

cnt = zeros(1456,8);
for i=1:8
    temp=1;
    for j=1:182
        t = trial(j,i).spikes ;
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
    hold on ;
    pd1 = exppdf([1:500],expfit(cnt(:,i))) ;
    plot([1:500],pd1)
    xlabel('t (ms)');
    ylabel('f_T (t)');
end

