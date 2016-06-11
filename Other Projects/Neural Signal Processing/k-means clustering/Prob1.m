load('ps5_data.mat')
x = RealWaveform;
f_0 = 30000; % sampling rate of waveform (Hz)
f_stop = 250; % stop frequency (Hz)
f_Nyquist = f_0/2; % the Nyquist limit
n = length(x);
f_all = linspace(-f_Nyquist,f_Nyquist,n);
desired_response = ones(n,1);
desired_response(abs(f_all)<=f_stop) = 0;
x_filtered = real(ifft(fft(x).*fftshift(desired_response)));
plot(x) ; title('Originial Waveform')

plot(x_filtered) ; title('filtered Waveform') ; hold on ;
plot([1:size(x,1)],ones(1,size(x,1))*250)
hold off ;

x_f = x_filtered ;
cnt = 1 ;
for i=2:size(x_filtered,1)-1
    if( x_f(i) > x_f(i-1) && x_f(i) > x_f(i-1) && x_f(i)>=250 )
        loc(cnt)=i;
        dat(:,cnt) = x(loc(cnt)-10:loc(cnt)+20) ; 
        plot(x(loc(cnt)-10:loc(cnt)+20))
        hold on;
        cnt = cnt + 1;
    end
end
plot([1:31],ones(1,31)*250)
hold off ;
xlim([1 31])
set(gca, 'XTick', 1:5:31); 
set(gca, 'XTicklabels', [-0.3 -0.13 0.03 0.2 0.366 0.533 0.7])
xlabel('msec')

% Two Cluster_1
[mu,assign]=k_mean(dat,InitTwoClusters_1);
plot(dat(:,assign==1),'k') ; hold on ; plot(mu(:,1),'-or') ; 
plot([1:31],ones(1,31)*250)
hold off ;
xlim([1 31])
set(gca, 'XTick', 1:5:31); 
set(gca, 'XTicklabels', [-0.3 -0.13 0.03 0.2 0.366 0.533 0.7])
xlabel('msec')

plot(dat(:,assign==2),'k') ; hold on ; plot(mu(:,2),'-or') ; 
plot([1:31],ones(1,31)*250)
hold off ;
xlim([1 31])
set(gca, 'XTick', 1:5:31); 
set(gca, 'XTicklabels', [-0.3 -0.13 0.03 0.2 0.366 0.533 0.7])
xlabel('msec')

% Two Cluster_2
[mu,assign]=k_mean(dat,InitTwoClusters_2);
plot(dat(:,assign==1),'k') ; hold on ;  plot(mu(:,1),'-or') ;
plot([1:31],ones(1,31)*250)
hold off ;
xlim([1 31])
set(gca, 'XTick', 1:5:31); 
set(gca, 'XTicklabels', [-0.3 -0.13 0.03 0.2 0.366 0.533 0.7])
xlabel('msec')


plot(dat(:,assign==2),'k') ;  hold on ; plot(mu(:,2),'-or') ;
plot([1:31],ones(1,31)*250)
hold off ;
xlim([1 31])
set(gca, 'XTick', 1:5:31); 
set(gca, 'XTicklabels', [-0.3 -0.13 0.03 0.2 0.366 0.533 0.7])
xlabel('msec')

% Three Clusters_1
[mu,assign]=k_mean3(dat,InitThreeClusters_1);
plot(dat(:,assign==1),'k') ; hold on ;  plot(mu(:,1),'-or') ;
plot([1:31],ones(1,31)*250)
hold off ;
xlim([1 31])
set(gca, 'XTick', 1:5:31); 
set(gca, 'XTicklabels', [-0.3 -0.13 0.03 0.2 0.366 0.533 0.7])
xlabel('msec')

plot(dat(:,assign==2),'k') ;  hold on ; plot(mu(:,2),'-or') ;
plot([1:31],ones(1,31)*250)
hold off ;
xlim([1 31])
set(gca, 'XTick', 1:5:31); 
set(gca, 'XTicklabels', [-0.3 -0.13 0.03 0.2 0.366 0.533 0.7])
xlabel('msec')

plot(dat(:,assign==3),'k') ; hold on ; plot(mu(:,3),'-or') ;
plot([1:31],ones(1,31)*250)
hold off ;
xlim([1 31])
set(gca, 'XTick', 1:5:31); 
set(gca, 'XTicklabels', [-0.3 -0.13 0.03 0.2 0.366 0.533 0.7])
xlabel('msec')

% Three Clusters_2
[mu,assign]=k_mean3(dat,InitThreeClusters_2);
plot(dat(:,assign==1),'k') ; hold on ; plot(mu(:,1),'-or') ;  
plot([1:31],ones(1,31)*250)
hold off ;
xlim([1 31])
set(gca, 'XTick', 1:5:31); 
set(gca, 'XTicklabels', [-0.3 -0.13 0.03 0.2 0.366 0.533 0.7])
xlabel('msec')

plot(dat(:,assign==2),'k') ; hold on ; plot(mu(:,2),'-or') ; 
plot([1:31],ones(1,31)*250)
hold off ;
xlim([1 31])
set(gca, 'XTick', 1:5:31); 
set(gca, 'XTicklabels', [-0.3 -0.13 0.03 0.2 0.366 0.533 0.7])
xlabel('msec')

plot(dat(:,assign==3),'k') ; hold on ; plot(mu(:,3),'-or') ; 
plot([1:31],ones(1,31)*250)
hold off ;
xlim([1 31])
set(gca, 'XTick', 1:5:31); 
set(gca, 'XTicklabels', [-0.3 -0.13 0.03 0.2 0.366 0.533 0.7])
xlabel('msec')

